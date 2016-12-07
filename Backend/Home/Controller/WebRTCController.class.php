<?php
namespace Home\Controller;


class WebRTCController extends BaseController
{
    public function index()
    {
        echo 'Welocome WebRTC';
    }

    public function test()
    {
        $this->display('WebRTC/test');
    }

    /**
     * 一个超级简单的例子
     * 这里写一个超级简单的例子，用来展现getUserMedia的效果：
     */
    public function getUserMedia()
    {
        $this->display('WebRTC/getusermedia');
    }
}