<?php
namespace Home\Controller;

use Home\Controller\BaseController;
use Think\Model\RelationModel;

class MemberController extends BaseController
{
    public function index()
    {

        echo 'Member';
    }


    public function memberCenter()
    {
        $username = session('username');
        $conditions = array('username' => ':username');
        $result = M('User')->where($conditions)->bind(':username', $username)->find();
        $this->username = $username;
        $this->display();
    }

    // 个人密码修改
    public function checkOldPwd()
    {
        $oldPassword = I('oldpassword');
        $username = I('username');
        $conditions = array('username' => ':username');
        $result = M('User')->where($conditions)->bind(':username', $username)->find();
        if ($result['password'] == md5($oldPassword)) {
            echo 'true';
        } else {
            echo 'false';
        }
        exit;
    }

    // 检查新旧密码是否一样
    public function checkNewPwd()
    {
        $password = I('password');
        $username = session('username');
        $conditions = array('username' => ':username');
        $result = M('AdminUser')->where($conditions)->bind(':username', $username)->find();
        if ($result['password'] == md5($password)) {
            echo 'false';
        } else {
            echo 'true';
        }
        exit;
    }

    public function updatePwd()
    {
        $username = I('post.username');
        $password = I('post.password');
        $User = M('User');
        $conditions = array('username' => ':username');
        $result = $User->where($conditions)->bind(':username', $username)->find();

        $User->password = md5($password);
        $User->where(array('id' => $result->id));
        if ($User->save() == false) {
            return $this->error("密码修改失败", U('Member/memberCenter'));
        } else {
            return $this->success('密码修改成功', U('Login/index'));
        }

    }


}