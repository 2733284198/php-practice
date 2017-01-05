<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/11/1
 * Time: 8:54
 * Mail: Overcome.wan@Gmail.com
 */

namespace Org\Util;


use Think\Exception;

class PDOInstance
{
    /**
     * 数据库连接资源句柄
     * @var
     */
    private static $_connectSource;

    private static $_instance;

    /**
     * 私有化构造函数，防止类外实例化
     */
    private function __construct()
    {
    }

    /**
     *  单例方法,用于访问实例的公共的静态方法
     *  这个只是一个实例
     *  这个实例方法适合于连接到别的Redis数据库中去。列如：在项目中选择不同的Redis数据库
     * @return $_instance
     * @static
     */
     public static function getInstance() {
        if(!(self::$_instance instanceof self)) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    public static function connect($host,$dbname,$user,$passwd)
    {
        try {
            // 如果连接资源不存在，则进行资源连接
            if (!(self::$_connectSource instanceof self)) {
                self::$_connectSource = new \PDO("mysql:host=$host;dbname=$dbname", $user, $passwd);
                if(!self::$_connectSource){
                    throw new Exception('connect error');
                }
            }
            return self::$_connectSource;
        } catch (\Exception $e) {
            return false;
        }
    }

    public static function connectTp5()
    {
        $host = 'localhost';
        $dbname = 'tp5';
        $user = 'root';
        $pass = '';
        try {
            // 如果连接资源不存在，则进行资源连接
            if (!(self::$_connectSource instanceof self)) {
                self::$_connectSource = new \PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
                if(!self::$_connectSource){
                    throw new Exception('connect error');
                }
            }
            return self::$_connectSource;
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
