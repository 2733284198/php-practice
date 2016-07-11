<?php
namespace Home\Controller;
use Think\Controller;

/**
 * Class JqueryController
 * @package Home\Controller
 */
class JqueryController extends Controller
{
    public function index()
    {
        echo 'Jquery123213';
    }

    public function demo1(){
        $this->display();
    }

    public function event()
    {
        $this->display();
    }

    public function loading(){
        if($_GET[id] == 'hello'){
            echo 'hello';
        }else{
            echo 'XXXXXXXXXXXXXX';
        }
    }

    public function ajax1()
    {
        $this->display();
    }

    /**
     * 全局事件
     */
    public function ajaxStart()
    {
        $this->display();
    }

    public function startData()
    {
        sleep(10);
        if($_POST['username'] == 'wanwan'){
            echo 'wanwan ning hao';
        }else{
            echo 'XXXXXXXXXXXXXX';
        }
    }

    public function jsonp(){
        $this->display();
    }
}