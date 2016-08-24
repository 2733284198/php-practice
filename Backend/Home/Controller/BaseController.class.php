<?php
namespace Home\Controller;

use Think\Controller;

class BaseController extends Controller
{
//    /**
//     * ThikPHP自动运行方法，每一次，都会自动运行这个方法
//     * 要判断一个session值是否已经设置，可以使用
//       session('?name'); 相当于：isset($_SESSION['name']);
//     */
    public function _initialize(){
//        if(!session('?username'))
//        {
//            return $this->redirect('Login/index');
//        }

        if(!C('WEB_STATE')){
            exit('网站维护中');
        }

        // 自动登录配置
        if(isset($_COOKIE['remember']) && !isset($_SESSION['uid'])){
            // Cookie 解密
            $value = encrytion($_COOKIE['remember']);
            $result = explode('|',$value);
            // 判断IP地址是否一样
            if($result[1] == get_client_ip()){
                session('uid',$result[0]);
                session('uid',$result[2]);
            }
        }

    }

}