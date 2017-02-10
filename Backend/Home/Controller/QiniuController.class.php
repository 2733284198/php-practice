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

use Qiniu\Auth;
use Qiniu\Storage\UploadManager;
use Think\Controller;

class QiniuController extends Controller
{
    public function index()
    {
        echo __METHOD__.'Qiniu';

    }

    /**
     * qiNiuClient初始化
     */
    public function qiNiuClient()
    {
        $accessKey = 'zhsp8C1QR24yQu2ixLkHncfBjVpqS_bVvYgmA1r0';
        $secretKey = 'HeD4tfUDlXn7CpPf3YHxAS5frjrT1UF9QXGQjWiJ';
        $bucketName = 'tinywan1';
        $upManager = new UploadManager();
        $auth = new Auth($accessKey,$secretKey);
        $token = $auth->uploadToken($bucketName);
        list($ret,$error) = $upManager->put($token,'formput', 'hello world');
        var_dump($ret);
        homePrint($error);
        die;
    }
}