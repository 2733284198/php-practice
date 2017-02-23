<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/20
 * |  Time: 8:36
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Home\Controller;


use Think\Controller;
use Think\Log;

class StringController extends Controller
{
    const F0 = 0x1; // 2^0
    const F1 = 0x2; // 2^1
    const F2 = 0x4; // 2^2
    const F3 = 0x8; // 2^3
    const F4 = 0x10; // 2^4
    const F5 = 0x20; // 2^5

    public function index2()
    {
        //请求参数
        $appId = 757158800;
        $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $DeviceId = 2801;
        //签名密钥
        $appSecret = '5fa09735ce5de5d194fb7f2daa4289f53634d314';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DeviceId" . $DeviceId . "DomainName" . $domainName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://sewise.amai8.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName . "&DeviceId=" . $DeviceId . "&DomainName=" . $domainName . "&Sign=" . $sign;
        //CURL方式请求
        $ch = curl_init() or die (curl_error());
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 360);
        $response = curl_exec($ch);
        curl_close($ch);
        //返回数据为JSON格式，进行转换为数组打印输出
        var_dump(json_decode($response, true));
    }

    public function index()
    {
        //请求参数
        phpinfo();
        die;
        $appId = 757158800;
        $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        //签名密钥
        $appSecret = '5fa09735ce5de5d194fb7f2daa4289f53634d314';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DomainName" . $domainName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://sewise.amai8.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName . "&DomainName=" . $domainName . "&Sign=" . $sign;
        //CURL方式请求
        $ch = curl_init() or die (curl_error());
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 360);
        $response = curl_exec($ch);
        curl_close($ch);
        //返回数据为JSON格式，进行转换为数组打印输出
        var_dump(json_decode($response, true));
    }



    /**
     * 字符串运算符
     * Shell变量：推荐给所有变量加上花括号，这是个好的编程习惯：echo "I am good at ${skill}Script"
     */
    public function stringOperator()
    {
        $_CUSTOM = array('USERNAME' => 'john', 'USERID' => '18068416846');
        $globals = array(
            '$_SERVER' => $_SERVER, '$_ENV' => $_ENV,
            '$_REQUEST' => $_REQUEST, '$_GET' => $_GET,
            '$_POST' => $_POST, '$_COOKIE' => $_COOKIE,
            '$_FILES' => $_FILES, '$_CUSTOM' => $_CUSTOM
        );
        homePrint($globals);
        //第一个是连接运算符（“.”），它返回其左右参数连接后的字符串
        $a = "Hello ";
        $b = $a . "World!"; // now $b contains "Hello World!"

        //第二个是连接赋值运算符（“.=”），它将右边参数附加到左边的参数之后
        $a = "Hello ";
        $a .= "World!";     // now $a contains "Hello World!"

        $str = <<<EOD
Example of string
spanning multiple lines
using heredoc syntax.
EOD;
        echo $str;
    }
}