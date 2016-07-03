<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/7/3
 * Time: 9:26
 * Mail: Overcome.wan@Gmail.com
 */

namespace Org\Util;


class Redis
{
    /**
     * 保存类实例的静态成员变量
     * @var
     */
    private static $instance;

    /**
     * private标记的构造方法
     * Redis constructor.
     */
    protected  function __construct(){
        echo 'protected __Construnce';
    }

    /**
     * 创建__clone方法防止对象被复制克隆
     */
    public function __clone()
    {
        // TODO: Implement __clone() method.
    }

    /**
     * 单例方法,用于访问实例的公共的静态方法
     * @return \Redis
     */
    public static function init(){
        if(!(self::$instance instanceof \Redis)){
            self::$instance = new  \Redis();
            self::$instance->connect('127.0.0.1',6379);
        }
        return self::$instance;
    }

    /**
     * null
     * @return null
     */
    public function testRedis(){
        echo 'Redis Success';
        return null;
    }

}