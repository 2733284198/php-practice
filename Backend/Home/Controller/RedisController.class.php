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
     * 直接尝试这去实例化Redis 【不建议】
     */
    public function index()
    {
        $redis = RedisInstance::getInstance();
        $redis->select(2);
        var_dump($redis->keys('ID:123456'));
        $this->display();
    }

    /**
     * Singleton instance(使用一个单例模式)
     */
    public function userCommit()
    {
        $redis = RedisInstance::getInstance();
        $client_id = I('post.client_id');
        $redis->sAdd('mysadd',$client_id);
    }

    public function userExists()
    {
        $redis = RedisInstance::getInstance();
        var_dump($redis->sIsMember('mysadd','333'));
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
        $redisWrite = Redis::getInstance($configMaster);
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
        $redisWrite = Redis::getInstance($configMaster);
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