<?php
namespace Html5\Controller;

use Think\Controller;

class JPlayerController extends Controller
{
    //原始地址播放
    public function index()
    {
        echo 'JPlayer';
    }

    // 用户自定义地址去播放视频
    public function demo1()
    {
        $this->display();
    }

    // 用户自定义地址去播放视频
    public function demo2()
    {
        $this->display();
    }

    // 用户自定义地址去播放视频
    public function demo3()
    {
        $this->display();
    }

    // 用户自定义地址去播放视频
    public function rtmp()
    {
        $this->display();
    }


}