<?php
return array(
	//=============================支付宝信息===============================================================
    'ALIPAY_CONFIG'          => array(
        'partner'            => '2088802807619823', // partner 从支付宝商户版个人中心获取
        'seller_email'       => 'mzhsoft@126.com', // email 从支付宝商户版个人中心获取
        'key'                => 'k2zu8i7h9enbkafsvtfrgdcuy1n273qn', // key 从支付宝商户版个人中心获取
        'sign_type'          => strtoupper(trim('MD5')), // 可选md5  和 RSA
        'input_charset'      => 'utf-8', // 编码 (固定值不用改)
        'transport'          => 'http', // 协议  (固定值不用改)
        'cacert'             => VENDOR_PATH.'Alipay/cacert.pem',  // cacert.pem存放的位置 (固定值不用改)
        'notify_url'         => 'http://baijunyao.com/Api/Alipay/alipay_notify', // 异步接收支付状态通知的链接
        'return_url'         => 'http://baijunyao.com/Api/Alipay/alipay_return', // 页面跳转 同步通知 页面路径 支付宝处理完请求后,当前页面自 动跳转到商户网站里指定页面的 http 路径。 (扫码支付专用)
        'show_url'           => 'http://baijunyao.com/User/Order/index', // 商品展示网址,收银台页面上,商品展示的超链接。 (扫码支付专用)
        'private_key_path'   => '', //移动端生成的私有key文件存放于服务器的 绝对路径 如果为MD5加密方式；此项可为空 (移动支付专用)
        'public_key_path'    => '', //移动端生成的公共key文件存放于服务器的 绝对路径 如果为MD5加密方式；此项可为空 (移动支付专用)
    ),
);