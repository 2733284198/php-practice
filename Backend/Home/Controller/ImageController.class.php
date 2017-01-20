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
        Image::make($inputPath)->resize(320, 240)->save('123.png');
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
     *  function：public Intervention\Image\Image save([string $path, [int $quality]])
     *  $path 文件的路径写入图像数据的位置。 如果从文件系统中的现有映像创建映像，并且未设置参数，则该方法将尝试覆盖现有文件。
     *  $quality 可选地定义图像的质量。 它对所有文件类型进行标准化，范围从0（质量差，小文件）到100（最佳质量，大文件）。
     *           质量仅适用于编码JPG格式，因为PNG压缩是无损的，不会影响图像质量。 默认值为90。
     */
    public function SaveImage()
    {
        $inputPath = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/Images/20130925095904723.jpg'; //项目路径
        $image = Image::make($inputPath)->resize(320, 240);
        // save file as png with medium quality
        $image->save('Uploads/Images/bar123.png', 60);
        // save the same file as jpeg with default quality
        $image->save('Uploads/Images/bar123.jpg');
    }
}