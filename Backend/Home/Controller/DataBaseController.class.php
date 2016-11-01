<?php
namespace Home\Controller;

use Org\Util\RedisInstance;
use Think\Controller;
use Think\Exception;
use Think\Model;

class DataBaseController extends Controller
{
    public function index()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(1);
        $redisInfo = $redis->lRange('message01', 0, 10);
        var_dump($redisInfo);
        var_dump($redisInfo);
    }

    /**
     * MasterInstance Redis主实例，适合于存储数据
     */
    public function MasterInstance()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(1);
        $redisInfo = $redis->lRange('message01', 0, 10);
        var_dump($redisInfo);
    }

    /**
     * SlaveOneInstance Redis从实例，适合于读取数据
     */
    public function SlaveOneInstance()
    {
        $redis = RedisInstance::SlaveOneInstance();
        $redis->select(1);
        $redisInfo = $redis->lRange('message01', 0, 15);
        var_dump($redisInfo);
    }

    /**
     * SlaveTwoInstance Redis从实例，适合于读取数据
     */
    public function SlaveTwoInstance()
    {
        $redis = RedisInstance::SlaveTwoInstance();
        $redis->select(1);
        $redisInfo = $redis->lRange('message01', 0, 6);
        var_dump($redisInfo);
        var_dump($redisInfo);
    }

    /**
     * 连接本地的Redis实例
     */
    public function localhostRedis()
    {
        $redis = RedisInstance::Instance();
        var_dump($redis);

        $redis->connect('127.0.0.1');
        $keys = $redis->keys('*');
        var_dump($keys);
    }

    /**
     * 单列模式参考连接：http://www.cnblogs.com/hongfei/archive/2012/07/07/2580994.html
     * 【官方解释】：
     * 如果两个对象是同一个类的实例，且它们有相同的属性和值，则这两个对象相等。类似的规则还适用与用全等符（===）对两个对象的比较。
     * http://php.net/manual/zh/oop4.object-comparison.php
     * 是否是同一个对象的比较
     * 比较结果：
     * 【redis1和redis2：是同一个实例--redis1和redis3：是同一个实例--redis2和redis3：是同一个实例--】
     * 对象$redis1,$redis2,$redis3实际上都是使用同一个对象实例，访问的都是同一块内存区域
     *
     */
    public function ObjectCompare()
    {

        $redis1 = RedisInstance::MasterInstance();
        $redis2 = RedisInstance::SlaveOneInstance();
        $redis3 = RedisInstance::SlaveTwoInstance();
        if ($redis1 === $redis2) {
            echo 'redis1和redis2：是同一个实例--';
        } else {
            echo '不是同一个实例';
        }

        if ($redis1 === $redis3) {
            echo 'redis1和redis3：是同一个实例--';
        } else {
            echo '不是同一个实例';
        }

        if ($redis3 === $redis2) {
            echo 'redis2和redis3：是同一个实例--';
        } else {
            echo '不是同一个实例';
        }

    }

    /**
     * php cli模式执行php文件
     * 模拟队列发送邮件
     */
    public function executeCli()
    {
        $dir = 'D:\wamp\bin\php\php5.5.12>php.exe';
        exec("D:\wamp\bin\php\php5.5.12>php.exe ../cli_test.php");
    }

    /**
     * php cli模式执行php文件
     * D:\wamp\bin\php\php5.5.12>php.exe ../cli_test.php
     */
    public function cli_test()
    {
        $count = 0;
        while (true) {
            $count++;
            file_put_contents("./test_result.txt", $count . "\r\n", FILE_APPEND);
            if ($count > 10) {
                break;
            }
            sleep(3);
        }
        echo 'done';
    }

    /**
     * 使用队列生成reids测试数据
     * 成功：执行 RPUSH操作后，返回列表的长度：8
     * 添加数据的时候，不需用设置过期时间，等到第一次从Mysql数据库中获取数据的时候在设置过期时间就可以了
     */
    public function createRedisList($listKey = 'message01')
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(2);
//
        $val = [
            'username' => 'username312'.mt_rand(1111,9999),
            'description' => 'description',
        ];
        $redis->rPush($listKey, json_encode($val));
        $listLen = $redis->lLen($listKey);

        //哈哈，在这里触发一下哦，数据队列满的时候就插入到MySql数据库中去哦！
        $returnResult = false;
        if($listLen > 20){
           $returnResult =  $this->RedisSaveToMysql($listKey);
        }
        homePrint($returnResult);
        var_dump($listLen);
    }

    /**
     * 第一种方法
     * 消息Redis方法保存到Mysql数据库
     * @param string $liveKey
     */
    public function RedisSaveToMysql($listKey = 'message01')
    {
        if (empty($listKey)) {
            $result = ["errcode" => 500, "errmsg" => "this parameter is empty!"];
            exit(json_encode($result));
        }
        $redis = RedisInstance::MasterInstance();
        $redis->select(2);
        $redisInfo = $redis->lRange($listKey, 0, 5);
        $dataLength = $redis->lLen($listKey);
        $model = M("User");
        while ($dataLength > 25) {
            try {
                $model->startTrans();
                $redis->watch($listKey);
                $arrList = [];
                foreach ($redisInfo as $key => $val) {
                    $arrList[] = array(
                        'username' => json_decode($val, true)['userName'],
                        'logintime' => json_decode($val, true)['createTime'],
                        'description' => json_decode($val, true)['content'],
                        'pido' => json_decode($val, true)['content']
                    );
                }
                $insertResult = $model->addAll($arrList);
                if (!$insertResult) {
                    $model->rollback();
                    $result = array("errcode" => 500, "errmsg" => "Data Insert into Fail!", 'data' => 'dataLength:' . $dataLength);
                    exit(json_encode($result));
                }
                $model->commit();
                $redis->lTrim($listKey, 6, -1);
                $redisInfo = $redis->lRange($listKey, 0, 5);
                $dataLength = $redis->lLen($listKey);
            } catch (Exception $e) {
                $model->rollback();
                $result = array("errcode" => 500, "errmsg" => "Data Insert into Fail!");
                exit(json_encode($result));
            }
        }
        $result = array("errcode" => 200, "errmsg" => "Data Insert into Success!", 'data' => 'dataLength:' . $dataLength . 'liveKey:' . $listKey);
        exit(json_encode($result));
    }


    /**
     * Phalcon 框架的
     * 消息Redis方法保存到Mysql数据库
     * @param string $liveKey
     */
    public function RedisSaveToMysqlPhalcon($listKey = 'message01')
    {
        if (empty($listKey)) {
            $result = ["errcode" => 500, "errmsg" => "this parameter is empty!"];
            exit(json_encode($result));
        }
        $redis = new \Redis();
        $redis->connect('10.51.24.116', '6379');
        $redisInfo = $redis->lRange($listKey, 0, 99);
        $dataLength = $redis->lLen($listKey);
        while ($dataLength > 200) {
            try {
                $this->db->begin();
                $sql = "INSERT INTO livecomment (liveId,username,createTime,userId,content) VALUES";
                foreach ($redisInfo as $action) {
                    $sql .= "('" . json_decode($action, true)['roomId'] . "',
                    '" . json_decode($action, true)['userName'] . "',
                    '" . json_decode($action, true)['createTime'] . "',
                    '" . json_decode($action, true)['userId'] . "',
                    '" . json_decode($action, true)['content'] . "'),";
                }
                $sql = rtrim($sql, ',');
                $this->db->execute($sql);
                $redis->set('message_insert_success', '1');
                $redis->lTrim($listKey, 100, -1);
                $redisInfo = $redis->lRange($listKey, 0, 99);
                $dataLength = $redis->lLen($listKey);
                $redis->set('dataLength_backenk', $dataLength);
                $this->db->commit();
            } catch (\Exception $e) {
                $redis->set('message_insert_fail', '0');
                $this->db->rollback();
            }
        }
        $redis->set('log' . $listKey, $redis->incr('request_counts'));
        $result = array("errcode" => 200, "errmsg" => "Data Insert into Success!", 'data' => 'dataLength:' . $dataLength . 'liveKey:' . $listKey);
        return $this->toJson($result);
    }

    /**
     * [0]检查当前Redis是否连接成功
     * [1]获取数据，首先从Redis中去获取，没有的话再从数据库中去获取
     */
    public function findDataRedisOrMysql($listKey = 'message01')
    {
        //Check the current connection status 查看服务是否运行
        if (RedisInstance::MasterInstance() != false) {
            $redis = RedisInstance::MasterInstance();
            $redis->select(2);
            /**
             * 首先从Redis中去获取数据
             * lRange 获取为空的话，则表示没有数据，否则返回一个非空数组
             */
            $redisData = $redis->lRange($listKey, 0, 9);
            $resultData = [];
            if (!empty($redisData)) {
                $resultData['status_code'] = 200;
                $resultData['msg'] = 'Data Source from Redis Cache';
                foreach ($redisData as $key => $val) {
                    $resultData['listData'][] = json_decode($val, true);
                }
            } else {
                $resultData['redis_msg'] = 'Redis is Expire';
                $conditions = array('status' => ':status');
                $mysqlData = M('User')->where($conditions)->bind(':status', 1, \PDO::PARAM_STR)->select();
                if ($mysqlData) {
                    $resultData['status_code'] = 200;
                    $resultData['mysql_msg'] = 'Data Source from Mysql is Success';
                    $redis->select(2);
                    foreach ($mysqlData as $key => $val) {
                        $resultData['listData'][] = $val;
                        //写入Redis作为缓存
                        $redis->rPush($listKey, json_encode($val));
                    }
                    //同时设置一个过期时间
                    $redis->expire($listKey,30);
                } else {
                    $resultData['status_code'] = 500;
                    $resultData['mysql_msg'] = 'Data Source from Mysql is Fail';
                }
            }
        } else {
            $resultData['redis_msg'] = 'Redis server went away';
            $resultData['mysql_msg'] = 'Mysql Data2';
            $conditions = array('status' => ':status');
            $mysqlData = M('User')->where($conditions)->bind(':status', 1, \PDO::PARAM_STR)->select();
            foreach ($mysqlData as $key => $val) {
                $resultData['listData'][] = $val;
            }
        }
        homePrint($resultData);
    }

    /**
     * 获取Redis数据
     * 如果是14 的话 大于10条，满足条件的话，则截取列表长度是多少
     */
    public function getRedisData()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(1);
        $redisInfo = $redis->lRange('message01', 0, 20);
        $dataLength = $redis->lLen('message01');
        // 10 14 19 20 21
        if ($dataLength > 20) {
            $redis->lTrim('message01', 10, -1);
            var_dump($dataLength);
        } else {
            echo '不可以删除了,只剩下:' . $dataLength . '条了';
            var_dump($redisInfo);
        }
        foreach ($redisInfo as $value) {
            $newArr[] = json_decode($value, true);
        }
        var_dump($newArr);
        die;
    }


    /*
     * TP 自带批量插入数据的方法
     */
    public function addAll($dataList, $options = array(), $replace = false)
    {
        if (empty($dataList)) {
            $this->error = L('_DATA_TYPE_INVALID_');
            return false;
        }
        // 数据处理
        foreach ($dataList as $key => $data) {
            $dataList[$key] = $this->_facade($data);
        }
        // 分析表达式
        $options = $this->_parseOptions($options);
        // 写入数据到数据库
        $result = $this->db->insertAll($dataList, $options, $replace);
        if (false !== $result) {
            $insertId = $this->getLastInsID();
            if ($insertId) {
                return $insertId;
            }
        }
        return $result;
    }

    public function test(){
        $aa = '4001:user_id';
        $messageId = explode(':',$aa);
        switch($messageId[0]){
            case 4001:

        }
        echo $messageId[1];
    }

}
