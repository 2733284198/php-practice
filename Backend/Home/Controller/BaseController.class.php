<?php
namespace Home\Controller;

use Think\Controller;

class BaseController extends Controller
{
    /**
     * ThikPHP自动运行方法，每一次，都会自动运行这个方法
     * 要判断一个session值是否已经设置，可以使用
       session('?name'); 相当于：isset($_SESSION['name']);
     */
    public function _initialize(){
        if(!session('?username'))
        {
            return $this->redirect('Login/index');
        }
    }
}