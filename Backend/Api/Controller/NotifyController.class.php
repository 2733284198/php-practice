<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/9/16
 * Time: 10:44
 */
namespace Api\Controller;
use Think\Controller;
class NotifyController extends Controller {
    //同步通知
    public function return_url(){
        $verify = D('Common/Pay')->verifyReturn();
        if($verify){
            $out_trade_no = $_GET['out_trade_no'];
            $trade_no = $_GET['trade_no'];
            $trade_status = $_GET['trade_status'];
            if($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS') {
                $map['out_trade_no'] = $out_trade_no;
                $data['trade_no'] = $trade_no;
                $res = M('alipay')->where($map)->save($data);
                if($res !== false){
                    echo 'success,return_url'.$res;
                }
            }
        }

    }

    //异步通知
    public function notify_url(){
        $verify = D('Common/Pay')->verifyNotify();
        if($verify){
            $out_trade_no = $_POST['out_trade_no'];
            $trade_no = $_POST['trade_no'];
            $trade_status = $_POST['trade_status'];
            if($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS') {
                $map['out_trade_no'] = $out_trade_no;
                $data['trade_no'] = $trade_no;
                $res = M('alipay')->where($map)->save($data);
                if($res !== false){
                    echo 'success notify_url--$res';
                }
            }
        }
    }

    public function test(){
        $map['id'] = 4 ;
        var_dump($map);
    }
}