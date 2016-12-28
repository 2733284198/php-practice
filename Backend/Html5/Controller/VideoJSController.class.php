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

    public function test()
    {
        $this->display();
    }

}