<?php
namespace Home\Controller;


use Org\Util\Context;
use Org\Util\Gateway;
use Think\Controller;

class GatewayWorkerController extends Controller
{
    public function _initialize()
    {

    }

    public function index()
    {
        echo 'GatewayWorker';
    }

    /**
     * 处理信息的接口
     * 【1】sendToAll 只能发送字符串或者json_encode（数组），不能够直接发送数组
     */
    public function handleMessage()
    {
        Gateway::$registerAddress = '120.26.220.223:1238';
        $token = $_POST['token'];
        $clientId = $_POST['clientId'];
        $content = $_POST['content'];
        $message = [
            'clientId' => $clientId,
            'content' => $content,
            'token' => $token,
            'publish_time' => date('Y-m-d h:i:s', time())
        ];

        $sendResult = Gateway::sendToAll(json_encode($message));
        if ($sendResult == false) {
            $arr = [
                'status' => 500,
                'message' => 'send fail!',
                'content' => $content
            ];
        } else {
            $arr = [
                'status' => 200,
                'message' => 'send success!',
                'content' => $content
            ];
        }

        exit(json_encode($arr));
    }

    /**
     * WebSocket 消息页面
     */
    public function WebSocket()
    {
        $this->display();
    }

    /**
     * WebSocket 消息页面
     */
    public function clientIdToAddress()
    {
        p($this->getClientIp());
    }

    /**
     * sendToAll 只能发送字符串，不能够发送数组
     */
    public function sendToAll()
    {
        $clientId = '781adcdf0a8f00000019';
        $message = [
            'user_id' => 42000000,
            'show' => 1,
            'bindUid' => 1,  // 判断clientId是否和Userid已经绑定, 1:已经绑定 ，0:没有绑定 汇纱
            'is_repeal' => 0,  // 1：正在维修的话，则一直可以检查权限。 0：表示已经维修结束了，就不需用再去判断是都有权限了
            'publish_time' => date('Y-m-d h:i:s', time())
        ];
        $sendResult = Gateway::sendToAll($clientId);
        if ($sendResult == false) {
            echo 'send fail';
        } else {
            echo 'send success!';
        }
    }

    public function getAllClientCount()
    {
        var_dump(Gateway::getAllClientCount());
    }

    /**
     * 获取客户端IP
     */
    public function getClientIp()
    {
        $ip = 'unknown';
        $unknown = 'unknown';

        if (isset($_SERVER['HTTP_X_FORWARDED_FOR']) && $_SERVER['HTTP_X_FORWARDED_FOR'] && strcasecmp($_SERVER['HTTP_X_FORWARDED_FOR'], $unknown)) {
            // 使用透明代理、欺骗性代理的情况
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];

        } elseif (isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'], $unknown)) {
            // 没有代理、使用普通匿名代理和高匿代理的情况
            $ip = $_SERVER['REMOTE_ADDR'];
        }

        // 处理多层代理的情况
        if (strpos($ip, ',') !== false) {
            // 输出第一个IP
            $ip = reset(explode(',', $ip));
        }
        return $ip;
    }

}