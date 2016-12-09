<?php
namespace Html5\Controller;

use Think\Controller;

class SwfObjectController extends Controller
{
    //香港直播地址：rtmp://live.hkstv.hk.lxdns.com/live/hks
    public function index()
    {
        $this->play_address = 'rtmp://live.hkstv.hk.lxdns.com/live/hks';
        $this->display();
    }

    //swfobject
    public function swfobject()
    {
        $this->play_address = 'rtmp://tinywan.amai8.com/live123/4001481269282';
        $this->display();
    }

    //swfobject swfobject
    public function staticswfobject()
    {
        $this->play_address = 'rtmp://live.hkstv.hk.lxdns.com/live/hks';
        $this->display();
    }


}