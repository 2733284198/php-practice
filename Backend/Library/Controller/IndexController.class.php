<?php
namespace Library\Controller;

use Think\Controller;

class IndexController extends Controller
{
    public function index()
    {
        echo 'Vendor';
    }

    /**
     * 生成二维码
     */
    public function qrcode(){
        $url = 'http://www.cnblogs.com/tinywan/';
        qrcode($url);
    }

    /**
     * 生成pdf
     */
    public function pdf(){
        $content = $_GET['content'];
        pdf($content);
    }

    /**
     * 发送邮件
     */
    public function send_email()
    {
        $name = I('post.name', '这是一份测试邮件名称');
        $address = I('post.address', '这是一份测试邮件发送的地址');
        $phone = I('post.phone', '13669361192');
        $email = '2680737855@qq.com';
        $str = <<<html
            姓名：$name <br>
            地址：$address <br>
            手机号：$phone
html;
        $result = send_email($email, '这个邮件是我用来做测试的,亲！', $str);
        if ($result['error'] == 1) {
            var_dump($result);
            die;
        }
        var_dump('发送完成');
    }

}