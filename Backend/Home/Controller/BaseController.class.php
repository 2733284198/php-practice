<?php
namespace Home\Controller;

use Think\Controller;

class BaseController extends Controller
{
    /**
     * ThikPHP自动运行方法，每一次，都会自动运行这个方法
     */
    public function _initialize(){
        if(!isset($_SESSION['username']))
        {
            return $this->redirect('Login/index');
        }
    }
}