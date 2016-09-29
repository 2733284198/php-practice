<?php
namespace Html5\Controller;

use Think\Controller;

class SewiseController extends Controller
{
    public function index()
    {
        $this->display();
    }

    /**
     * 点播MP4视频播放
     */
    public function videoMp4()
    {
        $this->display();
    }

    /**
     * M3U8 src方式嵌入播放，这个可以切换地址播放哦
     */
    public function liveM3u8()
    {
        $this->display();
    }

    /**
     *  M3U8验证地址播放,URL是一个字符串哦
     */
    public function requestM3u8()
    {
        $this->display();
    }

    /**
     *  直播RTMP流播放
     */
    public function rtmpStreamUrl()
    {
        $this->display();
    }

    /**
     *  mp3 音频播放
     */
    public function audio()
    {
        $this->display();
    }





}