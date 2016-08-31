<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/7/3
 * Time: 9:26
 * Mail: Overcome.wan@Gmail.com
 * Singleton instance
 */
namespace Org\Util;

class UserAgent
{
    private static $IS_MOBILE = false;
    private static $IS_WECHAT = false;

    public static function init()
    {
        $useragent = $_SERVER['HTTP_USER_AGENT'];

        UserAgent::$IS_MOBILE = preg_match("/iPhone|iPad|Android|Windows Phone/i", $useragent);

        UserAgent::$IS_WECHAT = preg_match("/MicroMessenger/i", $useragent);
    }

    public static function IS_MOBILE()
    {
        return UserAgent::$IS_MOBILE;
    }

    public static function IS_WECHAT()
    {
        return UserAgent::$IS_WECHAT;
    }
}