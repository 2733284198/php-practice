<?php
namespace Api\Controller;

use Think\Controller;

class IndexController extends Controller
{
    /**
     * API 接口的签名方式
     * 【1】key 双方约定的公钥
     * 【2】password
     * 【3】uniqueId
     * 【4】username
     * 【5】time()
     * 【6】加密方式(顺序):MD5（password+uniqueId+username+time()+key）
     */
    public function sign()
    {
        $key = C('API_SECRET_KEY');  //公钥
        $password = $_POST['password'];
        $uniqueId = $_POST['uniqueId'];
        $username = $_POST['username'];
        $time = $_POST['time']; // 这里时间必须和和服务器的时间匹配
        $sign = $_POST['sign'];
        $serverSign = md5($password.$uniqueId.$username.$time.$key);
        if($serverSign != $sign){
            echo '签名失败';
        }
    }

}