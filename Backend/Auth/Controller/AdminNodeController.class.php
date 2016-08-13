<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/2/16
 * Time: 15:01
 */
namespace Auth\Controller;
use Think\Controller;
use Org\Util\Tree;

class AdminNodeController extends Controller{
    public function index(){
        $db = M('AdminNode');
        $node = $db->order('id')->select();
        $this->nodelist = Tree::create($node);
        $this->display();
    }

    //创建权限表单处理
    public function createNode(){
    	$db = M('AdminNode');

    	//创建权限表单处理
    	 if(IS_POST){
    	 	$db->create();
            if(!$db->add()){
                return $this->error("权限添加失败",U('AdminNode/index'));
            }
            return $this->success('权限添加成功',U('AdminNode/index'));
        }
        $node = $db->where('level !=3')->order('sort')->select();
        $this->nodelist = Tree::create($node);
        $this->display();
    }

    /*
    *   删除权限
    */
    public function delNode(){
        $id = I('get.id','',intval);
        $node = M('AdminNode');
        $result = $node->where(array('id' => $id))->delete();
        if($result){
            echo  'true';
        }else{
            echo  'false';
        }
        exit();
    }

    /*
    *   设置权限状态
    */
    public function setStatus(){
        $id = I('get.id');
        $db = M('AdminNode');
        $status = $db->where(array('id'=>$id))->getField('status');
        $status = ($status == 1)? 0 : 1;
        if($db->where(array('id'=>$id))->setField('status',$status)){
            echo 'true';
        }else{
            echo 'false';
        }
        exit();
    }

    //处理用户的权限
    public function checkAuth(){
        
        $db = D('AdminNode');
        //取出所有节点
        $node = $db->where('level = 2')->relation(true)->select();
        /*
        * 思路：
        *   1.取出所有权限节点。  
        *   2.取出当前登录用户拥有的模块权限（取英文名称）和操作权限（取ID）
        *   3.对所有权限进行遍历，先匹配模块权限，不存在删除，存在则匹配操作权限
        */
        //取出当前登录用户拥有的模块权限（取英文名称）和操作权限（取ID）
        $module = '';    //存放拥有的模块
        $node_id = '';   //存放拥有的模块

        $access_list = $_SESSION['_ACCESS_LIST'];   //当前用户所拥有的权限
        foreach ($access_list as $key => $value) {
            foreach ($value as $key1 => $value1) {
                $module = $module.','.$key1;    //字符串拼接模块名称
                foreach ($value1 as $key2 => $value2) {
                    $node_id = $node_id.','.$value2;    //字符串拼操作id
                }
            }
        }
        //去除没有权限的节点
        foreach ($node as $key => $value) {
            $all_node[] = $value['name'];
            if(!in_array(strtoupper($value['name']), explode(',', $module))){
                unset($node[$key]);
            }else{
                //模块存在，比较里面的操作
                foreach ($value['node'] as $key1 => $value1) {
                     if(!in_array($value1['id'], explode(',', $node_id))){
                            unset($node[$key]['node'][$key1]);
                        }
                }
            }
        }
        print_r($node);//这收的$node 是已经被过滤掉的权限
    }
}