<?php
namespace Html5\Controller;

use Think\Controller;

class JwplayerController extends Controller
{
    //原始地址播放
    public function index()
    {
        $this->display();
    }

    // 用户自定义地址去播放视频
    public function inputPlay()
    {
        $this->display();
    }

    //swfobject
    public function swfobject()
    {
        $this->display();
    }

    //swfobject
    public function oldswfobject()
    {
        $this->display();
    }

    public function onlyvideo(){
        $this->display();
    }

}