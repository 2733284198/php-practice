<?php
return array(
    /*微信网页授权配置信息*/
    'WECHAT_OAUTH2' => array(
        'APPID'     => 'wx94c43716d8a91f3f', // 微信支付APPID
        'APPSECRET' => 'd4624c36b6795d1d99dcf0547af5443d', // 公众帐号secert (公众号支付专用)
        'DOMAIN'    => 'wechatu.xd107.com', // 接收支付状态的连接
        'REDIRECT_URL' => $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'] //回调函数地址
    ),
    'WECHAT_OPEN' => array(
        'APPID'     => 'wx0a521f5ee669ca91', // 微信支付APPID
        'APPSECRET' => 'cd045c6675c3d522561a81f4c8541192', // 公众帐号secert (公众号支付专用)
        'DOMAIN'    => 'www.amailive.com', // 接收支付状态的连接
    ),
);