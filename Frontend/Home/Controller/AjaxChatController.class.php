<?php
namespace Home\Controller;
use Think\Controller;

/**
 * Class JqueryController
 * @package Home\Controller
 */
class AjaxChatController extends Controller
{
    public function index()
    {
        $this->display();
    }

    public function demo1(){
        $this->display();
    }

    public function login(){
        echo '1111111111';
    }

    public function saveContent(){

    }

    public function chatMain(){
        $this->display();
    }

    public function ChatList(){
        echo 1111111111111;
    }

    public function OnlineList(){
        echo 1111111111111;
    }
}