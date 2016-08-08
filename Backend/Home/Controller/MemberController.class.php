<?php
namespace Home\Controller;

use Home\Controller\BaseController;

class MemberController extends BaseController
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
        $this->display('Member/memberCenter');
        G('end');
        // 进行统计区间
        echo G('begin','end').'s'.'<br/>';
        //使用G方法进行区间内存开销统计
        echo G('begin','end','m').'kb';
    }

    public function memberInfo()
    {
        G('begin');
        $username = session('username');
        $conditions = array('username' => ':username');
        $result = M('User')->where($conditions)->bind(':username', $username)->find();
        /**
         * 最近的SQL语句  echo M('user')->getLastSql();
         */
        $this->username = $username;
        $this->display('Member/memberCenter');
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
        $oldPassword = I('post.oldpassword');
        $User = M('User');
        $conditions = array('username' => ':username');
        $result = $User->where($conditions)->bind(':username', $username)->find();

        $User->password = md5($password);
        $User->where(array('id' => $result->id));
        // 检查旧密码是否正确
        if($result['password'] == md5($oldPassword)){
            $User->password = md5($password);
            $User->where(array('user_id'=>$result['user_id']));
            if($User->save() == false){
                return $this->error("密码修改失败",U('Member/memberCenter'));
            }else{
                //==============释放用户的session所有资源，需要顺序执行如下代码=============
                //1.删除某个session的值使用
                session('username',NULL);
                //2.释放当前在内存中已经创建的所有$_SESSION变量，但不删除session文件以及不释放对应的sessionid
                session_unset();
                //3.删除当前用户对应的session文件以及释放sessionid，内存中的$_SESSION变量内容依然保留
                session_destroy();
                return $this->success('密码修改成功',U('Login/index'));
            }
        }else{
            return $this->error("旧密码错误",U('Member/memberCenter'));
        }

    }


}