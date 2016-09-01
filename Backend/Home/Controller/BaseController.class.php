<?php
namespace Home\Controller;

use Think\Controller;
use Org\Util\Rbac;
class BaseController extends Controller
{
//    /**
//     * ThikPHP自动运行方法，每一次，都会自动运行这个方法
//     * 要判断一个session值是否已经设置，可以使用
//       session('?name'); 相当于：isset($_SESSION['name']);
//     */
    public function _initialize(){
        /***************************************网站开关****************************************************/
        if(!C('WEB_STATE')) exit('网站维护中');

        /***********************************没有登录时候时需要执行的代码**************************************/
        if(!isset($_SESSION[C('USER_AUTH_KEY')])) return $this->redirect('Login/index');

        /***************************************自动登录配置************************************************/
        if(isset($_COOKIE['remember']) && !isset($_SESSION['uid'])){
            // Cookie 解密
            $value = encrytion($_COOKIE['remember']);
            $result = explode('|',$value);
            // 判断IP地址是否一样
            if($result[1] == get_client_ip()){
                session('uid',$result[0]);
                session('uid',$result[2]);
            }
        }

        /***************************************权限认证****************************************************/
        $Public = in_array(MODULE_NAME,explode(',',C('NOT_AUTH_MODULE'))) || in_array(ACTION_NAME,explode(',',C('NOT_AUTH_ACTION')));
        // 如果不在公共模块之中，同时开启权限验证的话，则开始认证过程
        if(C('USER_AUTH_ON') && !$Public)
        {
            if(!Rbac::AccessDecision()) //通过accessDecision获取权限信息
            {
                return $this->error("您没有操作权限",U('Login/error1'));  //没有获取到权限信息时需要执行的代码
            }
        }

        /***************************************导航栏菜单显示****************************************************/
        /*
        *   思路：
        *   1.取出所有权限节点。
        *   2.取出当前登录用户拥有的模块权限（取英文名称）和操作权限（取ID）
        *   3.对所有权限进行遍历，先匹配模块权限，不存在删除，存在则匹配操作权限
        */
        // 超级管理员登录
        if(session(C('ADMIN_AUTH_KEY')))
        {
            $menus = D('AdminNode')->where('level = 2')->relation(true)->order('sort desc')->select();//取出所有节点
        }else{
            /**
             * [1]取出所有的权限，是通过关联模型从数据库中获取的
             */
            $menus = D('AdminNode')->where('level = 2')->relation(true)->order('sort desc')->select();
            $module = '';    //存放拥有的模块
            $node_id = '';   //存放拥有的模块
            /**
             * [2]获取当前用户的所有权限,这个是从RBAC中获取的
             */
            $access_list = $_SESSION['_ACCESS_LIST'];   //当前用户所拥有的权限
            foreach ($access_list as $key => $value) {
                foreach ($value as $key1 => $value1) {
                    $module = $module.','.$key1;    //字符串拼接模块名称
                    foreach ($value1 as $key2 => $value2) {
                        $node_id = $node_id.','.$value2;    //字符串拼操作id
                    }
                }
            }
            /**
             * [3]去除没有权限的节点,通过所有权限和用户已经拥有的权限比较
             */
            foreach ($menus as $key => $value) {
                $all_node[] = $value['name'];
                if(!in_array(strtoupper($value['name']), explode(',', $module))){
                    unset($menus[$key]);    //删除模块
                }else{
                    //模块存在，比较里面的操作
                    foreach ($value['node'] as $key1 => $value1) {
                        if(!in_array($value1['id'], explode(',', $node_id))){
                            unset($menus[$key]['node'][$key1]);  // 删除操作
                        }
                    }
                }
            }
        }
        $this->menus = $menus;
    }

}