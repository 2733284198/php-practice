<?php
namespace Home\Controller;

use Org\Util\Gateway;
use Org\Util\RedisInstance;
use Org\Util\RedisTest;
use Think\Controller;

class RedisController extends Controller
{
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
     */
    public function scan()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $it = NULL; /* 将我们的迭代器初始化为NULL */
        $redis->setOption(\Redis::OPT_SCAN, \Redis::SCAN_RETRY); /* 当我们没有回到钥匙时重试 */
        var_dump($redis->scan($it));
//        while($arr_keys = $redis->scan($it)) {
//            foreach($arr_keys as $str_key) {
//                echo "Here is a key: $str_key<br/>";
//            }
//            echo "No more keys to scan!\n";
//        }
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
        if($redis->get('user:username:'.$username.':userid')){
            exit('该用户名没有被使用');
        }
        //获取全局userId
        $userId = $redis->incr('global:userid');
        $redis->set('user:userId:'.$userId.':username',$username);
        $redis->set('user:userId:'.$userId.':password',$password);
        $redis->set('user:username:'.$username.':userid',$userId);

        //存储userId 用户排序功能 使用队列链表进行排序 50个最新的UserId
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
        $username = 'tinywan3704';
        $password = '123456';
        $uid = $redis->get('user:username:'.$username.':userid');
        if($uid == false){
            exit('该用户名不存在');
        }
        $oldpwd = $redis->get('user:userId:'.$uid.':password');
        if($password != $oldpwd){
            exit('密码错误');
        }
        echo '登录成功，跳转';
        homePrint($uid);
    }

    /**
     *   发表微博
     */
    public function createContentByUserId()
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $userId = 2;
        $time = time();
        $content = 'content'.mt_rand(5555,9999);
        $postId = $redis->incr('global:postid');
        $redis->set('post:postid:'.$postId.':userid',$userId);
        $redis->set('post:postid:'.$postId.':time',$time);
        $redis->set('post:postid:'.$postId.':content',$content);
        //把微博推送给自己的分析

        $fans = $redis->sMembers('followers:' . $userId); //获取自己的粉丝数
        //对粉丝挨个推送微博
        $fans[] = $userId;
        foreach($fans as $fanId){
            $redis->lPush('revicePost:'.$fanId,$postId);
        }
        var_dump($fans);die;

        homePrint($redis->get('post:postid:'.$postId.':content'));
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
                'get'=>'user:userId:*:username'
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
     */
    public function userFollow($targetUser='2', $user=323)
    {
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        $userName = 'tinywan2245';
        $userId = 2;
        $prouId = $redis->get('user:username:'.$userName.':userid'); //取出该用户
        if($prouId == false){
            exit('非法的用户名');
        }
        // ismembers  判断该用户是不是该集合的元素
        $isfollowing = $redis->sIsMember('following:'.$userId,$prouId);

        if($isfollowing){
            echo '已经是粉丝了，取消关注';
        }else{
            echo '你还不是粉丝了，点击关注';
            // 关注我的粉丝集合（被关注者的粉丝列表）
            $redis->sAdd('followers:' . $userId,$prouId); //给自己集合中添加该粉丝
            //自己关注的人的集合
            $redis->sAdd('following:'.$prouId,$userId);  //关注的人给自己集合中增加一条，我关注了谁
        }
        //获取粉丝数
        $allFollowers = $redis->sCard('followers:' . $userId); //获取粉丝数
        var_dump($allFollowers);
        //设置粉丝个数
        $redis->hset('user:' . $userId, 'fans', $allFollowers);
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