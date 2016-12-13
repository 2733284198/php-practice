<?php
namespace Home\Controller;

use Home\Controller\BaseController;
use Org\Util\RedisInstance;
use Think\Cache;

class CacheController extends BaseController
{
    /**
     * @var string使用最后修改时间的文件路径或路径别名
     * 检查依赖关系是否已更改。
     */
    public $fileName;

    const PHONE_API = 'https://tcc.taobao.com/cc/json/mobile_tel_segment.htm';
    const CATEGORY_INFO = 'CATEGORY:INFO:';
    const TABLE_CACHE = 'TABLE:CACHE:';
    const LAST_MODIFIED = 'LAST:MODIFIED';
    const EXT = '.txt';


    public function index()
    {
        echo 'Cache';
    }

    /**
     * 生成文件依赖性数据
     * @param $cache
     * @return int
     * ['fileName' => 'cache.txt']
     */
    public static function generateDependencyData($fileName)
    {
        if ($fileName === null) {
            throw new \HttpInvalidParamException('FileDependency::fileName must be set');
        }
        $tablefile = CONF_PATH . 'Dependency/' . $fileName . self::EXT;
        $dir = dirname($tablefile);
        if (!is_dir($dir)) mkdir($dir, 0777);
        if (file_exists($tablefile) == false) {
            $cacheTime = sprintf('%011d', time());
            file_put_contents($tablefile, $cacheTime);
        }
        return @filemtime($tablefile); //filemtime() 函数返回文件内容上次的修改时间。
    }

    public static function connectionPdo()
    {
        $user = 'root';
        $pass = '';
        try {
            $Instance = new \PDO("mysql:host=localhost;dbname=tp5", $user, $pass);
        } catch (\PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
        return $Instance;
    }

    /**
     * 生成数据库依赖性数据
     * @param $cache
     * @return int
     * ['fileName' => 'cache.txt']
     */
    protected function generateDependencyDataDb($cache_sql)
    {
        $dbInstance = self::connectionPdo();

        $db = Instance::ensure($this->db, Connection::className());
        if ($cache_sql === null) {
            throw new \HttpInvalidParamException("DbDependency::sql must be set.");
        }

        if ($db->enableQueryCache) {
            // temporarily disable and re-enable query caching
            $db->enableQueryCache = false;
            $result = $db->createCommand($this->sql, $this->params)->queryOne();
            $db->enableQueryCache = true;
        } else {
            $result = $db->createCommand($this->sql, $this->params)->queryOne();
        }

        return $result;
    }

    /**
     *  生成数据库依赖缓存
     * filemtime() 函数返回文件内容上次的修改时间。
     */
    public static function fileCache($fileName = 'cache.txt', $cId = 39)
    {
        $redisKey = self::CATEGORY_INFO . $cId;
        //文件内容上次的修改时间
        $fileLastModified = self::generateDependencyData($fileName);
        $redis = RedisInstance::MasterInstance();
        $LastModified = $redis->get(self::LAST_MODIFIED . $redisKey);
        if ($LastModified != $fileLastModified) {
            $model = M('Category'); // return Object
            $condition['id'] = $cId;
            $categoryData = $model->where($condition)->select();
            iconv('GB2312', 'UTF-8', $categoryData);
            if ($categoryData) {
                $redis->multi();
                $redis->set($redisKey, json_encode($categoryData));
                $redis->set(self::LAST_MODIFIED . $redisKey, $fileLastModified);
                $redis->expire($redisKey, 120);
                $redis->exec();
            }
            $categoryData['msg'] = '数据库记录修改后MySql数据库中的数据';
            return $categoryData;
        }

        //获取缓存内容
        $categoryInfo = $redis->get($redisKey);
        //如果缓存不存在的话！
        if (!$categoryInfo) {
            //访问接口、查询数据库
            $model = M('Category'); // return Object
            $condition['id'] = $cId;
            $categoryData = $model->where($condition)->select();
            iconv('GB2312', 'UTF-8', $categoryData);
            if ($categoryData) {
                $redis->multi();
                $redis->set($redisKey, json_encode($categoryData));
                $redis->set(self::LAST_MODIFIED . $redisKey, $fileLastModified);
                $redis->expire($redisKey, 120);
                $redis->exec();
            }
            $categoryData['msg'] = '数据来自MySql数据库数据';
        } else {
            $categoryData = json_decode($categoryInfo, true);
            $categoryData['msg'] = '数据来自Redis缓存数据';
        }
        return $categoryData;
    }

    /**
     *  !!!!!!生成一张数据表的缓存tour_user 用户表
     *  $tableName 是区分大小写的（建议以大写开头哦！！！TP而言哈哈）
     */
    public function tableCache($tableName)
    {
        //拼装一个自定义键
        $redisKey = self::TABLE_CACHE . $tableName;
        //文件内容上次的修改时间
        $fileLastModified = self::generateDependencyData($tableName);
        $redis = RedisInstance::MasterInstance();
        $LastModified = unserialize($redis->get(self::LAST_MODIFIED . $redisKey));
        if ($LastModified != $fileLastModified) {
            $mysqlData = M($tableName)->select();
            if ($mysqlData) {
                $redis->multi();
                $redis->setOption(\Redis::OPT_SERIALIZER, \Redis::SERIALIZER_PHP);
                $redis->set($redisKey, $mysqlData);
                $redis->set(self::LAST_MODIFIED . $redisKey, $fileLastModified);
                $redis->expire($redisKey, 120);
                $redis->exec();
            }
            $mysqlData['msg'] = '数据库记录修改后MySql数据库中的数据';
            return $mysqlData;
        }
        //如果缓存不存在的话！
        if ($redis->exists($redisKey)) {
            //获取缓存内容
            $mysqlData = unserialize($redis->get($redisKey));
            $mysqlData['msg'] = '数据来自Redis缓存数据';
        } else {
            $mysqlData = M($tableName)->select();
            if ($mysqlData) {
                $redis->multi();
                $redis->setOption(\Redis::OPT_SERIALIZER, \Redis::SERIALIZER_PHP);
                $redis->set($redisKey, $mysqlData);
                $redis->set(self::LAST_MODIFIED . $redisKey, $fileLastModified);
                $redis->expire($redisKey, 120);
                $redis->exec();
            }
            $mysqlData['msg'] = '数据来自MySql数据库数据';
        }
        return $mysqlData;
    }

    //测试
    public function getFileCache()
    {
        $fileName = 'cache.txt';
        $cId = 39;
        homePrint(self::fileCache($fileName, $cId));
    }

    //测试
    public function getTableFileCache()
    {
        $tableName = 'Category';
        homePrint(self::tableCache($tableName));
    }

    /**
     * 修改更新Mysql数据中的数据
     */
    public function modifyMysqlData($fileName = 'cache.txt', $cId = 39)
    {
        $name = 'T领域玩' . mt_rand(00000, 99999);
        $model = M('Category'); // return Object
        $condition['id'] = $cId;
        if ($model->where($condition)->setField('name', $name) == true) {
            $cacheFile = CONF_PATH . 'Dependency/' . $fileName;
            echo $cacheFile;
            file_put_contents($cacheFile, $cId, FILE_APPEND);
        }
    }

    /**
     * JSON 格式化存储
     * @param $data
     * @return null
     */
    public static function formatData($data)
    {
        $ret = null;
        if (!empty($data)) {
            preg_match_all("/(\w+):'([^']+)/", $data, $res);
            $items = array_combine($res[1], $res[2]);
            foreach ($items as $itemKey => $itemVal) {
                $ret[$itemKey] = iconv('GB2312', 'UTF-8', $itemVal);
            }
        }
        return $ret;
    }


    /**
     *  Redis依赖缓存
     */
    public function RedisCache()
    {
        $redis = RedisInstance::MasterInstance();
        var_dump($redis);
    }

    public function exists($key)
    {
        return (bool)$this->redis->executeCommand('EXISTS', [$this->buildKey($key)]);
    }

    /**
     * 将路径别名转换为实际路径。
     * @param $alias
     * @param bool $throwException
     * @return bool|string
     */
    public static function getAlias($alias, $throwException = true)
    {
        if (strncmp($alias, '@', 1)) {
            // not an alias
            return $alias;
        }

        $pos = strpos($alias, '/');
        $root = $pos === false ? $alias : substr($alias, 0, $pos);

        if (isset(static::$aliases[$root])) {
            if (is_string(static::$aliases[$root])) {
                return $pos === false ? static::$aliases[$root] : static::$aliases[$root] . substr($alias, $pos);
            } else {
                foreach (static::$aliases[$root] as $name => $path) {
                    if (strpos($alias . '/', $name . '/') === 0) {
                        return $path . substr($alias, strlen($name));
                    }
                }
            }
        }

        if ($throwException) {
            throw new \HttpInvalidParamException("Invalid path alias: $alias");
        } else {
            return false;
        }
    }


}