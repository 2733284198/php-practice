<?php
header("Content-type:text/html;charset=utf-8");

/**
 * 获取一个随机码
 * @return string
 */
function getRandCode()
{
    $randArr = $_SERVER['HTTP_USER_AGENT'] . $_SERVER['REMOTE_ADDR'] . time() . rand();
    return sha1($randArr);
}

function getAccessToken()
{
    $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" . C('WECHAT_OAUTH2.APPID') . "&secret=" . C('WECHAT_OAUTH2.APPSECRET');
    /*这里接收到的data数据是Json格式的，我在这转换成数组了*/
    $result = json_decode(curlPost($url, $parameter = ''), true);
    /*取出数组中的access_token这个值*/
    $access_token = $result['access_token'];
    return $access_token;
}