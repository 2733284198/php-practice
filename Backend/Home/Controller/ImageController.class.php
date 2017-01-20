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

    /**
     * Reading Images
     */
    public function ReadingImages()
    {
        $inputPath = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/Images/20130925095904723.jpg'; //项目路径
        //设置文件大小,同时保存文件为png格式
        Image::make($inputPath)->resize(320,240)->save('123.png');
    }

    /**
     * Creating Images,Creating new images with background color
     */
    public function CreatingImages()
    {
        $img = Image::canvas(800, 600, '#ccc');
        var_dump($img);
    }
    
    /**
     *  Save image in filesystem
     */
    public function  SaveImage()
    {
        $inputPath = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/Images/20130925095904723.jpg'; //项目路径
        $image = Image::make($inputPath)->resize(320,240);
        // save file as png with medium quality
        $image->save('Uploads/Images/bar123.png',60);
        // save the same file as jpeg with default quality
        $image->save('Uploads/Images/bar123.jpg');
    }
}