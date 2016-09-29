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

    /**
     * txSecret是您的服务器计算出来的一个安全签名，计算公式是：
     * txSecret = MD5( KEY + stream_id + txTime )
     * 【1】KEY：安全密钥(推流防盗链KEY)
     * 【2】stream_id：直播码
     * 【3】txTime：该播放器的有效时间,比如5分钟，当这个地址在5分钟后被再次使用时，腾讯云将会判定其为过期地址而拒绝服务
     * 但我们知道，简单声明txTime是没有意义的，因为任何攻击者都可以在一个窃取的URL后面拼接上一个声明100天过期的txTime，
     * 所以腾需要有一种安全措施确保攻击者无法伪造txTime，这个安全措施就是txSecret。
     * 【5】MD5：最著名的单向不可逆HASH算法了
     */
    public function txSecret()
    {
        $KEY = '87fc99742fbec4082447cbcb479265ef';
        $stream_id  = '8888_test001';
        $txTime = $this->txTime();
        $txSecret = md5($KEY.$stream_id.$txTime);
        var_dump($txSecret);
    }

    /**
     * 生成txTime
     * 签名中明文部分为txTime，含义是该链接的有效期，比如现在我当前的时间是2016-07-29 11:13:45，
     * 而且期望新生成的URL是在5分钟后即作废，那么txTime就可以设置为 2016-07-29 11:18:45。不过这么长一串时间字符串放在URL里显然不太“经济”，
     * 实际适用中，我们是把 2016-07-29 11:18:45 转换成Unix时间戳，也就是1469762325 （转换方式各种后台编程语言都由直接可用的时间函数来处理），
     * 然后转换成16进制，也就是 txTime=579ACB15。
     */
    public function txTime($currentTime = '2016-07-29 11:13:45',$expireTime = 60)
    {
       //把 2016-07-29 11:18:45 转换成Unix时间戳
       $UnixTime = strtotime($currentTime)+$expireTime;
       //然后十进制转换成16进制
       $lastTime = dechex($UnixTime);
       return $lastTime;
    }



}