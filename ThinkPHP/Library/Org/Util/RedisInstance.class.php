<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/11/1
 * Time: 8:54
 * Mail: Overcome.wan@Gmail.com
 */

namespace Org\Util;


class RedisInstance
{
    /**
     * 类对象实例数组,共有静态变量
     * @var null
     */
    private static $_instance;
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
     *  单例方法,用于访问Master实例的公共的静态方法
     * @return \Redis
     * @static
     */
    public static function MasterInstance()
    {
        try {
            $_connectSource = self::Instance()->connect('128.2', '63789');
            if ($_connectSource === FALSE) return FALSE; //@return bool TRUE on success, FALSE on error.
            self::Instance()->auth('tinywanredis');

            return static::$_instance;
        } catch (\Exception $e) {
            return FALSE;
        }
    }

    /**
     * Slave1 实例
     * @return null
     * @static
     */
    public static function SlaveOneInstance()
    {
        try {
            self::Instance()->connect('121.09', '63788');
            if (self::$_connectSource === FALSE) return FALSE; //@return bool TRUE on success, FALSE on error.
            return static::$_instance;
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * Slave2 实例
     * @return null
     * @static
     */
    public static function SlaveTwoInstance()
    {
        try {
            self::Instance()->connect('121.49', '63700');
            if (self::$_connectSource === FALSE) return FALSE; //@return bool TRUE on success, FALSE on error.
            return static::$_instance;
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * Slave2 实例
     * @return null
     * @static
     */
    public static function LocationInstance()
    {
        try {
            if (self::Instance()->connect('127.0.0.1', '6379') === FALSE) return FALSE; //@return bool TRUE on success, FALSE on error.
            if (self::Instance()->ping() != '+PONG') return FALSE;
            return static::$_instance;
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * Slave2 实例
     * @return null
     * @static
     */
    public static function messageRedis()
    {
        try{
            self::Instance()->connect('214', '63579');
            self::Instance()->auth('amaitestredis');
            return static::$_instance;
        }catch (\Exception $e){
            return false;
        }
    }

    /**
     * Slave2 实例
     * @return null
     * @static
     */
    public static function commentRedis()
    {
        try{
            self::Instance()->connect('127.0.0.1', '6379');
            return static::$_instance;
        }catch (\Exception $e){
            return false;
        }
    }

    /**
     * Redis数据库是否连接成功
     * @return bool|string
     */
    public static function connect()
    {
        // 如果连接资源不存在，则进行资源连接
        if (!self::$_connectSource) {
            //@return bool TRUE on success, FALSE on error.
            self::$_connectSource = self::Instance()->connect('129', '63789');
            // 没有资源返回
            if (!self::$_connectSource) {
                return 'Redis Server Connection Fail';
            }
        }
        return self::$_connectSource;
    }

    /**
     * 私有化克隆函数，防止类外克隆对象
     */
    private function __clone()
    {
        // TODO: Implement __clone() method.
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
