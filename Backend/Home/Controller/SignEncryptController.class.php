<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/6
 * |  Time: 15:17
 * |  Mail: Overcome.wan@Gmail.com
 * |  Function: 加密签名  doc: http://www.cnblogs.com/dcb3688/p/4608008.html
 * '-------------------------------------------------------------------*/

namespace Home\Controller;


class SignEncryptController
{
    /**
     * APi自定义签名方法（PS：乐视云的签名方法也是这样的哦！！！！！！！）
     * appId会在请求中作为一个应用标识参与接口请求的参数传递，appSecret 将作为唯一不需要参数传递,但是作为加密的参数
     */
    public function testSign($appId, $method)
    {
        //HP服务端先要给开发者（APP）分配一个appId与appSecret (正常情况下，开发者要到服务提供商的官网申请)，作为客户端，需要保留好官方颁发的appid & appsecret
        $appSecret = 'r5e2t85tyu142u665698fzu';
        //移动客户端，需要请求服务列表，包括方法哦!
        $allParam = [
            'appid' => $appId,
            'method' => $method,
        ];
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

    /**
     * 客户端请求API方法
     */
    public function testRequest()
    {
        $appId = 13669361192;
        $streamName = '4001486435195';
        $appSecret = 'eb9a365a9d37a1354e13ddd7973d5e02409ef451';
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId  . "StreamName" . $streamName . $appSecret;
        //签名串，由签名算法sha1生成
        $sign = strtoupper(sha1($str));
        echo $str."<br/>";
        //请求资源访问路径以及请求参数，参数名必须为大写
        $url = "http://sewise.amai8.com/openapi/liveStatus?AppId=" . $appId . "&StreamName=" . $streamName . "&Sign=" . $sign;
        echo $url;
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
        die;
    }

    /**
     * 服务端验证签名方式
     * @param $appId
     * @param $allParam
     * @return bool|string
     * @static
     */
    public static function serviceResponse()
    {
        $sign = $_GET['Sign'];
        $appId = $_GET['AppId'];
        $checkSign = self::serviceCheckSign($appId, $_GET);
        if ($checkSign != $sign) {
            $result = [
                'status_code' => 300201,
                'msg' => 'Invalid signature or signature error',
                'clientSign' => $sign,
                'checkSign' => $checkSign,
            ];
            return json_encode($result);
        }
        echo "签名验证通过，继续下面的操作";
    }

    /**
     * 服务端验证签名方式
     * @param $appId
     * @param $allParam
     * @return bool|string
     * @static
     */
    public static function serviceCheckSign($appId, $allParam)
    {
        //根据appId查询否存在该用户
        $userInfo = User::findFirst(array('nickName = :nickName:', 'bind' => array('nickName' => $appId)));
        if (false == $userInfo) return false;
        $appSecret = 'eb9a365a9d37a1354e13ddd7973d5e02409ef451';
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

    /**
     * 客户端请求API方法
     */
    public function testRequestSort()
    {
        //请求参数
        $appId = 13669361192;
        $domainName = 'tinywan.amai8.com';
        $appName = 'live';
        $streamName = '4001486435195';
        $resumeTime = '2017-11-30  09:15:00';
        //签名密钥
        $appSecret = 'eb9a365a9d37a1354e13ddd7973d5e02409ef451';
//        $allParam = [
//            'AppId' => $appId,
//            'DomainName' => $domainName,
//            'AppName' => $appName,
//            'StreamName' => $streamName,
//            'ServiceArea' => $serviceArea,
//        ];
//        // 1. 对加密数组进行字典排序
//        foreach ($allParam as $key => $value) {
//            $sortParam[$key] = $key;
//        }
//        // 2. 字典排序的作用就是防止因为参数顺序不一致而导致下面拼接加密不同
//        sort($sortParam);
//        var_dump($sortParam);
//        die;
        //拼接字符串，注意这里的字符为首字符大小写，采用驼峰命名
        $str = "AppId" . $appId . "AppName" . $appName . "DomainName" . $domainName . "ResumeTime" . $resumeTime . "StreamName" . $streamName . $appSecret;
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
        die;
    }

}