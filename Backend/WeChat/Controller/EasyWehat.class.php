<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/21
 * |  Time: 9:25
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * |  文档：https://easywechat.org/
 * '-------------------------------------------------------------------*/

namespace WeChat\Controller;


use EasyWeChat\Foundation\Application;
use Think\Controller;

class EasyWehat extends Controller
{
    public function serverCheck()
    {
        $options = [
            'debug'  => true,
            'app_id' => 'your-app-id',
            'secret' => 'you-secret',
            'token'  => 'easywechat',
            // 'aes_key' => null, // 可选
            'log' => [
                'level' => 'debug',
                'file'  => '/tmp/easywechat.log', // XXX: 绝对路径！！！！
            ],
        ];
        $app = new Application($options);
        $response = $app->server->serve();
        // 将响应输出
        $response->send();
    }
}