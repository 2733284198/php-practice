<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/1/20
 * |  Time: 16:25
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Home\Controller;

use Think\Controller;

/**
 * Github:https://github.com/serbanghita/Mobile-Detect
 * 说明：Mobile_Detect是一个轻量级的PHP类，用于检测移动设备（包括平板电脑）它使用User-Agent字符串结合特定的HTTP头来检测移动环境。
 */
class MobileController extends Controller
{
    public function index()
    {
        echo __METHOD__.'Mobile';

    }

    /**
     * http://mobiledetect.net/
     * //
     */
    public function detect()
    {
        // Include and instantiate the class.
        $detect = new \Mobile_Detect();
        var_dump($detect);

        // Any mobile device (phones or tablets).
        if($detect->isMobile()){}

        //Any tablet device.(任何平板电脑设备)。
        if($detect->isTablet()){}

        //Exclude tablets.(排除平板电脑)
        if($detect->isMobile() && !$detect->isTablet()){}

        //警告：此方法在测试版中，某些关键字属性将在未来更改。
        if($detect->is('Firefox')){
            echo 'Chrome';
        }else{
            echo '000000';
        }
        die;
    }
}