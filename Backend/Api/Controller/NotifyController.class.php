<?php
namespace Api\Controller;
use Think\Controller;
class NotifyController extends Controller {
	//同步通知
	public function return_url(){
		$out_trade_no = $_GET['out_trade_no'];
		$trade_no = $_GET['trade_no'];
		$trade_status = $_GET['trade_status'];
		if($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS') {
			$map['out_trade_no'] = $out_trade_no;
			$data['trade_no'] = $trade_no;
			$res = M('alipay')->where($map)->save($data);
			if($res !== false){
				echo 'success';
			}
		}
	}
	
	//异步通知
	public function notify_url(){
		$out_trade_no = $_POST['out_trade_no'];
		$trade_no = $_POST['trade_no'];
		$trade_status = $_POST['trade_status'];
		if($trade_status == 'TRADE_FINISHED' || $trade_status == 'TRADE_SUCCESS') {
			$map['out_trade_no'] = $out_trade_no;
			$data['trade_no'] = $trade_no;
			$res = M('alipay')->where($map)->save($data);
			if($res !== false){
				echo 'success';
			}
		}
	}
}