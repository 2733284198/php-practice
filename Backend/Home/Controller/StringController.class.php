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
        $redis->connect('116','63790');
        $redis->auth('1111');
        $redis->select(12);
        var_dump($redis->keys('*'));
    }


    public function index3()
    {
        //请求参数
        $appId = 75715888;
       $domainName = '10.51.10.172';
        //  $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $DeviceId = 208;
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

    /**
     * 设备鉴权
     */
    public function index4()
    {
        //请求参数
        $appId = 75715888;
        $domainName = '10.51.10.172';
//          $domainName = 'zonelue2.amailive.com';
//          $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $DeviceId = 2803;
        $AuthKeyStatus = 1;
        $ExpireTime = 1000000;
        $AutoStartRecord = 1;
        //签名密钥
        $appSecret = 'f48d03070f4572069dfafab41027a913a50ea06e';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
//        $str = "AppId" . $appId . "AppName" . $appName . "AuthKeyStatus" . $AuthKeyStatus. "DeviceId" . $DeviceId . "DomainName" . $domainName. "ExpireTime" . $ExpireTime . $appSecret;
        $str = "AppId" . $appId . "AppName" . $appName . "AuthKeyStatus" . $AuthKeyStatus."AutoStartRecord" . $AutoStartRecord. "DeviceId" . $DeviceId . "DomainName" . $domainName. "ExpireTime" . $ExpireTime . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
//        $url = "http://ssconsole.amaitech.com/openapi/createDevicePushFlowAddress?AppId=" . $appId . "&AppName=" . $appName ."&AuthKeyStatus=" . $AuthKeyStatus. "&DeviceId=" . $DeviceId  . "&DomainName=" . $domainName ."&ExpireTime=" . $ExpireTime . "&Sign=" . $sign;
        $url = "http://ssconsole.amaitech.com/openapi/createDevicePushFlowAddress?AppId=" . $appId . "&AppName=" . $appName ."&AuthKeyStatus=" . $AuthKeyStatus."&AutoStartRecord=" . $AutoStartRecord. "&DeviceId=" . $DeviceId  . "&DomainName=" . $domainName ."&ExpireTime=" . $ExpireTime . "&Sign=" . $sign;

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
//        print_r($response);
    }

    public function deviceRegister(){
        $device_id = 8936;
        $url = "http://ssconsole.amaitech.com/openapi/deviceRegister?device_id=${device_id}";
        //CURL方式请求
        $ch = curl_init() or die (curl_error());
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 360);
        $response = curl_exec($ch);
        curl_close($ch);
        //返回数据为JSON格式，进行转换为数组打印输出
        print_r($response);
//        var_dump(json_decode($response, true));
    }

    public  function checkApiSign($allParam)
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


    public function zltest(){
        //请求参数
        $appId = 757158803;
        $domainName = 'zonelue2.amailive.com';
        $appName = 'live';
        //签名密钥
        $appSecret = '588c02a56959d3314cbd58f07c0bcf1fe57ef43d';
        $NotifyUrl = "ssconsole.amaitech.com";
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DomainName" . $domainName ."NotifyUrl" . $NotifyUrl . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://ssconsole.amaitech.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName . "&DomainName=" . $domainName ."&NotifyUrl=" . $NotifyUrl . "&Sign=" . $sign;
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
//         $domainName = 'zonelue2.amailive.com';
        $appName = 'live';
        $AuthKeyStatus = 0;
        $ExpireTime = 10000;
        //签名密钥
        $appSecret = '981119290651e52a52dc469df5eeb638942cc7bb';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
//        $str = "AppId" . $appId . "AppName" . $appName . "DomainName" . $domainName . $appSecret;
        $str = "AppId" . $appId . "AppName" . $appName ."AuthKeyStatus" . $AuthKeyStatus . "DomainName" . $domainName . "ExpireTime" . $ExpireTime . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
//        $url = "http://ssconsole.amaitech.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName ."&DomainName=" . $domainName . "&Sign=" . $sign;
        $url = "http://ssconsole.amaitech.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName ."&AuthKeyStatus=" . $AuthKeyStatus ."&DomainName=" . $domainName ."&ExpireTime=" . $ExpireTime . "&Sign=" . $sign;
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

    // 带权限的测试 tinywan.amai8.com
    public function indexAuthKeyStatus()
    {
        $appId = 757158802;
//       $domainName = '10.51.10.172';
        $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $AuthKeyStatus = 1;
        //签名密钥
        $appSecret = '6a3a158c8a971d01cde74531124bf6a97deffbb1';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "AuthKeyStatus" . $AuthKeyStatus . "DomainName" . $domainName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://ssconsole.amaitech.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName ."&AuthKeyStatus=" . $AuthKeyStatus ."&DomainName=" . $domainName . "&Sign=" . $sign;
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

    // 带权限的测试 tinywan.amai8.com
    public function indexAuthKeyStatus2()
    {
//        $appId = 757158802;
////       $domainName = '10.51.10.172';
//        $domainName = 'tinywan.amai8.com';
//        $appName = 'live';
//        $AuthKeyStatus = 1;
//        //签名密钥
//        $appSecret = '6a3a158c8a971d01cde74531124bf6a97deffbb1';
//        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
//        $str = "AppId" . $appId . "AppName" . $appName . "AuthKeyStatus" . $AuthKeyStatus . "DomainName" . $domainName . $appSecret;
//        //签名串，由签名算法sha1生成
//        $sign = strtoupper(sha1($str));
//        //请求资源访问路径以及请求参数，参数名必须为大写
//        $url = "http://ssconsole.amaitech.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName ."&AuthKeyStatus=" . $AuthKeyStatus ."&DomainName=" . $domainName . "&Sign=" . $sign;

        $appId      = 757158802;
        $domainName = 'tinywan.amai8.com';
        $appName    = 'live';
        $notifyUrl  = '122';
        $authKeyStatus = 1;

        //签名密钥
        $appSecret  = '6a3a158c8a971d01cde74531124bf6a97deffbb1';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "AuthKeyStatus" . $authKeyStatus . "AutoStartRecord" . 1 . "DomainName" . $domainName . "NotifyUrl" . $notifyUrl . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://ssconsole.amaitech.com/openapi/createPushFlowAddress?AppId=" . $appId . "&AppName=" . $appName . "&AuthKeyStatus=" . $authKeyStatus .
            "&AutoStartRecord=1" . "&DomainName=" . $domainName . "&NotifyUrl=" . $notifyUrl . "&Sign=" . $sign;

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
        $path = '/home/www/bin/php.txt';
        $time = date("Y-m-d H:i:s");
        file_put_contents($path,$time);
    }

}