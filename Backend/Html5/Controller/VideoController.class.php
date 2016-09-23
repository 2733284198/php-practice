<?php
namespace Html5\Controller;

use Think\Controller;

class VideoController extends Controller
{
    public function VideoTest()
    {
        $this->display();
    }

    // 获取一个签名Token
    public function getSign()
    {
        echo '111111111';
        var_dump($_SERVER['REMOTE_ADDR']);
        $this->display();
    }

    // 获取一个签名Token
    public function Sign()
    {
        $openId = 'ojMruvwwF-GoBK3_Qr4WEbzM1SCw';
        $userId = 420;
        $key = 'ford4s.amailive.com'; // 公钥
        $sign = md5($openId.$userId.$key);
        var_dump($sign);
        $response = [
            'statusCode' => 200,
            'openId' => $openId,
            'userId' => $userId,
            'sign' => $sign
        ];
        $this->ajaxReturn($response, 'JSON');
    }

}