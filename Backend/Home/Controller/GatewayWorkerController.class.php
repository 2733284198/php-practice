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
        $clientId = I('post.client_id');
        $uid = $_SESSION['uid'];
        Gateway::$registerAddress = '120.26.220.223:1236'; //这个链接的地址是start_register.php
        Gateway::bindUid($clientId,$uid);
        Gateway::sendToAll(json_encode($clientId));
    }

    public function testBindUid()
    {
        // 设置GatewayWorker服务的Register服务ip和端口，请根据实际情况改成实际值
        Gateway::$registerAddress = '120.26.220.223:1236';
        $uid = $_SESSION['uid'];
        // client_id与uid绑定
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