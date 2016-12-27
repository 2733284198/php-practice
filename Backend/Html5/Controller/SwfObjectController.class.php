<?php
namespace Html5\Controller;

use Think\Controller;

class SwfObjectController extends Controller
{
    //香港直播地址：rtmp://live.hkstv.hk.lxdns.com/live/hks
    public function index()
    {
//        $this->play_address = 'rtmp://live.hkstv.hk.lxdns.com/live/hks';
        $this->play_address = 'rtmp://leplay.amaitech.com/test/123456';
        $this->display();
    }

    //swfobject
    public function swfobject()
    {
        $this->play_address = 'http://leplay.amaitech.com/test/123456/desc.m3u8';
        $this->display();
    }

    //swfobject swfobject
    public function staticswfobject()
    {
        $this->play_address = 'rtmp://live.hkstv.hk.lxdns.com/live/hks';
        $this->display();
    }


}