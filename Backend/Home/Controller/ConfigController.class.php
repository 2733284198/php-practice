<?php
namespace Home\Controller;

use Home\Controller\BaseController;

class ConfigController extends BaseController
{
    public function read()
    {
        // 读取配置文件
        echo C('DEL_ADOPT_ANSWER');
        p($_SESSION);
    }

    // 使用定界符
    public function str()
    {
        $ip = get_client_ip();
        $time = date('Y-m-d H:i:s',time());
        $info = <<<str
        {$_SESSION['username']}<br/>
        你的第一个登陆IP:{$ip}<br/>
        登陆时间为：{$time}<br/>
str;
        echo $info;
    }


}