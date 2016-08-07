<?php
/**
 * Created by PhpStorm.
 * User: 1
 * Date: 2016/8/7
 * Time: 11:45
 */
namespace Member\Controller;

use Think\Controller;

class IndexController extends Controller
{
    /**
     * memberList 会员列表
     */
    public function memberList()
    {
//        $model = M('Category'); // return Object
//        // Mysql CONCAT（）函数用于将多个字符串连接成一个字符串
//        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();
//        foreach ($result as $key => $v) {
//            $result[$key]['name'] = str_repeat('&nbsp;&nbsp;&nbsp;', $v['level']) . $v['name'];
//        }
//        $this->categorys = $result;
        $this->display();
    }

    public function test(){
        echo 'category test';
    }
}