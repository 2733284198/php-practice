<?php
namespace Home\Controller;

use Think\Controller;

class AngularJSController extends Controller
{
    public function index(){
        echo 'Hello AngularJS';
    }

    //什么是Angular及与Jquery实例对比分析
    public function jquery()
    {
        $this->display();
    }

    //给客户端返回一个Json数据
    public function jqueryGetJson(){
        $jsonData = [
          ['name'=>'弍萬','age'=>26],
          ['name'=>'Tinyaiai','age'=>24],
          ['name'=>'菲丽布','age'=>24],
          ['name'=>'拉斐尔','age'=>24],
        ];
        //JSON_UNESCAPED_UNICODE 这个参数是不会编码的：输出：[{"name":"弍萬","age":26},{"name":"Tinyaiai","age":24}]
        exit(json_encode($jsonData,JSON_UNESCAPED_UNICODE));
    }

    //AngularJS开发之模块、控制器、视图模型
    public function demo1()
    {
        $this->display();
    }

    //MVVM双向数据绑定图例分析
    public function mvvm()
    {
        $this->display();
    }

    //声明模块与控制器规范与依赖注入分析
    public function controllerDependency()
    {
        $this->display();
    }




}