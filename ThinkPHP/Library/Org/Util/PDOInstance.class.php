<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/11/1
 * Time: 8:54
 * Mail: Overcome.wan@Gmail.com
 */

namespace Org\Util;


class PDOInstance
{
    /**
     * 数据库连接资源句柄
     * @var
     */
    private static $_connectSource;

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

    public static function connect($host,$dbname,$user,$passwd)
    {
        try {
            // 如果连接资源不存在，则进行资源连接
            if (!(static::$_connectSource instanceof self)) {
                static::$_connectSource = new \PDO("mysql:host=$host;dbname=$dbname", $user, $passwd);
            }
            return static::$_connectSource;
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

    function close()
    {
        unset(static::$_connectSource);
    }

    /**
     * @return \Redis
     * @static
     */
    public static function test()
    {
        return 'test';
    }
}
