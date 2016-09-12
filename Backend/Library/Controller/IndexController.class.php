<?php
namespace Library\Controller;

use Think\Controller;

class IndexController extends Controller
{
    public function index()
    {
        echo 'Vendor';
    }

    /**
     * 生成二维码
     */
    public function qrcode(){
        $url = 'http://www.cnblogs.com/tinywan/';
        qrcode($url);
    }

    /**
     * 生成pdf
     */
    public function pdf(){
        $content = $_GET['content'];
        pdf($content);
    }

}