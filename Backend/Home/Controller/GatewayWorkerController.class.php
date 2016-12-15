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
        $this->display();
    }

    /**
     * Gateway::$registerAddress = '120.26.220.223:1236';
     * 这个链接的地址是这个文件中的:start_register.php
     * register 服务必须是text协议
     * $register = new Register('text://0.0.0.0:1236');
     */
    public function bindUid()
    {
        /**
         *====这个步骤是必须的====
         *这里填写Register服务的ip（通常是运行GatewayWorker的服务器ip）和端口
         *注意Register服务端口在start_register.php中可以找到（chat默认是1236）
         *这里假设GatewayClient和Register服务都在一台服务器上，ip填写127.0.0.1
         **/
        Gateway::$registerAddress = '120.26.220.223:1236'; //这个链接的地址是start_register.php
        //接受异步参数
        $clientId = I('post.client_id');
        $uid = $_SESSION['uid'];
        $message = [
            'type' => 4002,
            'clientId' => $clientId,
            'publish_time' => date('Y-m-d h:i:s', time())
        ];
        // 注意除了不支持sendToCurrentClient和closeCurrentClient方法，其它方法都支持
        Gateway::bindUid($clientId,$uid);
        //在这里发送的信息是不走Event.php文件的，直接广播出去了
        Gateway::sendToClient($clientId,json_encode($message));
    }

    //异步绑定用户信息通过Websocket,Gateway绑定是有问题的
    public function demoBindUid()
    {
        $this->display();
    }

    //处理Ajax请求的数据
    public function demoBindUidAjax()
    {
        Gateway::$registerAddress = '120.26.220.223:1236'; //这个链接的地址是start_register.php
        $clientId = I('post.client_id');
        $uid = $_SESSION['uid'];
        $message = [
            'type' => 4002,
            'clientId' => $clientId,
            'userId' => $uid,
            'isOnline' => Gateway::isOnline('781adcdf0e750000001e')
        ];
        Gateway::sendToClient($clientId,json_encode($message));
        exit(json_encode($message));
    }

    //本地测试
    public function testBindUid()
    {
        Gateway::$registerAddress = '120.26.220.223:1236'; //这个链接的地址是start_register.php
        $uid = $_SESSION['uid'];
        var_dump(Gateway::getClientIdByUid($uid));
    }

    //本地测试
    public function windowsLocalHost()
    {
        $this->display();
    }

    /**
     * 处理信息的接口
     * 【1】sendToAll 只能发送字符串或者json_encode（数组），不能够直接发送数组
     */
    public function handleMessage()
    {
        Gateway::$registerAddress = '120.26.220.223:1236';
        $token = $_POST['token'];
        $clientId = $_POST['clientId'];
        $content = $_POST['content'];
        $message = [
            'type' => 4002,
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


}