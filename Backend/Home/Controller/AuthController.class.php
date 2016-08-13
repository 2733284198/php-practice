<?php
namespace Home\Controller;

use Home\Controller\BaseController;

class AuthController extends BaseController
{
    /**
     * 尝试调用Auth模块的多个方法
     * 1 test()
     */
    public function authTest()
    {
        header("Content-Type:text/html; charset=utf-8");
        $authTest = A('Auth/AdminRole'); // 实例化 Auth 模块中Role控制器
        $authTest->test();  // 调用 Auth 模块中的test()方法
        echo '1111111';
    }

    public function welcome()
    {
        $this->display('Index/welcome');
    }

    public function notice()
    {
        $this->display('Index/notice');
    }

    /**
     * 通过 A 方法跨模块调用操作
     * 尝试去调用一个Category模块下面Index控制器的Test()的方法
     * A()方法
     * ***建议：如果要使用其他模块内的多个方法，那么建议使用 A 方法，通过对象的方式调用该模块的不同方法，避免多次实例化对象。
     */
    public function aGetModule()
    {
        //$User = new \Category\Controller\IndexController(); 等价于这个
        $category = A('Category/Index');
        $category->test();
    }

    /**
     * 通过 R 方法跨模块调用操作
     * 尝试去调用一个Category模块下面Index控制器的Test()的方法
     * R()方法
     * ***建议：如果只需要使用其他模块内的其中一个方法，那么无疑 R 方法是最简洁的
     */
    public function rGetModule()
    {
        $category = R('Category/Index/test');
        echo $category;
    }

    /**
     * 通过 R 方法跨模块调用操作
     * 尝试去调用一个Category模块下面Index控制器的Test()的方法
     * R()方法
     * 建议：如果只需要使用其他模块内的其中一个方法，那么无疑 R 方法是最简洁的
     */
    public function aGetAppModule($id)
    {
        $category = A('ThinkPhpStudy://Frontend/Home/Index/index');
        echo $category;
        echo '111111111';
        echo $id;
    }

}