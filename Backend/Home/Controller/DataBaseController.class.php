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
            'username' => 'username312' . mt_rand(1111, 9999),
            'description' => 'description',
        ];
        $redis->rPush($listKey, json_encode($val));
        $listLen = $redis->lLen($listKey);

        //哈哈，在这里触发一下哦，数据队列满的时候就插入到MySql数据库中去哦！
        $returnResult = false;
        if ($listLen > 20) {
            $returnResult = $this->RedisSaveToMysql($listKey);
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
                    $redis->expire($listKey, 30);
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

    public function test()
    {
        $redis = RedisInstance::Instance();
        $conn = $redis->connect('127.0.0.1', '6379000');
        if ($conn == true) {
            var_dump($conn);
        } else {
            echo 'Redis server went away';
        }
        var_dump($redis);

    }

    public function updateMsyql($id)
    {
        $model = new Model();
        $msql = "select * from tour_logs";
        $display_order = [
            1 => 4,
            2 => 1,
            3 => 2,
            4 => 3,
            5 => 9,
            6 => 5,
            7 => 8,
            8 => 9];
        homePrint($display_order);
        $ids = implode(',', array_keys($display_order));
        homePrint($ids);

        $sql = "UPDATE categories SET display_order = CASE id ";
        foreach ($display_order as $id => $ordinal) {
            $sql .= sprintf("WHEN %d THEN %d ", $id, $ordinal);
        }
        $sql .= "END WHERE id IN ($ids)";
        homePrint($sql);
    }

    /**
     * #################################################################################################################
     *
     * PHP之PDO预处理语句
     *
     * #################################################################################################################
     */

    //PHP官方案例
    public function pdoExample1()
    {
        $user = 'root';
        $pass = '';
        try {
            //连接数据成功后，返回一个 PDO 类的实例给脚本，此连接在 PDO 对象的生存周期中保持活动。要想关闭连接，需要销毁对象以确保所有剩余到它的引用都被删除，
            //可以赋一个 NULL 值给对象变量。如果不明确地这么做，PHP 在脚本结束时会自动关闭连接。
            $dbh = new \PDO("mysql:host=localhost;dbname=tp5", $user, $pass);
            foreach ($dbh->query("select * from tour_user") as $row) {
                print_r($row);
            }
        } catch (\PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
        // 现在运行完成，在此关闭连接
        //$dbh = null;
    }

    /**
     * 【Example #4 持久化连接】
     * 如果想使用持久连接，必须在传递给 PDO 构造函数的驱动选项数组中设置 PDO::ATTR_PERSISTENT 。
     * 如果是在对象初始化之后用 PDO::setAttribute() 设置此属性，则驱动程序将不会使用持久连接。
     */
    public function pdoExample2()
    {
        $user = 'root';
        $pass = '';
        try {
            $dbh = new \PDO("mysql:host=localhost;dbname=tp5", $user, $pass,array(\PDO::ATTR_PERSISTENT=>true));
            foreach ($dbh->query("select * from tour_user") as $row) {
                print_r($row);
            }
        } catch (\PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
    }

    /**
     * 【Example #3 持久化连接】
     *
     * 当准备好查询并绑定了相应的参数后，就可以通过调用PDOStatement类对象中的execute()方法，反复执行在数据库缓存区准备好的语句了。
     * 在下面的示例中，向前面提供的contactInfo表中，使用预处理方式连续执行同一个INSERT语句，通过改变不同的参数添加两条记录
     */
    public function pdoExample3()
    {
        $user = 'root';
        $pass = '';
        try {
            $dbh = new \PDO("mysql:host=localhost;dbname=tp5", $user, $pass,array(\PDO::ATTR_PERSISTENT=>true));
            foreach ($dbh->query("select * from tour_user") as $row) {
                print_r($row);
            }
        } catch (\PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
        $username = 'tinywan'.mt_rand(00,88);
        $password = mt_rand(000000,99999);
        $logintime = time();
        $query = "INSERT INTO tour_user (username,password,logintime) VALUES (?,?,?)";
        $stmt = $dbh->prepare($query);
        $stmt->bindParam("1",$username);
        $stmt->bindParam("2",$password);
        $stmt->bindParam("3",$logintime);
        //插入第一条
        $stmt->execute();
        //插入第二条
        $stmt->execute();
    }

    public static function connectionPdo()
    {
        $user = 'root';
        $pass = '';
        try {
            $dbh = new \PDO("mysql:host=localhost;dbname=tp5", $user, $pass,array(\PDO::ATTR_PERSISTENT=>true));
        } catch (\PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
        return $dbh;
    }


    ////第二种参数绑定
    public function pdoBindParam1()
    {
        $dbh = self::connectionPdo();
        $username = 'tinywan'.mt_rand(00,88);
        $password = mt_rand(000000,99999);
        $logintime = time();
        $query = "INSERT INTO tour_user (username,password,logintime) VALUES (?,?,?)";
        $stmt = $dbh->prepare($query);
        $insertResult = $stmt->execute([$username,$password,$logintime]);
        homePrint($insertResult);
    }

    //预处理查询在执行中替换输入参数的方式。此语法可以活动对bindParam()的调用
    public function pdoBindParam2()
    {
        $dbh = self::connectionPdo();
        $username = 'tinywan'.mt_rand(00,88);
        $password = mt_rand(000000,99999);
        $logintime = time();
        // [注意：这里的:username不可以加当引号和双引号]
        $query = "INSERT INTO tour_user (username,password,logintime) VALUES (:username,:password,:logintime)";
        $stmt = $dbh->prepare($query);
        $stmt->execute([
            ':username'=>$username,
            ':password'=>$password,
            ':logintime'=>$logintime
        ]);
        //如果执行的是INSERT语句，并且数据表有自动增长的ID字段，可以使用PDO对象中的lastInsertId()方法获取最后插入数据表中的记录ID。
        //如果需要查看其他DML语句是否执行成功，可以通过PDOStatement类对象中的rowCount()方法获取影响记录的行数
        $lastInsertId = $dbh->lastInsertId();   //最后插入数据表中的记录ID
        homePrint($lastInsertId);

        $rowCount = $stmt->rowCount();
        homePrint($rowCount); //这个意思是当前一共插入了多少条的记录
    }

    /**
     * 获取数据
     * @param $id
     */
    public function getFetch()
    {
        $dbh = self::connectionPdo();
        $query = "select user_id,username,apikey_time from tour_user";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $fetchResult = $stmt->fetch(); //获取最新的一行
        homePrint($fetchResult);

        $rowCount = $stmt->rowCount(); //该表中所有的记录数目 总共：11条
        homePrint($rowCount);
    }

    public function getFetchNum()
    {
        $dbh = self::connectionPdo();
        $query = "select user_id,username,apikey_time from tour_user";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        while($row = $stmt->fetch(\PDO::FETCH_NUM)){
            print_r($row);
            echo "<br>";
        }
    }

    //以表格的形式输出结果集
    public function getFetchTable()
    {
        $dbh = self::connectionPdo();
        $query = "select user_id,username,password from tour_user";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        echo '<table border="1" >';
        echo "<th>编号</th>";
        echo "<th>姓名</th>";
        echo "<th>密码</th>";
        while(list($user_id, $username, $logintime) = $stmt -> fetch(\PDO::FETCH_NUM)) {
            echo '<tr>';
            echo '<td>'.$user_id.'</td>';
            echo '<td>'.$username.'</td>';
            echo '<td>'.$logintime.'</td>';
            echo '</tr>';
        }
        echo '</table>';
    }

    /**
     * fetchAll()方法与上一个方法fetch()类似，但是该方法只需要调用一次就可以获取结果集中的所有行，并赋给返回的二维数组
     * fetchAll([int fetch_style [,int column_index]])
     * @param $id
     */

    public function getFetchAll()
    {
        $dbh = self::connectionPdo();
        $query = "select user_id,username,password from tour_user";
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        echo '<table border="1" >';
        echo "<th>编号</th>";
        echo "<th>姓名</th>";
        echo "<th>密码</th>";
        $allRows = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        foreach ($allRows as $row ) {
            echo '<tr>';
            echo '<td>'.$row['user_id'].'</td>';
            echo '<td>'.$row['username'].'</td>';
            echo '<td>'.$row['password'].'</td>';
            echo '</tr>';
        }
        echo '</table>';
    }


    public function thinkPhpSelfPdo($id)
    {
        $model = new Model();
        $name = '121';
        $address = '34234';
        $phone = '13669361192';
        $query = "INSERT INTO contactInfo (name,address,phone) VALUES (:name,:address,:phone)";
        $stmt = $model->prepare($query);
        $stmt->bindParam(":name", $name);
        $stmt->bindParam(":address", $address);
        $stmt->bindParam(":phone", $phone);
        $name = '爱新觉罗';
        $address = '东城';
        $phone = '88888';
    }

}
