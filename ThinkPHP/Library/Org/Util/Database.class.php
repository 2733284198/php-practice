<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/11/1
 * Time: 8:54
 * Mail: Overcome.wan@Gmail.com
 * 数据库类
 * 单例模式（职责模式）：
 *     简单的说，一个对象（在学习设计模式之前，需要比较了解面向对象思想）只负责一个特定的任务；
 * 单例类：
 *     1、构造函数需要标记为private（访问控制：防止外部代码使用new操作符创建对象），单例类不能在其他类中实例化，只能被其自身实例化；
 *     2、拥有一个保存类的实例的静态成员变量
 *     3、拥有一个访问这个实例的公共的静态方法（常用instance()方法进行实例化单例类，通过instanceof操作符可以检测到类是否已经被实例化）
 *     另外，需要创建__clone()方法防止对象被复制（克隆）
 * 为什么要使用PHP单例模式？
 *     1、php的应用主要在于数据库应用, 所以一个应用中会存在大量的数据库操作, 使用单例模式, 则可以避免大量的new 操作消耗的资源。
 *     2、如果系统中需要有一个类来全局控制某些配置信息, 那么使用单例模式可以很方便的实现. 这个可以参看ZF的FrontController部分。
 *     3、在一次页面请求中, 便于进行调试, 因为所有的代码(例如数据库操作类db)都集中在一个类中, 我们可以在类中设置钩子, 输出日志，从而避免到处var_dump, echo。
 *
 */

namespace Org\Util;


class Database
{
    private static $_db;

    private static $_instance;

    private function __construct($host, $user, $password, $database, $port, $charset)
    {
        $conn = mysqli_connect($host, $user, $password, $database, $port);
        // 检测连接
        if (!$conn) {
            die("Connection failed: " . mysqli_connect_error());
        }
        self::$_db = $conn;
    }

    public static function instance($host, $user, $password, $database, $port, $charset){
        if(!self::$_instance instanceof self){
            self::$_instance = new self($host, $user, $password, $database, $port, $charset);
        }
        return self::$_instance;
    }
    private function __clone(){
        trigger_error('Clone is not allow!',E_USER_ERROR);
    }

    public static function test()
    {
        return 'test';
    }
}
