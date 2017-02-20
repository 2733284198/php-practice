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

class StringController extends Controller
{
    public function index()
    {
        $appId = 75715888;
        $domainName = 'zonelue2.amailive.com';
        $appName = 'live';
        $streamName = '4001487324388';
        $resumeTime = '2017-11-30  09:15:00';
        $serviceArea = 'A';
        //签名密钥
        $appSecret = 'eb9a365a9d37a1354e13ddd7973d5e02409ef451';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DomainName" . $domainName . "ResumeTime" . $resumeTime . "ServiceArea" . $serviceArea . "StreamName" . $streamName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://sewise.amai8.com/openapi/setForbidLiveStream?AppId=" . $appId . "&AppName=" . $appName . "&DomainName=" . $domainName . "&ResumeTime=" . $resumeTime . "&ServiceArea=" . $serviceArea . "&StreamName=" . $streamName . "&Sign=" . $sign;
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