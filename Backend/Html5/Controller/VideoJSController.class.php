<?php
namespace Html5\Controller;

use Think\Controller;

class VideoJSController extends Controller
{
    public function index()
    {
        echo 'VideoJS';
    }

    public function test()
    {
        $this->display();
    }

}