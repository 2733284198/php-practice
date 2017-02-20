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

class HtmlController extends Controller
{
    /*
     * 净化 HTML 输入和输出
     * 参考：http://phpbestpractices.justjavac.com/
     * [1]:对于简单需求的净化
     */
    public function simpleFilter()
    {
        $evilHtml = '<div onclick="xss();">Mua-ha-ha!  Twiddling my evil mustache...</div>';
        // 输出：string '<div onclick="xss();">Mua-ha-ha!  Twiddling my evil mustache...</div>'
        $saftHtml = htmlentities($evilHtml); // $safeHtml现在完全转义了HTML。 你可以输出$safeHtml给你的用户没有恐惧！
        //输出：string '&lt;div onclick=&quot;xss();&quot;&gt;Mua-ha-ha!  Twiddling my evil mustache...&lt;/div&gt;'
    }

    /**
     * [2]:对于复杂需求的净化
     * 对于很多 web 应用来说，简单地转义 HTML 是不够的。 你可能想完全去除任何HTML，或者允许一小部分子集的 HTML 存在。
     * 若是如此，则使用 HTML Purifier 库
     */
    public function complexFilter()
    {
        $evilHtml = '<div onclick="xss();">Mua-ha-ha!  Twiddling my evil mustache...</div>';
        // 输出：string '<div onclick="xss();">Mua-ha-ha!  Twiddling my evil mustache...</div>'
        var_dump($evilHtml);
        //使用默认配置设置HTML Purifier对象。
        $purifier = new \HTMLPurifier(\HTMLPurifier_Config::createDefault());
        $saftHtml = $purifier->purify($evilHtml); // $safeHtml现在完全转义了HTML。 你可以输出$safeHtml给你的用户没有恐惧！
        var_dump($saftHtml);
        //输出：string '&lt;div onclick=&quot;xss();&quot;&gt;Mua-ha-ha!  Twiddling my evil mustache...&lt;/div&gt;'
    }
}