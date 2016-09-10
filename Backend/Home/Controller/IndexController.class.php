<?php
namespace Home\Controller;

use Home\Controller\BaseController;
use Org\Util\Tree;
use Org\Util\UserAgent;
use Org\Util\Rbac;
use Think\Log;

class IndexController extends BaseController
{
    public function index()
    {
        $where['username'] = session('username');
        $user = M('AdminUser')->where($where)->field(['username', 'logintime', 'loginip', 'expire'])->find();
        $this->user = $user;
        $this->display();
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

    //空操作是指系统在找不到请求的操作方法的时候，会定位到空操作（_empty）方法来执行，利用这个机制，我们可以实现错误页面和一些URL的优化。
    public function _empty($name)
    {
        //把所有城市的操作解析到city方法
        $this->city($name);
    }

    //注意 city方法 本身是 protected 方法
    protected function city($name)
    {
        //和$name这个城市相关的处理
        echo __METHOD__ . "方法名" . $name . "不存在啊";
    }

    public function show($name = '')
    {
        $this->id = 1024;
        $this->name = $name;
        $this->display('/Index/show');
    }

    /**
     * 判断用户是否是手机和微信登陆
     */
    public function userAgent()
    {
        p(UserAgent::IS_WECHAT());
    }

    public function test(){
        $module = '';    //存放拥有的模块
        var_dump($_SESSION['_ACCESS_LIST']);
        foreach ($_SESSION['_ACCESS_LIST'] as $key => $value) {
            foreach ($value as $key1 => $value1) {
//                $module = $module.','.$key1;    //字符串拼接模块名称
//                foreach ($value1 as $key2 => $value2) {
//                    $node_id = $node_id.','.$value2;    //字符串拼操作id
//                }
                var_dump($key1);
                var_dump($value1);
            }
        }

    }
}