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
    const LAST_MODIFIED = 'LAST:MODIFIED';


    public function index()
    {
        echo 'Cache';
    }

    /**
     * 生成依赖性数据
     * @param $cache
     * @return int
     * ['fileName' => 'cache.txt']
     */
    protected static function generateDependencyData($fileName)
    {
        if ($fileName === null) {
            throw new \HttpInvalidParamException('FileDependency::fileName must be set');
        }
        $file = CONF_PATH . 'Dependency/' . $fileName;
        return @filemtime($file); //filemtime() 函数返回文件内容上次的修改时间。
    }

    /**
     *  文件依赖缓存
     * filemtime() 函数返回文件内容上次的修改时间。
     */
    public static function fileCache($fileName = 'cache.txt',$cId=39)
    {
        $redisKey = self::CATEGORY_INFO . $cId;
        //文件内容上次的修改时间
        $fileLastModified = self::generateDependencyData($fileName);
        $redis = RedisInstance::MasterInstance();
        $LastModified = $redis->get(self::LAST_MODIFIED . $redisKey);
        if($LastModified != $fileLastModified){
            $model = M('Category'); // return Object
            $condition['id'] = $cId;
            $categoryData = $model->where($condition)->select();
            iconv('GB2312', 'UTF-8', $categoryData);
            if ($categoryData) {
                $redis->multi();
                $redis->set($redisKey, json_encode($categoryData));
                $redis->set(self::LAST_MODIFIED . $redisKey,$fileLastModified);
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
                $redis->set(self::LAST_MODIFIED . $redisKey,$fileLastModified);
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

    public function getFileCache()
    {
        $fileName = 'cache.txt';
        $cId=39;
        homePrint(self::fileCache($fileName,$cId));
    }

    /**
     * 修改更新Mysql数据中的数据
     */
    public function modifyMysqlData($fileName = 'cache.txt',$cId=39)
    {
        $name = 'T领域玩'.mt_rand(00000,99999);
        $model = M('Category'); // return Object
        $condition['id'] = $cId;
        if($model->where($condition)->setField('name',$name) == true){
            $cacheFile = CONF_PATH . 'Dependency/' . $fileName;
            echo $cacheFile;
            file_put_contents($cacheFile,$cId);
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