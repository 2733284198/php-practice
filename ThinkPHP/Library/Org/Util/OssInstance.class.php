<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/11/1
 * Time: 8:54
 * Mail: Overcome.wan@Gmail.com
 */

namespace Org\Util;


class OssInstance
{
    /**
     * 类对象实例数组,共有静态变量
     * @var null
     */
    private static $_instance;

    /**
     * 私有化构造函数，防止类外实例化
     * RedisConnect constructor.
     */
    private function __construct()
    {
    }

    /**
     *  单例方法,用于访问实例的公共的静态方法
     *  这个只是一个实例
     *  这个实例方法适合于连接到别的Redis数据库中去。列如：在项目中选择不同的Redis数据库
     * @return \Redis
     * @static
     */
    public static function Instance()
    {
        try {
            if (!(static::$_instance instanceof \Redis)) {
                static::$_instance = new \Redis();
            }
            return static::$_instance;
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * 私有化克隆函数，防止类外克隆对象
     */
    private function __clone()
    {
        // TODO: Implement __clone() method.
    }

}
