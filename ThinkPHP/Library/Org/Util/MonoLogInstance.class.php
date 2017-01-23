<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/11/1
 * Time: 8:54
 * Mail: Overcome.wan@Gmail.com
 */

namespace Org\Util;
use Monolog\Handler\FirePHPHandler;
use Monolog\Handler\StreamHandler;
use Monolog\Logger;
use Think\Exception;

class MonoLogInstance
{
    /**
     * 类对象实例数组,共有静态变量
     * @var null
     */
    private static $_logger_instance;

    /**
     * 私有化构造函数，防止类外实例化
     * RedisConnect constructor.
     */
    private function __construct()
    {
    }

    /**
     * 单例方法,用于访问实例的公共的静态方法
     * @return bool|Logger|null
     * @static
     */
    public static function Instance()
    {
        if (is_object(self::$_logger_instance)) return self::$_logger_instance;
        try {
            self::$_logger_instance = new Logger('admin_Log');
            self::$_logger_instance->pushHandler(new StreamHandler('Logs/to/instance_class.log',Logger::DEBUG));
            self::$_logger_instance->pushHandler(new FirePHPHandler());
        } catch (Exception $e) {
            $instance = new Logger('Class_Log');
            $instance->pushHandler(new StreamHandler('Logs/to/error.log',Logger::ERROR));
            $instance->addInfo('MonoLogInstance 单利模式实例化失败');
            return false;
        }
        return self::$_logger_instance;
    }

    /**
     * 私有化克隆函数，防止类外克隆对象
     */
    private function __clone()
    {
        // TODO: Implement __clone() method.
    }

}
