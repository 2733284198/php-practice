<?php
namespace Html5\Controller;

use Think\Controller;

class VideoJSController extends Controller
{
    public function index()
    {
        echo 'VideoJS';
    }

    //官方DEM
    public function initDemo()
    {
        $this->display();
    }

    // 播放一个RTMP流VideoJS live RTMP stream, player and video size issue
    public function playRtmp()
    {
        $this->display();
    }

    //自定义播放RTMP
    public function inputPlay(){
        $this->display();
    }

    /**
     * 用户自定义m3u8
     * 跨域问题啊！
     * 一个时间地址：https://d2zihajmogu5jn.cloudfront.net/bipbop-advanced/bipbop_16x9_variant.m3u8
     */
    public function inputPlayM3u8()
    {
        $this->display();
    }

    /**
     * m3u8地址切换播放
     */
    public function switchM3u8()
    {
        $this->display();
    }

    public function test()
    {
        $this->display();
    }

    /**
     * Create your own skin
     */
    public function createSkin()
    {
        header("Access-Control-Allow-Origin: *");
        $this->display();
    }

    /**
     * videoJS常用api，根据videoJS官方文档编写的播放器常用操作
     */
    public function api()
    {
        header("Access-Control-Allow-Origin: *");
        $this->display();
    }

    //简单实现清晰度控制和创建清晰度菜单
    public function controlByte()
    {
        header("Access-Control-Allow-Origin: *");
        $this->display();
    }

}