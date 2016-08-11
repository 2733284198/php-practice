<?php
/**
 * 
 */
namespace Home\Controller;
use Home\Controller\BaseController;
use Home\Model\AdminUserModel;
use Think\Page;

class AdminUserController extends BaseController
{
	public function index(){
        if(IS_POST){
            $condition['username'] = array('like',"%".trim(I('keybord'))."%");
            $model = D('AdminUser');
            $count = $model->where($condition)->count();
            $Page = new Page($count,10);
            $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');
            $show = $Page->show();
            //select search
            $list = $model->where($condition)->field('password',true)->relation(true)->limit($Page->firstRow.','.$Page->listRows)->select();
            $this->show = $show;
            $this->list = $list;
            $this->display();
        }else{
            $model = D('AdminUser');
            $count = $model->count();
            $Page = new Page($count,10);
            $Page->setConfig('header','共%TOTAL_ROW%条');
            $Page->setConfig('first','首页');
            $Page->setConfig('last','共%TOTAL_PAGE%页');
            $Page->setConfig('prev','上一页');
            $Page->setConfig('next','下一页');
            $Page->setConfig('link','indexpagenumb');
            $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');
            $show = $Page->show();
            //select search
            $list = $model->field('password',true)->relation(true)->limit($Page->firstRow.','.$Page->listRows)->select();
            $this->show = $show;
            $this->list = $list;
            $this->display();
        }

//		$admin = D('AdminUser');
//		$this->result = $admin->field('password',true)->relation(true)->select();
//		$this->display();
	}

    /*
    *  平台用户异步验证
    */
    public function checkUser()
    {
        $username = trim(I('username'));
        $conditions = array('username' => ':username');
        $result = M('AdminUser')->where($conditions)->bind(':username', $username)->find();
        //如果不存在，则可以创建，也就是返回的是true
        if (!$result) {
            echo 'true';
        } else {
            echo 'false';
        }
        exit();
    }

    /*
     *  创建平台用户
     */
	public function createAdminUser(){
		if(IS_POST){
			$data['username'] = I('post.username');
			$data['password'] = md5(I('post.password'));
			$data['logintime'] = time();
			$data['loginip'] = get_client_ip();
			$data['status'] = 1;
	
			$uid = M('AdminUser')->add($data); //获取用户id
			if(!$uid){
				return $this->success('添加平台用户是失败',U('AdminUser/index'));
			}
			//用户添加成功后，给用户角色表添加数据
			$role['role_id'] = I('role_id');
			$role['user_id'] = $uid;
            if(M('AdminRoleUser')->add($role)){
                return $this->success('添加平台用户成功',U('AdminUser/index'));
            }else{
                return $this->error('添加平台用户失败',U('AdminUser/index'));
            }
			return $this->success('添加平台用户成功',U('AdminUser/index'));
		}
		$this->role_list = M('AdminRole')->select();
		$this->display();
	}

	//删除用户
	public function delUser(){
		$user_id = I('get.user_id','',intval);
		$user = D('AdminUser');
		$result = $user->relation(true)->where(array('id' => $user_id))->delete();
		if($result){
            echo  'true';
		}else{
            echo  'false';
        }
        exit();
	}

    //设置用户状态
    public function setStatus(){
        $uid = I('get.uid');
        $db = M('AdminUser');
        $status = $db->where(array('id'=>$uid))->getField('status');
        $status = ($status == 1)? 0 : 1;
        if($db->where(array('id'=>$uid))->setField('status',$status)){
            echo 'true';
        }else{
            echo 'false';
        }
        exit();
    }


}























?>