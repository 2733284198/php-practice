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
        $data['show_url'] = $_POST['show_url'];             // 商品展示网址,收银台页面上,商品展示的超链接
        $data['subject'] = $_POST['subject'];              //商品订单名称
        $data['out_trade_no'] = $_POST['out_trade_no'];    //商户网站唯一订单号
        $data['total_fee'] = $_POST['total_fee'];          //交易金额
        $data['service'] = 'create_direct_pay_by_user';    //交易金额
        $data['partner'] = '2088802807619823';             // 卖家支付宝帐户必填 从支付宝商户版个人中心获取
        $data['seller_email'] = 'mzhsoft@126.com';         // email 从支付宝商户版个人中心获
        $data['payment_type'] = 1;                         // 支付类型对应请求时的 payment_type 参数,原样返回。固定设置为1即可
        $data['notify_url'] = 'http://wechatu.xd107.com/pay/Alipay/notify_url';   // 异步接收支付状态通知的链接
        $data['return_url'] = 'http://wechatu.xd107.com/pay/Alipay/return_url';   // 页面跳转 同步通知 页面路径
        $data['_input_charset'] = 'utf-8';                 // 编码格式
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
        $verify = D('Common/Pay')->verifyReturn();  //计算得出通知验证结果,验证是否是支付宝发过来的信息
        if ($verify) {
            $out_trade_no = $_GET['out_trade_no']; //商户订单号
            $trade_no = $_GET['trade_no'];    //支付宝交易号
            $trade_status = $_GET['trade_status']; //交易状态
            if ($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS') //状态为成功
            {
                //处理自己网站的业务逻辑
                //根据订单号判断本地数据库中的订单是否已经处理
                //如果没处理就将状态改成已经处理
                //金钱的增加
                $model = M('alipay');
                $status = $model->where(array())->getField('status');
                $map['out_trade_no'] = $out_trade_no;
                $data['trade_no'] = $trade_no;
                $res = $model->where($map)->save($data);
                if ($res !== false) {
                    echo 'success';
                }
            }
        } else {
            //验证失败
            echo "fail";
        }

    }

    //异步通知
    public function notify_url()
    {
        $verify = D('Common/Pay')->verifyNotify(); //计算得出通知验证结果,验证是否是支付宝发过来的信息
        if ($verify)
        {
            //商户订单号
            $out_trade_no = $_POST['out_trade_no'];
            //支付宝交易号
            $trade_no = $_POST['trade_no'];
            //交易状态
            $trade_status = $_POST['trade_status'];
            //实例化数据库模型
            $model = M('alipay');
            $condition['out_trade_no'] = ':out_trade_no';
            //判断本地数据库中的订单是否已经处理
            $orderStatus = $model->where($condition)->bind(':out_trade_no',$out_trade_no)->getField('status');
            if ($trade_status == 'WAIT_BUYER_PAY')
            {
                //该判断表示买家已在支付宝交易管理中产生了交易记录，但没有付款
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序
                echo "success";    //请不要修改或删除
                //调试用，写文本函数记录程序运行情况是否正常
                //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
            }
            elseif ($trade_status == 'WAIT_SELLER_SEND_GOODS')
            {
                //该判断表示买家已在支付宝交易管理中产生了交易记录且付款成功，但卖家没有发货

                if(!$orderStatus){
                    $model->where($condition)->bind(':out_trade_no',$out_trade_no)->setField('status');
                    //金钱的增加
                    //.............
                }
                echo "success";    //请不要修改或删除
                //调试用，写文本函数记录程序运行情况是否正常
                //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");

            }
            elseif ($trade_status == 'WAIT_BUYER_CONFIRM_GOODS')
            {
                //该判断表示卖家已经发了货，但买家还没有做确认收货的操作

                if(!$orderStatus){
                    $model->where($condition)->bind(':out_trade_no',$out_trade_no)->setField('status');
                    //金钱的增加
                    //.............
                }
                echo "success";    //请不要修改或删除
                //调试用，写文本函数记录程序运行情况是否正常
                //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");

            }
            elseif ($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS')
            {
                //该判断表示买家已经确认收货，这笔交易完成
                //该判断表示买家已在支付宝交易管理中产生了交易记录，但没有付款
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序
                echo "success";    //请不要修改或删除
                //调试用，写文本函数记录程序运行情况是否正常
                //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
                $map['out_trade_no'] = $out_trade_no;
                $data['trade_no'] = $trade_no;
                $res = M('alipay')->where($map)->save($data);
                if ($res !== false) {
                    echo 'success notify_url--$res';
                }
            }
        } else{
            //验证失败
            echo "fail";
        }
    }

}