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

    /**
     * 商品显示列表
     */
    public function index()
    {
        $map['id'] = 3;
        $info = M('alipay')->where($map)->find();
        $this->info = $info;
        $this->display();
    }

    /**
     * 订单异步提交数据
     */
    public function payTo()
    {
        $data['subject'] = $_POST['subject'];  //商品名称
        $data['out_trade_no'] = $_POST['out_trade_no']; //商户网站唯一订单号
        $data['total_fee'] = $_POST['total_fee'];   //交易金额
        $res = D('Common/Pay')->alipay($data);
        $this->ajaxReturn($res);
    }

    /**
     * 退款
     */
    public function refund()
    {
        header("Content-type:text/html;charset=utf-8");
        $data['batch_no'] = date('YmdHis') . 'MZ01';
        $data['batch_num'] = 1;
        $data['detail_data'] = '2016091621001004480242264394^0.01^协商退款01';
        $res = D('Common/Refund')->refund($data);
        //var_dump($res); 这个用在测试的时候，如果打印的是一个表单的话表示错误
        echo($res);
    }

    //同步通知
    public function return_url()
    {
        $verify = D('Common/Pay')->verifyReturn();  //验证是否是支付宝发过来的信息
        if ($verify) {
            $out_trade_no = $_GET['out_trade_no'];
            $trade_no = $_GET['trade_no'];
            $trade_status = $_GET['trade_status'];
            if ($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS') {
                $map['out_trade_no'] = $out_trade_no;
                $data['trade_no'] = $trade_no;
                $res = M('alipay')->where($map)->save($data);
                if ($res !== false) {
                    echo 'success,return_url' . $res;
                }
            }
        }

    }

    //异步通知
    public function notify_url()
    {
        $verify = D('Common/Pay')->verifyNotify(); //验证是否是支付宝发过来的信息
        if ($verify) {
            $out_trade_no = $_POST['out_trade_no'];
            $trade_no = $_POST['trade_no'];
            $trade_status = $_POST['trade_status'];
            if ($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS') {
                $map['out_trade_no'] = $out_trade_no;
                $data['trade_no'] = $trade_no;
                $res = M('alipay')->where($map)->save($data);
                if ($res !== false) {
                    echo 'success notify_url--$res';
                }
            }
        }
    }

}