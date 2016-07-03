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
    private static $instance;

    public static function init(){
        if(!(self::$instance instanceof \Redis)){
            self::$instance = new  \Redis();
            self::$instance->connect('127.0.0.1',6379);
        }
        return self::$instance;
    }
}