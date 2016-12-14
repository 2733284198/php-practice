<?php
namespace Home\Controller;

use Home\Controller\BaseController;
use Org\Util\RedisInstance;
use Think\Cache;

class RedisCacheController extends BaseController
{
    public function index()
    {
        echo 'RedisCache';
    }

    public static function primaryKey()
    {
        return ['id'];
    }

    //redis应用于php，连接mysql的完整案例
    public function connectMysql()
    {
        $redis = RedisInstance::MasterInstance();
        if($redis->exists('blog')){
            $redisData = $redis->get('blog');
            $resultData = unserialize($redisData);
            var_dump($resultData);
            foreach ($resultData as $res){
                echo "Redis---------<br/>";
                echo $res['username']."<br/>";
            }
        }else{
            $userData = M('User')->select();
            $redis->multi();
            //$redis->del('blog'); //初始化key
            $redis->set('blog',serialize($userData));
            $resultData = serialize($redis->get('blog'));
            $redis->exec();
            foreach ($resultData as $res){
                echo "Mysql---------<br/>";
                echo $res['username']."<br/>";
            }
        }
    }

    /**
     * 使用php内置的serialize/unserialize 方法对数据进行处理
     * $redis->setOption(Redis::OPT_SERIALIZER, Redis::SERIALIZER_PHP);
     * 可以看到将array存入和取出时会自动进行了序列化处理
     * $redis->getOption(\Redis::OPT_SERIALIZER); //return 1 [ const SERIALIZER_PHP = 1;]
     */
    public function connectMysqlSerialize()
    {
        $redis = RedisInstance::MasterInstance();

        if($redis->exists('blog')){
            $redisData = $redis->get('blog');
            $resultData = unserialize($redisData);
            foreach ($resultData as $res){
                echo "Redis---------<br/>";
                echo $res['username']."<br/>";
            }
        }else{
            $userData = M('User')->select();
            $redis->multi();
            $redis->setOption(\Redis::OPT_SERIALIZER,\Redis::SERIALIZER_PHP); //使用ＰＨＰ内置的serialize / unserialize
            $redis->set('blog',$userData);
            $redis->exec();
            $resultData = $redis->get('blog');
            foreach ($resultData as $res){
                echo "Mysql---------<br/>";
                echo $res['username']."<br/>";
            }
        }
    }
    //############################################Redis实战#########################################################
    //cache_request 20161213
    public function cache_request($conn, $request, $callback)
    {
        //对于不能被缓存的请求，直接调用回调函数。
        $redis = RedisInstance::MasterInstance();

        //将请求转换成一个简单的字符串键，方便之后进行查找。
        $page_key = 'cache:' .$request;
        //尝试查找被缓存的页面。
        $content = $redis->get($page_key);

        #如果页面还没有被缓存，那么生成页面。
        $content = callback($request);
        # 将新生成的页面放到缓存里面。
        $redis->setex($page_key, $content, 300);
    }

    //cache_request 20161213
    public function schedule_row_cache($conn, $row_id, $delay)
    {
        //对于不能被缓存的请求，直接调用回调函数。
        $redis = RedisInstance::MasterInstance();
        # 先设置数据行的延迟值。
        $redis->zadd('delay:', $row_id, $delay);
        # 立即缓存数据行。
        $redis->zadd('schedule:', $row_id, time());
    }

    //cache_request 20161213
    public function cache_rows($conn, $request, $callback)
    {
        # 尝试获取下一个需要被缓存的数据行以及该行的调度时间戳，
        # 命令会返回一个包含零个或一个元组（tuple）的列表。

        $redis = RedisInstance::MasterInstance();
        $next = $redis->zRange('schedule:', 0, 0, $withscores=True);
        $now = time();
        while (list($key, $value) = each($arr)) {
            # 暂时没有行需要被缓存，休眠50毫秒后重试。
            if($next>10){
                sleep(0.5);
                continue;
            }
            $row_id = $next[0][0];
            # 获取下一次调度前的延迟时间。
            $delay = $redis->zscore('delay:', $row_id);
            if($delay<=0){
                # 不必再缓存这个行，将它从缓存中移除。
                $redis->zrem('delay:', $row_id);
                $redis->zrem('schedule:', $row_id);
                $redis->delete('inv:' + $row_id);
                continue;
            }
            # 读取数据行。
            $row = Inventory.get(row_id);
            # 更新调度时间并设置缓存值。
            $redis->zadd('schedule:', $row_id, $now + $delay);
            $redis->set('inv:' + $row_id, json_encode($row));
        }


        //将请求转换成一个简单的字符串键，方便之后进行查找。
        $page_key = 'cache:' .$request;
        //尝试查找被缓存的页面。
        $content = $redis->get($page_key);

        #如果页面还没有被缓存，那么生成页面。
        $content = callback($request);
        # 将新生成的页面放到缓存里面。
        $redis->setex($page_key, $content, 300);

    }
    //############################################Redis实战#########################################################

    //############################################Yii2.0实战#########################################################
    /**
     * @inheritdoc
     */
    public function insert($runValidation = true, $attributes = null)
    {
        $db = static::getDb();
        $values = $this->getDirtyAttributes($attributes);
        $pk = [];
        foreach ($this->primaryKey() as $key) {
            $pk[$key] = $values[$key] = $this->getAttribute($key);
            if ($pk[$key] === null) {
                // use auto increment if pk is null
                $pk[$key] = $values[$key] = $db->executeCommand('INCR', [static::keyPrefix() . ':s:' . $key]);
                $this->setAttribute($key, $values[$key]);
            } elseif (is_numeric($pk[$key])) {
                // if pk is numeric update auto increment value
                $currentPk = $db->executeCommand('GET', [static::keyPrefix() . ':s:' . $key]);
                if ($pk[$key] > $currentPk) {
                    $db->executeCommand('SET', [static::keyPrefix() . ':s:' . $key, $pk[$key]]);
                }
            }
        }
        // save pk in a findall pool
        $db->executeCommand('RPUSH', [static::keyPrefix(), static::buildKey($pk)]);

        $key = static::keyPrefix() . ':a:' . static::buildKey($pk);
        // save attributes
        $setArgs = [$key];
        foreach ($values as $attribute => $value) {
            // only insert attributes that are not null
            if ($value !== null) {
                if (is_bool($value)) {
                    $value = (int) $value;
                }
                $setArgs[] = $attribute;
                $setArgs[] = $value;
            }
        }

        if (count($setArgs) > 1) {
            $db->executeCommand('HMSET', $setArgs);
        }

        $changedAttributes = array_fill_keys(array_keys($values), null);
        $this->setOldAttributes($values);
        $this->afterSave(true, $changedAttributes);

        return true;
    }

    /**
     * Updates the whole table using the provided attribute values and conditions.
     * For example, to change the status to be 1 for all customers whose status is 2:
     *
     * ~~~
     * Customer::updateAll(['status' => 1], ['id' => 2]);
     * ~~~
     *
     * @param array $attributes attribute values (name-value pairs) to be saved into the table
     * @param array $condition the conditions that will be put in the WHERE part of the UPDATE SQL.
     * Please refer to [[ActiveQuery::where()]] on how to specify this parameter.
     * @return integer the number of rows updated
     */
    public static function updateAll($attributes, $condition = null)
    {
        if (empty($attributes)) {
            return 0;
        }
        $db = static::getDb();
        $n = 0;
        foreach (self::fetchPks($condition) as $pk) {
            $newPk = $pk;
            $pk = static::buildKey($pk);
            $key = static::keyPrefix() . ':a:' . $pk;
            // save attributes
            $delArgs = [$key];
            $setArgs = [$key];
            foreach ($attributes as $attribute => $value) {
                if (isset($newPk[$attribute])) {
                    $newPk[$attribute] = $value;
                }
                if ($value !== null) {
                    if (is_bool($value)) {
                        $value = (int) $value;
                    }
                    $setArgs[] = $attribute;
                    $setArgs[] = $value;
                } else {
                    $delArgs[] = $attribute;
                }
            }
            $newPk = static::buildKey($newPk);
            $newKey = static::keyPrefix() . ':a:' . $newPk;
            // rename index if pk changed
            if ($newPk != $pk) {
                $db->executeCommand('MULTI');
                if (count($setArgs) > 1) {
                    $db->executeCommand('HMSET', $setArgs);
                }
                if (count($delArgs) > 1) {
                    $db->executeCommand('HDEL', $delArgs);
                }
                $db->executeCommand('LINSERT', [static::keyPrefix(), 'AFTER', $pk, $newPk]);
                $db->executeCommand('LREM', [static::keyPrefix(), 0, $pk]);
                $db->executeCommand('RENAME', [$key, $newKey]);
                $db->executeCommand('EXEC');
            } else {
                if (count($setArgs) > 1) {
                    $db->executeCommand('HMSET', $setArgs);
                }
                if (count($delArgs) > 1) {
                    $db->executeCommand('HDEL', $delArgs);
                }
            }
            $n++;
        }

        return $n;
    }

    /**
     * Updates the whole table using the provided counter changes and conditions.
     * For example, to increment all customers' age by 1,
     *
     * ~~~
     * Customer::updateAllCounters(['age' => 1]);
     * ~~~
     *
     * @param array $counters the counters to be updated (attribute name => increment value).
     * Use negative values if you want to decrement the counters.
     * @param array $condition the conditions that will be put in the WHERE part of the UPDATE SQL.
     * Please refer to [[ActiveQuery::where()]] on how to specify this parameter.
     * @return integer the number of rows updated
     */
    public static function updateAllCounters($counters, $condition = null)
    {
        if (empty($counters)) {
            return 0;
        }
        $db = static::getDb();
        $n = 0;
        foreach (self::fetchPks($condition) as $pk) {
            $key = static::keyPrefix() . ':a:' . static::buildKey($pk);
            foreach ($counters as $attribute => $value) {
                $db->executeCommand('HINCRBY', [$key, $attribute, $value]);
            }
            $n++;
        }

        return $n;
    }

    /**
     * Deletes rows in the table using the provided conditions.
     * WARNING: If you do not specify any condition, this method will delete ALL rows in the table.
     *
     * For example, to delete all customers whose status is 3:
     *
     * ~~~
     * Customer::deleteAll(['status' => 3]);
     * ~~~
     *
     * @param array $condition the conditions that will be put in the WHERE part of the DELETE SQL.
     * Please refer to [[ActiveQuery::where()]] on how to specify this parameter.
     * @return integer the number of rows deleted
     */
    public static function deleteAll($condition = null)
    {
        $pks = self::fetchPks($condition);
        if (empty($pks)) {
            return 0;
        }

        $db = static::getDb();
        $attributeKeys = [];
        $db->executeCommand('MULTI');
        foreach ($pks as $pk) {
            $pk = static::buildKey($pk);
            $db->executeCommand('LREM', [static::keyPrefix(), 0, $pk]);
            $attributeKeys[] = static::keyPrefix() . ':a:' . $pk;
        }
        $db->executeCommand('DEL', $attributeKeys);
        $result = $db->executeCommand('EXEC');

        return end($result);
    }

    private static function fetchPks($condition)
    {
        $query = static::find();
        $query->where($condition);
        $records = $query->asArray()->all(); // TODO limit fetched columns to pk
        $primaryKey = static::primaryKey();

        $pks = [];
        foreach ($records as $record) {
            $pk = [];
            foreach ($primaryKey as $key) {
                $pk[$key] = $record[$key];
            }
            $pks[] = $pk;
        }

        return $pks;
    }

    /**
     * Builds a normalized key from a given primary key value.
     *
     * @param mixed $key the key to be normalized
     * @return string the generated key
     */
    public static function buildKey($key)
    {
        if (is_numeric($key)) {
            return $key;
        } elseif (is_string($key)) {
            return ctype_alnum($key) && StringHelper::byteLength($key) <= 32 ? $key : md5($key);
        } elseif (is_array($key)) {
            if (count($key) == 1) {
                return self::buildKey(reset($key));
            }
            ksort($key); // ensure order is always the same
            $isNumeric = true;
            foreach ($key as $value) {
                if (!is_numeric($value)) {
                    $isNumeric = false;
                }
            }
            if ($isNumeric) {
                return implode('-', $key);
            }
        }

        return md5(json_encode($key));
    }




}