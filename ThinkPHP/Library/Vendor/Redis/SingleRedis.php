<?php

/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/8/31
 * Time: 8:55
 * Mail: Overcome.wan@Gmail.com
 */
class SingleRedis
{
    const DB_HOST = 'localhost';
    const DB_NAME = '';
    const DB_USER = '';
    const DB_PWD = '';
    private $name;
    //保存实例的私有静态变量
    private static $_instance = null;

    //构造函数和克隆函数都声明为私有的
    private function __construct()
    {
        //$this->_db=mysql_connect();
    }

    private function __clone()
    {
        //实现
    }

    //访问实例的公共静态方法
    public static function getInstance()
    {
//        if (!(self::$_instance instanceof self)) {
//            self::$_instance = new self();
//        }
        if (!(self::$_instance instanceof \Redis)) {
            self::$_instance = new \Redis();
        }
        //或者
//        if (self::$_instance === null) {
//            self::$_instance = new \Redis();
//        }
        return self::$_instance;
    }

    public function getName()
    {
        return $this->name;
    }

    public function setName($name)
    {
        $this->name = $name;
    }
}

//类外部获取实例的引用
$db = Db::getInstance();
