<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/8/19
 * Time: 9:18
 * Mail: Overcome.wan@Gmail.com
 */
namespace Api\Controller;

use Think\Controller;

class AliPayController extends Controller
{

    public function index()
    {
        $map['id'] = 2;
        $info = M('alipay')->where($map)->find();
        $this->info = $info;
        $this->display();
    }

    public function payTo()
    {
        $data['subject'] = $_POST['subject'];
        $data['out_trade_no'] = $_POST['out_trade_no'];
        $data['total_fee'] = $_POST['total_fee'];
        $res = D('Common/Pay')->alipay($data);
        $this->ajaxReturn($res);
    }

}