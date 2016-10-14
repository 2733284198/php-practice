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
     *  RTMP src方式嵌入播放
     */
    public function rtmpStreamSrc()
    {
        $this->display();
    }

    /**
     *  M3U8 https播放
     */
    public function m3u8Https()
    {
        $this->display();
    }

    /**
     *  如果上面的rtmp流无法播放，就播放hls流
     */
    public function rtmpm3u8()
    {
        $this->display();
    }


    public function live_streamurl_rtmp(){
        $this->display();
    }

    /**
     *  mp3 音频播放
     */
    public function audio()
    {
        $this->display();
    }

    public function curl()
    {
        $result = Get("http://121.43.63.240/control/record/start?app=live&name=L00735&rec=rec1");
        var_dump($result);
    }

    /**
     *  如果上面的rtmp流无法播放，就播放hls流
     */
    public function json_url()
    {
        $this->display();
    }

    /**
     *  全屏控制，就播放hls流
     */
    public function fullscreen_control()
    {
        $this->display();
    }

    /**
     *  Transparent皮肤
     */
    public function Transparent()
    {
        $this->display();
    }










}