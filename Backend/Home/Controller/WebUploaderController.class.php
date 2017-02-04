<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/4
 * |  Time: 13:29
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Home\Controller;


use Think\Controller;

/**
 * Class WebUploaderController
 * 采用大文件分片并发上传，极大的提高了文件上传效率
 * http://fex.baidu.com/webuploader/
 */
class WebUploaderController extends Controller
{
    public function GettingStarted()
    {
        $this->display();
    }
}