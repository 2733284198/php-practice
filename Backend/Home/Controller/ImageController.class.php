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
use Intervention\Image\Image;
use Think\Controller;

class ImageController extends Controller
{
    public function index()
    {
        echo 'composer require intervention/image';
    }

    public function init()
    {
        $inputPath = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/Images/20130925095904723.jpg'; //项目路径
        $outputPath =  __ROOT__ . '/Uploads/Images/12.jpg'; //项目路径
        //设置文件大小,同时保存文件为png格式
        $image = Image::make($inputPath)->resize(320,240)->save('123.png');
    }
}