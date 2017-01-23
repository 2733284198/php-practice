<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/11/1
 * Time: 8:54
 * Mail: Overcome.wan@Gmail.com
 */

namespace Org\Util;

use OSS\Core\OssException;
use OSS\OssClient;

class OssInstance
{
    /**
     * 类对象实例数组,共有静态变量
     * @var null
     */
    private static $_oss_instance;

    /**
     * 私有化构造函数，防止类外实例化
     */
    private function __construct()
    {
    }

    public static function Instance()
    {
        if (is_object(self::$_oss_instance)) return self::$_oss_instance;
        try {
            self::$_oss_instance = new OssClient(C('OSS_CONFIG.accessKeyId'), C('OSS_CONFIG.accessKeySecret'), C('OSS_CONFIG.endpoint'));
        } catch (OssException $e) {
            print $e->getMessage();
            return false;
        }
        return self::$_oss_instance;
    }

    /**
     * 私有化克隆函数，防止类外克隆对象
     */
    private function __clone()
    {
        // TODO: Implement __clone() method.
    }

}
