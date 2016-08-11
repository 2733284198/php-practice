<?php
namespace Home\Controller;

use Think\Controller;

class EmptyController extends Controller
{
    public function index(){
        //根据当前控制器名来判断要执行那个城市的操作
        $cityName = CONTROLLER_NAME;
        $this->show($cityName);
    }
    //注意 city方法 本身是 protected 方法
    public function show($name){
        //和$name这个城市相关的处理
        $this->name = $name;
        $this->display('Index/show');
    }

}