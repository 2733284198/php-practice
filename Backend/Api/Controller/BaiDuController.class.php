<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/6
 * |  Time: 14:16
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Api\Controller;

/**
 * 百度API调用
 * http://apistore.baidu.com/
 */
class BaiDuController
{
    public function index()
    {
        echo __METHOD__;
    }

    public static function requestUrl($header, $url)
    {
        // 添加apikey到header
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        // 执行HTTP请求
        curl_setopt($ch, CURLOPT_URL, $url);
        $res = curl_exec($ch);
        return $res;
    }

    public function base()
    {
        $id = "wutaishan";
        $url = "http://apis.baidu.com/apistore/attractions/spot?id=" . $id . "&output=json";
        $header = ['apikey:cbbaa61823ce797038df761b3e947861'];
        $res = self::requestUrl($header, $url);
        var_dump(json_decode($res, true));
    }

    //二维码生成
    public function qrcode()
    {
        $ch = curl_init();
        $content = "tel:13669361192;email:7566874177@qq.com";
        $url = 'http://apis.baidu.com/3023/qr/qrcode?size=8&qr=' . $content;
        $header = ['apikey:cbbaa61823ce797038df761b3e947861'];
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        $res = curl_exec($ch);

        var_dump(json_decode($res));
    }
}