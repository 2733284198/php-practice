<?php
namespace Home\Controller;

use Think\Controller;

class MemberController extends Controller
{
    public function index()
    {
        $this->display();
    }

    /**
     * memberList 会员列表
     */
    public function memberList()
    {
        $model = M('User'); // return Object
        $this->users = $model->select();
        $this->display('Member/memberList');
    }


    public function memberCenter()
    {
        G('begin');
        $username = session('username');
        $conditions = array('username' => ':username');
        $result = M('User')->where($conditions)->bind(':username', $username)->find();
        /**
         * 最近的SQL语句  echo M('user')->getLastSql();
         */
        $this->username = $username;
        $this->display();
        G('end');
        // 进行统计区间
        echo G('begin','end').'s'.'<br/>';
        //使用G方法进行区间内存开销统计
        echo G('begin','end','m').'kb';
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