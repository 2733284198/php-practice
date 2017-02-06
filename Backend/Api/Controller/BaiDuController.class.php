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

    public static function baiDuRequestUrl($url)
    {
        $header = ['apikey:cbbaa61823ce797038df761b3e947861'];
        // 添加apikey到header
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        // 执行HTTP请求
        curl_setopt($ch, CURLOPT_URL, $url);
        $res = curl_exec($ch);
        return $res;
    }

    /**
     * 城市交通查询
     */
    public function base()
    {
        $id = "wutaishan";
        $url = "http://apis.baidu.com/apistore/attractions/spot?id=" . $id . "&output=json";
        $res = self::baiDuRequestUrl($url);
        var_dump(json_decode($res, true));
    }

    public function baiduBus(){
        $url = 'http://apis.baidu.com/jundie/plate_number_ocr/place_number_ocr?format=json&pic_url=http%3A%2F%2Fwww.longyao.cc%2Fuserfiles%2Fimages%2F201203131542.jpg';
        $res = self::baiDuRequestUrl($url);
        var_dump(json_decode($res, true));
    }
}