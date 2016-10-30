<?php
namespace Home\Controller;

use Org\Util\RedisInstance;
use Think\Controller;
use Think\Model;

class DataBaseController extends Controller
{
    public function index()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(1);
        $redisInfo = $redis->lRange('message01', 0, 10);
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
     */
    public function createRedisList($listKey = 'message01')
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(1);
        $message = [
            'type' => 'say',
            'userId' => $redis->incr('user_id'),
            'userName' => 'Tinywan' . mt_rand(100, 9999), //是否正在录像
            'userImage' => '/res/pub/user-default-w.png', //是否正在录像
            'openId' => 'openId' . mt_rand(100000, 9999999999999999),
            'roomId' => 'openId' . mt_rand(30, 50),
            'createTime' => date('Y-m-d H:i:s', time()),
            'content' => $redis->incr('content') //当前是否正在打流状态
        ];
        $rPushResul = $redis->rPush($listKey, json_encode($message)); //执行成功后返回当前列表的长度 9
        return $rPushResul;
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
            $redis->select(1);
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
                $mysqlData = M('User')->where($conditions)->bind(':status',1, \PDO::PARAM_STR)->select();
                if($mysqlData){
                    $resultData['status_code'] = 200;
                    $resultData['mysql_msg'] = 'Data Source from Mysql is Success';
                    foreach ($mysqlData as $key => $val) {
                        $resultData['listData'][] = $val;
                    }
                }else{
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

    /**
     * 获取Redis数据批量保存到Mysql数据库
     */
    public function RedisSaveToMysql($dataList = 'Message01')
    {
        $sql = "insert into twenty_million (value) values";
        for ($i = 0; $i < 10; $i++) {
            $sql .= "('50'),";
        };
        $sql = substr($sql, 0, strlen($sql) - 1);
        var_dump($sql);
        die;
        if (empty($dataList)) {
            $this->error = L('_DATA_TYPE_INVALID_');
            return false;
        }
        $redis = RedisInstance::getInstance();
        $redis->select(1);
        $redisInfo = $redis->lRange('message01', 0, 9);
        $dataLength = $redis->lLen('message01');
//        var_dump($redisInfo);
        $model = new  Model();

//        $sql = "INSERT INTO tour_user (username,description) VALUES ('tingywan','123123')";
//        $result = $model->query($sql);
//        var_dump($result);
//        die;
        $redis->set('dataLength_front', $dataLength);
        try {
            $model->startTrans();
            foreach ($redisInfo as $action) {
                $sql = "INSERT INTO tour_user (username,description) VALUES (
                    json_decode($action,true)['userName'],
                    json_decode($action,true)['content'],
                    )";
                $result = $model->query($sql);
            }
            $redis->set('message_insert_success', '00000');
//                $redis->lTrim('message01', 10, -1);
//                $redisInfo = $redis->lRange('message01',0,9);
//                $dataLength = $redis->lLen('message01');
//                $redis->set('dataLength_backenk', $dataLength);
            $model->commit();
        } catch (\Exception $e) {
            $redis->set('message_catch', json_encode($e));
            $model->rollback();
        }

        var_dump($result);
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

}