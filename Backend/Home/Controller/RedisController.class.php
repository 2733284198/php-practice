<?php
namespace Home\Controller;

use Org\Util\Database;
use Org\Util\Gateway;
use Org\Util\RedisInstance;
use Org\Util\RedisTest;
use Think\Controller;

class RedisController extends Controller
{
    // 根据URl窃取域名
    public function domainName(){
        preg_match("/^(rtmp:\/\/)?([^\/]+)/i", "rtmp://120.26.206.180/live/4001482369935?vhost=121.40.214.99", $matches);
        $host = $matches[2];
        var_dump($matches);
    }

    // 限制IP地址短时间类访问
    public function Demo(){
        preg_match("/^(rtmp:\/\/)?([^\/]+)/i", "rtmp://120.26.206.180/live/4001482369935?vhost=121.40.214.99", $matches);
        $host = $matches[2];
        var_dump($matches);
        var_dump($host);

    }

    public function Demo3(){
        $redis = RedisInstance::MasterInstance();
        $redis->select(12);
        echo 'demo';
        var_dump($redis->hGetAll('aMai_notify_url_time'));

    }

    public function redistest(){
        $redis = RedisInstance::MasterInstance();
        $redis->select(12);
        $clientIP = $_SERVER['REMOTE_ADDR'];
        $clientKey = "speed:limiting:{$clientIP}";
        $listClientIpLen = $redis->llen($clientKey);
        $time = time();
        echo $listClientIpLen."<br/>";
        echo $clientKey."<br/>";
        echo $time."<br/>";
        if($listClientIpLen > 10 ){
            $clientIPexpireTime = $redis->lIndex($clientKey,-1); //获取最后一个索引文件
            if($time - $clientIPexpireTime < 60 ){
                exit('超出限制');
            }else{
                $redis->lPush($clientKey,$time);
                $redis->lTrim($clientKey,0,9);
            }
        }
        $redis->lPush($clientKey,$time);
        //逻辑继续往下去写就是
        CURL_GET_REQUEST_HTTP();
        die;
    }

    //获取最新的10条数据
    public function comment()
    {
        $redis = RedisInstance::getInstance();
        $redis->select(2);
        $time = date('Y-m-d H:i:s', time());
        if (isset($_REQUEST['comment'])) {
            //有新评论，添加到列表中
            $redis->lPush('latest-comment',
                $_REQUEST['id'] . '|' . $time . '|' . $_REQUEST['comment'] . rand(00000, 99999)
            );
            //只保留最新的10条，其他都丢掉
            $redis->lTrim('latest-comment', 0, 9);
            //存入数据库
            $redis->hMset('h-id:' . time(), [
                'time' => $time,
                'user_id' => $_REQUEST['id'],
                'enjoye' => $_REQUEST['id'],
                'image' => $_REQUEST['id'],
                'content' => $_REQUEST['comment'],
            ]);
            $redis->zAdd('z-id:' . time(), time(), $_REQUEST['id'] . '|' . $time . '|' . $_REQUEST['comment'] . rand(00000, 99999));
        } else {
            //取出最新的10条评论
            $comments = $redis->lRange('latest-comment', 0, 9);
            foreach ($comments as $comment) {
                $latest[] = [
                    'id' => explode('|', $comment)[0],
                    'time' => explode('|', $comment)[1],
                    'content' => explode('|', $comment)[2],
                ];
            }
            var_dump($latest);
        }
    }

    /**
     * 消息Redis方法保存到Mysql数据库
     * @param string $liveKey
     */
    public function redisSaveMysqlAction()
    {
        $liveKey = $this->request->getQuery('liveKey');
        if(empty($liveKey)){
            $result = array("errcode" => 500, "errmsg" => "this parameter is empty!");
            return $this->toJson($result);
        }
        $redis = new \Redis();
        $redis->connect('10.51.24.116', '6379');
        $redisInfo = $redis->lRange($liveKey,0,99);
        $dataLength = $redis->lLen($liveKey);
        while($dataLength > 200) {
            try {
                $this->db->begin();
                foreach ($redisInfo as $action) {
                    $sql = "INSERT INTO livecomment (liveId,username,createTime,userId,content) VALUES (?, ? ,?,? ,?)";
                    $this->db->execute($sql, array(
                        json_decode($action,true)['roomId'],
                        json_decode($action,true)['userName'],
                        json_decode($action,true)['createTime'],
                        json_decode($action,true)['userId'],
                        json_decode($action,true)['content'],
                    ));
                }
                $redis->set('message_insert_success', '1');
                $redis->lTrim($liveKey, 100, -1);
                $redisInfo = $redis->lRange($liveKey,0,99);
                $dataLength = $redis->lLen($liveKey);
                $redis->set('dataLength_backenk', $dataLength);
                $this->db->commit();
            } catch (\Exception $e) {
                $redis->set('message_insert_fail', '0');
                $this->db->rollback();
            }
        }
        $redis->set('log'.$liveKey,$redis->incr('request_counts'));
        $result = array("errcode" => 200, "errmsg" => "Data Insert into Success!",'data'=>'dataLength:'.$dataLength.'liveKey:'.$liveKey);
        return $this->toJson($result);
    }

    /**
     * 创建一个Reids测试数据
     */
    public function createRedisAction()
    {
        $redis = new \Redis();
        $redis->connect('10.51.24.116', '6379');
        $message = [
            'type' => 'say',
            'userId' => $redis->incr('user_id'),
            'userName' => 'Tinywan'.mt_rand(100,9999), //是否正在录像
            'userImage' => '/res/pub/user-default-w.png', //是否正在录像
            'openId' => 'openId'.mt_rand(100000,9999999999999999),
            'roomId' => 'openId'.mt_rand(30,50),
            'createTime' => date('Y-m-d H:i:s', time()),
            'content' => $redis->incr('content') //当前是否正在打流状态
        ];
        $rPushResul = $redis->rPush('L02367Comments', json_encode($message)); //执行成功后返回当前列表的长度 9
        var_dump($rPushResul);
        die();
    }

    /**
     * 直接尝试这去实例化Redis 【不建议】
     */
    public function index()
    {
        $string = "<h1>你们好啊!<h1>";
        $redis = htmlspecialchars($string);
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        var_dump($redis->keys('*'));
        $it = NULL; /* Initialize our iterator to NULL */
        $redis->setOption(\Redis::OPT_SCAN, \Redis::SCAN_RETRY); /* retry when we get no keys back */
        while($arr_keys = $redis->scan($it)) {
            foreach($arr_keys as $str_key) {
                echo "Here is a key: $str_key\n";
            }
            echo "No more keys to scan!\n";
        }
    }

    /**
     * Scan 扫描键的键空间
     * SCAN命令系列的选项，指示是否抽象用户的空结果。
     * 如果设置为SCAN_NORETRY（默认），phpredis将一次只发出一个SCAN命令，有时返回一个空数组结果。
     * 如果设置为SCAN_RETRY，phpredis将重试扫描命令直到键返回或Redis返回一个零的迭代器
     * /
     */
    public function scan()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $iterator = NULL; /* 将我们的迭代器初始化为NULL */
        $redis->setOption(\Redis::OPT_SCAN, \Redis::SCAN_RETRY); /* 当我们没有回到钥匙时重试 */
        var_dump($redis->scan($iterator));
        echo count($redis->scan($iterator));
//        while($arr_keys = $redis->scan($it)) {
//            foreach($arr_keys as $str_key) {
//                echo "Here is a key: $str_key<br/>";
//            }
//            echo "No more keys to scan!\n";
//        }
    }
    // scan 使用正则表达式
    public function scanPattern()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $iterator = NULL; /* 将我们的迭代器初始化为NULL */
        $redis->setOption(\Redis::OPT_SCAN, \Redis::SCAN_RETRY); /* 当我们没有回到钥匙时重试 */
        while($arr_keys = $redis->scan($iterator,'*post:*')) {
            foreach($arr_keys as $str_key=>$str_value) {
                homePrint("$str_key => $str_value\n");
            }
            //echo "No more keys to scan!\n";
        }
    }


    /**
     * 说明：扫描成员HASH值，使用可选模式和计数
     * 关键：字符串  迭代器：长（参考）  模式：可选模式来匹配  计数：有多少键在一展身手返回（仅sugestion到Redis的）
     * 返回值:数组  成员的数组匹配我们的模式
     */
    public function hScan()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $it = null;
        //*不要返回一个空数组，直到我们完成迭代*
        $redis->setOption(\Redis::OPT_SCAN,\Redis::SCAN_RETRY);
        while ($arr_key = $redis->hScan('post:1',$it)){
            foreach ($arr_key as $str_filed=>$str_value){
                homePrint("$str_filed => $str_value\n");
            }
        }
        echo '11111111';
    }

    // sScan  使用正则表达式
    public function sScan()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $it = NULL;
        $redis->setOption(\Redis::OPT_SCAN, \Redis::SCAN_RETRY); /* don't return empty results until we're done */
        while($arr_mems = $redis->sScan('set', $it, "*pattern*")) {
            foreach($arr_mems as $str_mem) {
                echo "Member: $str_mem\n";
            }
        }

        $it = NULL;
        $redis->setOption(\Redis::OPT_SCAN, \Redis::SCAN_NORETRY); /* return after each iteration, even if empty */
        while(($arr_mems = $redis->sScan('set', $it, "*pattern*"))!==FALSE) {
            if(count($arr_mems) > 0) {
                foreach($arr_mems as $str_mem) {
                    echo "Member found: $str_mem\n";
                }
            } else {
                echo "No members in this iteration, iterator value: $it\n";
            }
        }
        echo 'sScan';
        homePrint($redis->getLastError());
    }

    /**
     * 说明：一种实用程序方法前面加上前缀设置phpredis值
     */
    public function my_prefix()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->setOption(\Redis::OPT_PREFIX, 'my-prefix:');
        $redis->set('tinywan','tinywanvalu');
        $redis->_prefix('my-value');
        homePrint($redis->get('tinywan'));
    }

    /**
     * 说明：设置客户端选项。
     */
    public function setOption()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->setOption(\Redis::OPT_SERIALIZER, \Redis::SERIALIZER_NONE);   // 不要序列化数据
        $redis->setOption(\Redis::OPT_SERIALIZER, \Redis::SERIALIZER_PHP);    // 使用内置的serialize / unserialize
        $redis->setOption(\Redis::OPT_SERIALIZER, \Redis::SERIALIZER_IGBINARY);   // 使用igBinary serialize / unserialize
        $redis->setOption(\Redis::OPT_PREFIX, 'myAppName:'); // 在所有键上使用自定义前缀\
        $redis->setOption(\Redis::OPT_SCAN, \Redis::SCAN_NORETRY);
        $redis->setOption(\Redis::OPT_SCAN, \Redis::SCAN_RETRY);
    }

    /**
     * 说明：设置客户端选项。
     */
    public function getOption()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->setOption(\Redis::OPT_SERIALIZER,\Redis::SERIALIZER_PHP); // 不要序列化数据
        homePrint($redis->getOption(\Redis::OPT_SERIALIZER));   // 不要序列化数据
    }

    /**
     * 说明：返回最后磁盘的时间戳保存。
     */
    public function lastSave()
    {
        $redis = RedisInstance::MasterInstance();
        echo $redis->lastSave();
    }

    /**
     * 说明：返回最后磁盘的时间戳保存。
     */
    public function slowLog()
    {
        $redis = RedisInstance::MasterInstance();
        homePrint($redis->slowlog('get'));
    }

    /**
     *  用户注册信息
     */
    public function userRegister()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $username = 'tinywan'.mt_rand(0000,8888);
        $password = '123456';
        //获取全局userId
        $userId = $redis->incr('global:userId');
        $redis->hMset('user:'.$userId,[
            'userId'=>$userId,
            'password'=>$password,
            'username'=>$username,
        ]);
        $redis->set('user:'.$username,$userId);
        //存储userId .用户排序功能 使用队列链表进行排序 50个最新的UserId
        $redis->lPush('lastNewUserId',$userId);
        //之存储50条，使用截取
        $redis->lTrim('lastNewUserId',0,49);

    }

    /**
     *      用于登录信息
     */
    public function userLogin()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $username = 'tinywan6656';
        $password = '123456';
        $uid = $redis->get('user:'.$username);
        if($uid == false){
            exit('该用户名不存在');
        }
        $oldpwd = $redis->hGet('user:'.$uid,'password');
        if($password != $oldpwd){
            exit('密码错误');
        }
        echo '登录成功，跳转';
        homePrint($uid);
    }

    /**
     *   发表微博
     */
    public function createContentByUserId($userId = 2)
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $time = time();
        $content = 'content'.mt_rand(5555,9999);
        $postId = $redis->incr('global:postid');
        $redis->hMset('post:'.$postId,[
            'userId' => $userId,
            'username' => $redis->hGet('user:'.$userId,'username'),
            'time' => $time,
            'content' => $content,
        ]);
        //把微博推送给自己的分析
        $fans = $redis->sMembers('followers:' . $userId); //获取自己的粉丝数

        //对粉丝挨个推送微博
        $fans[] = $userId; //自己发送的微博自己也可以看得到
        foreach($fans as $fanId){
            $redis->lPush('receivePost:'.$fanId,$postId);
        }
        homePrint($redis->hGetAll('post:'.$postId));
    }

    /**
     * 最新注册的用户
     * 注意：学习这里的Sort()命令;
     */
    public function getLastUserId()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $lastNewUserIdArray = $redis->sort('lastNewUserId', [
                'sort' => 'desc',
                'limit' => array(0, 10),
                'hGet'=>'user:*'
            ]
        );
        var_dump($lastNewUserIdArray);
    }

    /**
     * 对某人关注的信息：
     * 对某人进行关注和关注自己的用户信息
     * 设置两个集合进行操作
     * void
     * @param $targetUser
     * @param $user
     * following 关注了谁
     * followers 关注我的人【粉丝集合群】
     */
    public function userFollow($targetUser='2', $userId=2)
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $userName = 'tinywan6656'; //粉丝用户名 userID =2
        $fenSiId = $redis->get('user:'.$userName); //取出该用户
        if($fenSiId == false){
            exit('非法的用户名');
        }
        // ismembers  判断该用户是不是该集合的元素
        $isFollowing = $redis->sIsMember('following:'.$userId,$fenSiId);

        if($isFollowing){
            echo '已经是粉丝了，取消关注';
        }else{
            echo '你还不是粉丝了，点击关注';
            // 关注我的粉丝集合（被关注者的粉丝列表）
            $redis->sAdd('followers:'. $userId,$fenSiId); //给自己集合中添加该粉丝
            //自己关注的人的集合
            $redis->sAdd('following:'.$fenSiId,$userId);  //关注的人给自己集合中增加一条，我关注了谁
        }
        //获取粉丝数
        $allFollowers = $redis->sCard('followers:' . $userId); //获取粉丝数
        //设置粉丝个数
        $redis->hset('user:' . $userId, 'fans', $allFollowers);
    }

    /**
     * 获取最新微博数
     */
    public function getLastPostByUserId($userId = 3){
        //之获取最新的50条记录
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $redis->lTrim('receivePost:'.$userId,0,49);
        $newPosts = $redis->sort('receivePost:'.$userId,[
            'sort' => 'desc',
            'hGetAll' => "post:*"
        ]);
        $postList = [];
        foreach($newPosts as $post){
            $postList[] = [
                'userId' => $redis->hGet('post:'.$post,'userId'),
                'username' => $redis->hGet('post:'.$post,'username'),
                'time' => word_time($redis->hGet('post:'.$post,'time')),
                'content' => $redis->hGet('post:'.$post,'content'),
            ];
        }
        var_dump($postList);
    }

    public function getUserNameById($uid){
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $user = $redis->hGet('user:'.$uid,'username');
        return $user;
    }

    public function sendToClient()
    {
        Gateway::$registerAddress = '120.26.220.223:1238';
        $message = [
            'user_id' => '999999',
            'show' => 0,   // 这个是二维码扫描进入的那个页面是否直播信息链接显示
            'bindUid' => 1,  // 判断clientId是否和Userid已经绑定, 1:已经绑定 ，0:没有绑定
            'is_repeal' => 0,  // 1：正在维修的话，则一直可以检查权限。 0：表示已经维修结束了，就不需用再去判断是都有权限了
            'publish_time' => date('Y-m-d h:i:s', time())
        ];
        Gateway::sendToAll(json_encode($message));
    }


    /**
     * 对某人进行关注
     * void
     * @param $targetUser
     * @param $user
     */
    public function follow($targetUser, $user)
    {
        $configMaster = array('host' => '127.0.0.1', 'port' => 6379, 'auth' => 'mastertestpassword');
        $redisWrite = RedisInstance::getInstance($configMaster);
        //自己关注的列表
        $followingKey = 'following:' . $user['uid'];
        $redisWrite->sadd($followingKey, $targetUser['uid']);
        //被关注者的粉丝列表
        $followersKey = 'followers:' . $targetUser['uid'];
        $redisWrite->sadd($followersKey, $user['uid']);
        $followers = $redisWrite->sCard($followersKey); //获取粉丝数
        $redisWrite->hset('user:' . $targetUser['uid'], 'fans', $followers);
    }

    /**
     * 对某人取消关注
     * void
     * @param $targetUser
     * @param $user
     */
    function unfollow($targetUser, $user)
    {
        $configMaster = array('host' => '127.0.0.1', 'port' => 6379, 'auth' => 'mastertestpassword');
        $redisWrite = RedisInstance::getInstance($configMaster);
        //自己关注的列表
        $followingKey = 'following:' . $user['uid'];
        $redisWrite->sRem($followingKey, $targetUser['uid']);
        //被关注者的粉丝列表
        $followersKey = 'followers:' . $targetUser['uid'];
        $redisWrite->sRem($followersKey, $user['uid']);
        $followers = $this->redis->sCard($followersKey);
        //获取粉丝数
        $redisWrite->hset('user:' . $targetUser['uid'], 'fans', $followers);
    }

    /**
     * 用户自己的微博数据
     * array
     * @param $uid
     * @return array
     */
    function getUserPosts($uid)
    {
        $postList = array();
        $post_ids = $this->redis->lRange("$uid:posts", 0, -1);
        //获取微博的内容
        foreach ($post_ids as $post_id) {
            $post_line = $this->redis->get("post:$post_id");
            $postList[] = $this->convert($post_line);
        }
        return $postList;
    }

    /**
     * mixed
     * @return mixed
     */
    function getNextPostId()
    {
        $this->redis->incr('next_post_id');
        return $this->redis->get('next_post_id');
    }

    /**
     * void
     * @param $content
     */
    function add($content)
    {
        #创建投稿id
        $next_post_id = $this->getNextPostId();
        $uid = $this->base->user['uid'];
        #保存投稿数据
        $this->redis->set('post:' . $next_post_id, $uid . '|' . $this->base->time . '|' . $content);
        #包含全部用户微博的时间线中追加投稿id
        $this->redis->lPush('timeline', $next_post_id);
        #所有粉丝的时间线中追加投稿id,包括自己
        $followers = $this->redis->sMembers("followers:$uid");
        $followers[] = $uid; //加上自己
        foreach ($followers as $follower_uid) {
            $this->redis->lPush("timeline:$follower_uid", $next_post_id);
        }
        #往自己的微博数据中追加投稿id
        $this->redis->lPush("$uid:posts", $next_post_id);
        #增加发微博的条数
        $this->redis->hIncrBy("user:$uid", 'posts', 1);

    }

    public function getDefine()
    {
        var_dump(C('REDIS_CONFIG')['HOST']);
    }
}