<?php
/**
 * 《Redis实战》是《Redis in Action》一书的中文翻译版， 该书深入浅出地介绍了 Redis 的字符串、列表、
 * 散列、集合、有序集合等五种结构， 并通过文章聚合网站、cookie、购物车、网页缓存、日志、计数器、
 * IP 所属地址查询程序、自动补全、分布式锁、计数信号量、任务队列、消息队列、搜索程序、广告定向程序、
 * 社交网站等一系列实用示例展示了 Redis 的用法。
 */
namespace Home\Controller;
use Org\Util\RedisInstance;
use Think\Controller;

class RedisPracticeController extends Controller
{
    const ONE_WEEK_IN_SECONDS = 7 * 86400;
    const VOTE_SCORE = 432;
    public function index(){
       echo '欢迎来到《Redis实战》的支持网站！';
    }

    protected static function Redis(){
        $redis = RedisInstance::MasterInstance();
        $redis->select(10);
        return $redis;
    }

    # 代码清单 1-6 投票功能的实现
    public function article_vote(){
        $user = $_SESSION['uid'];
        $article = '1231';
        $redis = self::Redis();
        # 计算文章的投票截止时间。
        $cutoff = time() - static::ONE_WEEK_IN_SECONDS;
        # 检查是否还可以对文章进行投票
        #（虽然使用散列也可以获取文章的发布时间，
        # 但有序集合返回的文章发布时间为浮点数，
        # 可以不进行转换直接使用）。
        if($redis->zScore(':time',$article  < $cutoff)){
            return false;
        }
        # 从article:id标识符（identifier）里面取出文章的ID。
        $article_id = $redis->incr('global_article_id');

        # 如果用户是第一次为这篇文章投票，那么增加这篇文章的投票数量和评分。
        $redis->sAdd('voted:'.$article_id,$user);
        $redis->zIncrBy('score:',$article,self::VOTE_SCORE);
        $redis->hIncrBy($article, 'votes', 1);
    }

    /**
     * 代码清单 2-7 [设置数据行的延迟值]
     * @param $row_id
     * @param $delay
     */
    public function schedule_row_cache($row_id,$delay){
        $redis = self::Redis();
        # 先设置数据行的延迟值。
        $redis->zadd('delay:', $row_id, $delay);
        # 立即缓存数据行。
        $redis->zadd('schedule:', $row_id, time());
    }

    /**
     * 代码清单 2-8 [守护进程函数]
     * @param $row_id
     * @param $delay
     */
    public function cache_rows($row_id,$delay){
        $redis = self::Redis();
        while (true){
            # 尝试获取下一个需要被缓存的数据行以及该行的调度时间戳，
            # 命令会返回一个包含零个或一个元组（tuple）的列表。
            $next = $redis->zrange('schedule:', 0, 0, $withscores= true);
            $now = time();
            if($next == false || $next[0][1] >$now){
                # 暂时没有行需要被缓存，休眠50毫秒后重试。
                sleep(50);
                continue;
            }
            $row_id = $next[0][0];
        # 获取下一次调度前的延迟时间。
        $delay = $redis->zscore('delay:', $row_id);
            if ($delay <= 0){
                # 不必再缓存这个行，将它从缓存中移除。
                $redis->multi()
                      ->zrem('delay:', $row_id)
                      ->zrem('schedule:', $row_id)
                      ->del('inv:' + $row_id);
            continue;
            }
            # 读取数据行。
            $row = Inventory.get($row_id);
        # 更新调度时间并设置缓存值。
        $redis->zadd('schedule:', $row_id, $now + $delay);
        $redis->set('inv:' + $row_id, json_encode($row.to_dict()));
        }
    }
}