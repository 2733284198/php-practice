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

    // 根据URl窃取域名
    public function redistest()
    {
        $redis = new \Redis();
        $redis->connect('116.62.28.219','63790');
        $redis->auth('amai_redis_stream_system_requirepass_tinywan');
        $redis->select(12);
        var_dump($redis->keys('*'));
    }

    public function index3()
    {
        //请求参数
        $appId = 75715888;
        $domainName = '10.51.10.172';
        // $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $DeviceId = 2803;
        //签名密钥
        $appSecret = '981119290651e52a52dc469df5eeb638942cc7bb';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DeviceId" . $DeviceId . "DomainName" . $domainName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://ssconsole.amaitech.com/openapi/createDevicePushFlowAddress?AppId=" . $appId . "&AppName=" . $appName . "&DeviceId=" . $DeviceId  . "&DomainName=" . $domainName . "&Sign=" . $sign;
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

    public  function checkApiSign()
    {
        //根据appId查询否存在该用户
        $appSecret = '981119290651e52a52dc469df5eeb638942cc7bb';  //$appSecret = sha1('http://sewise.amai8.com/');
        //去除最后的签名
        unset($allParam['Sign']);
        // 1. 对加密数组进行字典排序
        foreach ($allParam as $key => $value) {
            $sortParam[$key] = $key;
        }
        // 2. 字典排序的作用就是防止因为参数顺序不一致而导致下面拼接加密不同
        sort($sortParam);
        // 3. 将Key和Value拼接
        $str = "";
        foreach ($sortParam as $k => $v) {
            $str = $str . $sortParam[$k] . $allParam[$v];
        }
        //3.将appSecret作为拼接字符串的后缀,形成最后的字符串
        $finalStr = $str . $appSecret;
        //4. 通过sha1加密,转化为大写大写获得签名
        $sign = strtoupper(sha1($finalStr));
        return $sign;
    }

    public function index2()
    {
        //请求参数
        $appId = 75715888;
        $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $DeviceId = 2803;
        //签名密钥
        $appSecret = '981119290651e52a52dc469df5eeb638942cc7bb';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DeviceId" . $DeviceId . "DomainName" . $domainName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://ssconsole.amaitech.com/openapi/createDevicePushFlowAddress?AppId=" . $appId . "&AppName=" . $appName . "&DeviceId=" . $DeviceId . "&DomainName=" . $domainName . "&Sign=" . $sign;
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
        $appId = 75715888;
       $domainName = '10.51.10.172';
        // $domainName = 'tinywan.amai8.com';
        $appName = 'live';
//        $AuthKeyStatus = 0;
        //签名密钥
        $appSecret = '981119290651e52a52dc469df5eeb638942cc7bb';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DomainName" . $domainName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://ssconsole.amaitech.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName ."&DomainName=" . $domainName . "&Sign=" . $sign;
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

    public function getPushFlowInformationById()
    {
        //请求参数
        $appId = 757158800;
        $streamId = 781;
        //签名密钥
        $appSecret = '981119290651e52a52dc469df5eeb638942cc7bb';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "StreamId" . $streamId . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://sewise.amai8.com/openapi/getPushFlowInformationById?AppId=" . $appId . "&StreamId=" . $streamId . "&Sign=" . $sign;
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
    //禁止推流设置，剔流设置
    public function setForbidLiveStream()
    {
        $appId = 75715888;
        $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $streamName = '4001490141775';
        $resumeTime = '2027-11-30  09:15:00';
        //签名密钥
        $appSecret = '00205268c4e6db6bf25a04cbc0cb23e6efc7f929';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DomainName" . $domainName . "ResumeTime" . $resumeTime  . "StreamName" . $streamName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://sewise.amai8.com/openapi/setForbidLiveStream?AppId=" . $appId . "&AppName=" . $appName . "&DomainName=" . $domainName . "&ResumeTime=" . $resumeTime . "&StreamName=" . $streamName . "&Sign=" . $sign;
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

     //恢复直播流
    public function setResumeLiveStream()
    {
        $appId = 75715888;
        $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $streamName = '4001490141775';
        //签名密钥
        $appSecret = '00205268c4e6db6bf25a04cbc0cb23e6efc7f929';
        $str = "AppId" . $appId . "AppName" . $appName . "DomainName" . $domainName  . "StreamName" . $streamName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://sewise.amai8.com/openapi/setResumeLiveStream?AppId=" . $appId . "&AppName=" . $appName . "&DomainName=" . $domainName  . "&StreamName=" . $streamName . "&Sign=" . $sign;
        //CURL方式请求
        $ch = curl_init() or die (curl_error());
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 360);
        $response = curl_exec($ch);
        curl_close($ch);
        var_dump($response);
        //返回数据为JSON格式，进行转换为数组打印输出
        var_dump(json_decode($response, true));
    }

    //当前是否在直播
    public function liveStatus()
    {
        $appId = 75715888;
        $streamName = '4001489478815';
        $appSecret = '00205268c4e6db6bf25a04cbc0cb23e6efc7f929';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId  . "StreamName" . $streamName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://sewise.amai8.com/openapi/liveStatus?AppId=" . $appId . "&StreamName=" . $streamName . "&Sign=" . $sign;
        //CURL方式请求
        $ch = curl_init() or die (curl_error());
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 360);
        $response = curl_exec($ch);
        curl_close($ch);
        homePrint($response);
        //返回数据为JSON格式，进行转换为数组打印输出
        homePrint(json_decode($response, true));
    }

}