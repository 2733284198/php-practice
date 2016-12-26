<?php
namespace Html5\Controller;

use Think\Controller;

class SwfObjectController extends Controller
{
    //香港直播地址：rtmp://live.hkstv.hk.lxdns.com/live/hks
    public function index()
    {
//        $this->play_address = 'rtmp://live.hkstv.hk.lxdns.com/live/hks';
        $this->play_address = 'rtmp://121.40.214.99/live/4001482737589';
        $this->display();
    }

    //swfobject
    public function swfobject()
    {
        $this->play_address = 'rtmp://121.40.214.99/live/4001482737589';
        $this->display();
    }

    //swfobject swfobject
    public function staticswfobject()
    {
        $this->play_address = 'rtmp://live.hkstv.hk.lxdns.com/live/hks';
        $this->display();
    }


}