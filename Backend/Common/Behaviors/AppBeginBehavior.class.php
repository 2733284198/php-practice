<?php

/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/1/17
 * |  Time: 9:58
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/
//行为类建议继承\Think\Behavior，必须实现run(&$param)方法，行为是通过这个方法执行的。
class AppBeginBehavior extends \Think\Behavior
{
    //行为执行入口
    public function run(&$params)
    {

    }
}