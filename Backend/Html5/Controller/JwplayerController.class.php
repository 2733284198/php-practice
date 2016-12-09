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
        $this->play_address = 'rtmp://tinywan.amai8.com/live123/4001481269282';
        $this->display();
    }

    //swfobject swfobject
    public function oldswfobject()
    {
        $this->display();
    }

    public function onlyvideo(){
        $this->display();
    }

    /**
     * 跨域资源共享（CORS）
     * https://help.aliyun.com/document_detail/31928.html
     */
    public function cors(){
        $this->display();
    }

}