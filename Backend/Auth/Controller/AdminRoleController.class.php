<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/2/16
 * Time: 15:01
 */
namespace Home\Controller;
use Home\Controller\BaseController;
use Home\Model\AdminRoleModel;
use Org\Util\Tree;

class AdminRoleController extends BaseController{
    public function index(){
        $db = M('AdminRole');
        $this->rolelist = $db->select();
        $this->display();
    }

    /*
     *创建角色
     */
    public function createAdminRole(){
        if(IS_POST){
            $name = I('post.name');
            $remark = I('post.remark');
            $pid = I('post.pid');
            if(empty($name)) return $this->error('角色名称不能为空');
            $role = M('AdminRole');
            $where = array('name'=>$name);
            $role_find = $role->where($where)->find();
            if($role_find){
                $this->error("角色名称:'".$name."'已经存在",U('AdminRole/index'));
            }

            $role->name = $name;
            $role->remark = $remark;
            $role->pid = $pid;
            if(!$role->add()){
                return $this->error("角色添加失败",U('AdminRole/createpartent'));
            }
            return $this->success('角色添加成功',U('AdminRole/index'));
        }
        $this->display();
    }

    /*
     *添加权限Node位权限表，Access为权限-角色关联表
     */
    public function addNode(){
        $rid = I('rid','',intval);
        //getFieldById针对某个字段(ID)查询并返回某个字段(name)的值
        $role_name = M('AdminRole')->getFieldById($rid,'name');
        $node = M('AdminNode')->order('id')->select();
        $node_list = Tree::create($node);

        //添加权限
        $access = M('AdminAccess');
        $node_arr = array();
        foreach ($node_list as $value) {
            $conditions['node_id'] = $value['id'];
            $conditions['role_id'] = $rid;
            $count = $access->where($conditions)->count();
            if($count){
                $value['access'] = '1';
            }else{
                $value['access'] = '0';
            }
            $node_arr[] = $value;
        }
        $this->role_name = $role_name;
        $this->node_list = $node_arr;
        $this->rid = $rid;
        $this->display();
    }

    /*
     *添加角色-权限表 节点表Access
     */
    public function setAccess(){
        $rid = I('rid');
        //添加新权限之前，清空当前角色的所有权限
        $access = M('AdminAccess');
        $access->where(array('role_id'=>$rid))->delete();
        
        if(IS_POST){
            $data = array();
            foreach ($_POST['access'] as $value) {
                $tmp = explode('_', $value);
                $data[] = array(
                    'role_id' => $rid,
                    'node_id' => $tmp[0],
                    'level'   => $tmp[1]
                );
            }
            if($access->addAll($data)){
                return $this->success('权限设置成功',U('AdminRole/index',array('rid'=>$rid)));
            }else{
                $this->error("权限设置失败",U('AdminRole/addnode',array('rid'=>$rid)));
            }
        }else{
            $this->error("权限设置失败",U('AdminRole/addnode',array('rid'=>$rid)));
        } 
    }


    /*
     *删除角色以及角色所拥有的权限
     */
    public function delRole(){
        $role_id = I('get.role_id','',intval);
        $user = D('AdminRole');
        $result = $user->relation(true)->where(array('id' => $role_id))->delete();
        if($result){
            echo  'true';
        }else{
            echo  'false';
        }
        exit();
    }

    /*
    *   设置角色状态
    */
    public function setStatus(){
        $rid = I('get.rid');
        $db = M('AdminRole');
        $status = $db->where(array('id'=>$rid))->getField('status');
        $status = ($status == 1)? 0 : 1;
        if($db->where(array('id'=>$rid))->setField('status',$status)){
            echo 'true';
        }else{
            echo 'false';
        }
        exit();
    }
}