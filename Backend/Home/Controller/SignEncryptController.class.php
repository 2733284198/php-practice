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
     * APi自定义签名方法
     * appId会在请求中作为一个应用标识参与接口请求的参数传递，appSecret 将作为唯一不需要参数传递,但是作为加密的参数
     */
    public function getSign()
    {
        $appId = 13669361192;
        $appSecret = 'r5e2t85tyu142u665698fzu';
        $allParam = [
            'appid' => $appId,
            'method' => 'createPushFlowAddress',
            'serviceArea' => 'A',
            'authKeyStatus' => 0,
            'appName' => 'live',
            'domainName' => 'tinywan.amai8.com',
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
        echo $sign;
    }

    /**
     * 字符串拼接签名方法
     */
    public function getSign2()
    {
        $appid = 13669361192;
        $method = 'createPushFlowAddress';
        $serviceArea = 'A';
        $authKeyStatus = 0;
        $appName = 'live';
        $domainName = 'tinywan.amai8.com';     #客户的访问域名
        $appsecret = 'r5e2t85tyu142u665698fzu';
        $sign = sha1("appName{$appName}appid{$appid}authKeyStatus{$authKeyStatus}domainName{$domainName}method{$method}serviceArea{$serviceArea}{$appsecret}");
        var_dump(strtoupper($sign));
    }
}