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
     *
     */
    public function inputPlayM3u8()
    {
        header("Access-Control-Allow-Origin: *");
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
        $this->display();
    }

}