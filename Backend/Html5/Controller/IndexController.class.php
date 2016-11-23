<?php
namespace Html5\Controller;

use Think\Controller;

class IndexController extends Controller
{
    public function test()
    {
        echo 'Html5';
    }

    public function testtpl()
    {
        $this->display();
    }

    public function setTimeOut()
    {
        $this->display();
    }

    public function getStreamName(){
        $string = 'rtmp://120.26.206.180/live/1479792068:uid_744072?tokenSecret=';
        $reg = '/[0-9]\d{9}/';
        preg_match($reg, $string, $matches);
        var_dump($matches);
        var_dump(microtime());
    }

    public function echarts()
    {
        $this->display();
    }

}