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

    /**
     * 单例方法,用于访问实例的公共的静态方法
     * @return bool|null|OssClient
     * @static
     */
    public static function Instance()
    {
        if (is_object(self::$_oss_instance)) return self::$_oss_instance;
        try {
            self::$_oss_instance = new OssClient(C('OSS_CONFIG.accessKeyId'), C('OSS_CONFIG.accessKeySecret'), C('OSS_CONFIG.endpoint'));
        } catch (OssException $e) {
            MonoLogInstance::Instance()->addError(__CLASS__.'can not be instantiated err_msg:'.$e->getMessage(),array(
                   'function'=> __METHOD__,
                    'line' =>__LINE__
            ));
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
