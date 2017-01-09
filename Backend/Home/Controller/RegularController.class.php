<?php
/**
 * Created by PhpStorm.
 * User: tinywan
 * Date: 2017/1/8
 * Time: 12:21
 * 学习正则表达式
 */

namespace Home\Controller;


use Hoa\Stream\_Protocol;
use Think\Controller;
use Swoole;

class RegularController extends Controller
{
    public function index()
    {
        echo 'Regular';
    }

    /*
     * 不允许用户发超链接<a href='https://github.com/Tinywan' >Tinywan</a>
     *  preg_match($pattern,$subject[ array &$matches])
     */
    public function preg_match()
    {
        $pattern = '/[0-9]/';
        $subject = 'Per8989formareg123sionmatchDescri321ption';
        $nums1 = preg_match($pattern,$subject,$match);
        $nums2 = preg_match_all($pattern,$subject,$matches);
        homePrint($match);
        "<hr/>";
        homePrint($matches);
        "<hr/>";
        homePrint('匹配次数：'.$nums1.'===='.$nums2);
    }

    /**
     * 测试网址：http://regexpal.isbadguy.com/
     * 基本语法：从哪里开始哪里结束
     * 【1】界定符：表示一个正则表达式的开始和结束 例如：$pattern = '/[0-9]/';
     * 【2】原子：Unicode 编码字符 编码工具：http://tool.chinaz.com/Tools/Unicode.aspx
     * 【3】元字符: |：匹配两个或者多个分支 []：只能写原子或者原子的集合 [^]：只能写原子或者原子的集合之外的
     * 【4】：[Tt]inywan 匹配：Tinywan tinywan
     * 【5】基本语法：
     *      .	除换行符以外的所有字符
            \.	转义字符(另有\*, \(, \\, 等等.)
            ^	字符串开头
            $	字符串结尾
            \d,\w,\s	一个数字, 字符 [A-Za-z0-9_], 空格.
            \D,\W,\S	一个非数字, 非字符 [A-Za-z0-9_], 非空格.
            [abc]	a,b或c中的一个.
            [a-z]	a到z中的一个字母.
            [^abc]	除a,b或c的一个字符.
            aa|bb	aa或者bb.
            ?	0次或1次匹配.
             *	任意次数匹配.
            +	一次或一次以上匹配.
            {n}	n次精确匹配.
            {n,}	n次或n次以上匹配.
            {m,n}	最少m次,最多n次匹配
     */
    public function regular_demo1()
    {
        $pattern = '/[0-9]|[a-z]/';
        $subject = 'http://amaitest.oss-cn-hangzhou.aliyuncs.com/record/live123/4001481793159.m3u8';
        $nums1 = preg_match($pattern,$subject,$match);
        homePrint($match);
    }
}