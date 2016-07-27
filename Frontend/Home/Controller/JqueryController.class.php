<?php
namespace Home\Controller;
use Think\Controller;

/**
 * Class JqueryController
 * @package Home\Controller
 */
class JqueryController extends Controller
{
    public function index()
    {
        echo 'Jquery123213';
    }

    public function demo1(){
        $this->display();
    }

    public function event()
    {
        $this->display();
    }

    public function loading(){
        if($_GET[id] == 'hello'){
            echo 'hello';
        }else{
            echo 'XXXXXXXXXXXXXX';
        }
    }

    public function ajax1()
    {
        $this->display();
    }

    /**
     * 全局事件
     */
    public function ajaxStart()
    {
        $this->display();
    }

    public function startData()
    {
        sleep(10);
        if($_POST['username'] == 'wanwan'){
            echo 'wanwan ning hao';
        }else{
            echo 'XXXXXXXXXXXXXX';
        }
    }

    public function jsonp(){
        $this->display();
    }

    /**
     * Jquery 的节点操作
     */
    public function jqueryDom1(){
        $url = 'http://testnew.vxin365.com/index.php/Api/Api/getComment/id/1';
        print_r(curlPost($url,$data=''));
        var_dump(json_decode('{
    "count": 8,
    "eva": 4,
    "info": [
        {
            "geval_id": "1",
            "geval_orderno": "0",
            "geval_orderid": "1",
            "geval_ordername": "欧盟课程",
            "geval_scores": "5",
            "geval_content": "水电费水电费",
            "geval_addtime": "2315645",
            "geval_openid": "1",
            "geval_frommembername": "呵护",
            "head_img_url": "http://wx.qlogo.cn/mmopen/ScHWOv4lX70K54E80vy8eovjib5Yh9aFmewaSnIIvDUpqAuo5GhCs8bcRMcGRHaBbiaBic8Emv5iagPU6okJCnkAPI9keKIJoKicn/0"
        },
        {
            "geval_id": "9",
            "geval_orderno": "1",
            "geval_orderid": "1",
            "geval_ordername": "艾的课程",
            "geval_scores": "5",
            "geval_content": "dsifj",
            "geval_addtime": "1469004518",
            "geval_openid": "1",
            "geval_frommembername": "认同感",
            "head_img_url": "http://wx.qlogo.cn/mmopen/ScHWOv4lX70K54E80vy8eovjib5Yh9aFmewaSnIIvDUpqAuo5GhCs8bcRMcGRHaBbiaBic8Emv5iagPU6okJCnkAPI9keKIJoKicn/0"
        },
        {
            "geval_id": "10",
            "geval_orderno": "1",
            "geval_orderid": "1",
            "geval_ordername": "艾的课程",
            "geval_scores": "3",
            "geval_content": "sdf",
            "geval_addtime": "1469007581",
            "geval_openid": "1",
            "geval_frommembername": "认同感",
            "head_img_url": "http://wx.qlogo.cn/mmopen/ScHWOv4lX70K54E80vy8eovjib5Yh9aFmewaSnIIvDUpqAuo5GhCs8bcRMcGRHaBbiaBic8Emv5iagPU6okJCnkAPI9keKIJoKicn/0"
        },
        {
            "geval_id": "11",
            "geval_orderno": "1",
            "geval_orderid": "1",
            "geval_ordername": "艾的课程",
            "geval_scores": "1",
            "geval_content": "sdf",
            "geval_addtime": "1469007884",
            "geval_openid": "1",
            "geval_frommembername": "认同感",
            "head_img_url": "http://wx.qlogo.cn/mmopen/ScHWOv4lX70K54E80vy8eovjib5Yh9aFmewaSnIIvDUpqAuo5GhCs8bcRMcGRHaBbiaBic8Emv5iagPU6okJCnkAPI9keKIJoKicn/0"
        },
        {
            "geval_id": "12",
            "geval_orderno": "1",
            "geval_orderid": "1",
            "geval_ordername": "艾的课程",
            "geval_scores": "5",
            "geval_content": "sdfsdf",
            "geval_addtime": "1469152030",
            "geval_openid": "1",
            "geval_frommembername": "认同感",
            "head_img_url": "http://wx.qlogo.cn/mmopen/ScHWOv4lX70K54E80vy8eovjib5Yh9aFmewaSnIIvDUpqAuo5GhCs8bcRMcGRHaBbiaBic8Emv5iagPU6okJCnkAPI9keKIJoKicn/0"
        },
        {
            "geval_id": "13",
            "geval_orderno": "1",
            "geval_orderid": "1",
            "geval_ordername": "艾的课程",
            "geval_scores": "5",
            "geval_content": "sdfsdf",
            "geval_addtime": "1469152108",
            "geval_openid": "1",
            "geval_frommembername": "认同感",
            "head_img_url": "http://wx.qlogo.cn/mmopen/ScHWOv4lX70K54E80vy8eovjib5Yh9aFmewaSnIIvDUpqAuo5GhCs8bcRMcGRHaBbiaBic8Emv5iagPU6okJCnkAPI9keKIJoKicn/0"
        },
        {
            "geval_id": "14",
            "geval_orderno": "1",
            "geval_orderid": "1",
            "geval_ordername": "艾的课程",
            "geval_scores": "5",
            "geval_content": "sdfsdf",
            "geval_addtime": "1469257326",
            "geval_openid": "1",
            "geval_frommembername": "认同感",
            "head_img_url": "http://wx.qlogo.cn/mmopen/ScHWOv4lX70K54E80vy8eovjib5Yh9aFmewaSnIIvDUpqAuo5GhCs8bcRMcGRHaBbiaBic8Emv5iagPU6okJCnkAPI9keKIJoKicn/0"
        },
        {
            "geval_id": "24",
            "geval_orderno": "1",
            "geval_orderid": "1",
            "geval_ordername": "艾的课程",
            "geval_scores": "3",
            "geval_content": "[em_3]",
            "geval_addtime": "1469259662",
            "geval_openid": "1",
            "geval_frommembername": "认同感",
            "head_img_url": "http://wx.qlogo.cn/mmopen/ScHWOv4lX70K54E80vy8eovjib5Yh9aFmewaSnIIvDUpqAuo5GhCs8bcRMcGRHaBbiaBic8Emv5iagPU6okJCnkAPI9keKIJoKicn/0"
        }
    ]
}',true));
    }

    /**
     * 
     */
    public function jqueryDom(){

    }
}