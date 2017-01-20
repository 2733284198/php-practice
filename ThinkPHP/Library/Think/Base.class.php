<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/1/20
 * |  Time: 13:15
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Think;


class Base
{
    /**
     * 类实例化
     */
    public static function instance() {
        static $_instance = array();

        $classFullName = get_called_class();
        if (!isset($_instance[$classFullName])) {
            if (class_exists($classFullName)) {
                $instance = $_instance[$classFullName] = new static();
                return $instance;
            } else {
                throw new \Exception('"' . $classFullName . '" was not found !');
            }
        }

        return $_instance[$classFullName];
    }
}