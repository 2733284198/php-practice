<?php
namespace Home\Controller;

use Think\Controller;

class LoginController extends Controller
{
    public function index()
    {
        $this->display();
    }

    /*
     * 异步验证账号
    */
    public function checkUser()
    {
        $username = I('username');
        $conditions = array('username' => ':username');
        $result = M('User')->where($conditions)->bind(':username', $username)->find();
        //如果不存在，则可以创建，也就是返回的是true
        if (!$result) {
            echo 'false';
        } else {
            echo 'true';
        }
        exit();
    }

    /*
     * 异步验证密码
    */
    public function checkPwd()
    {
        $username = I('post.username');
        $password = I('post.password');
        $conditions = array('username' => ':username');
        $result = M('User')->where($conditions)->bind(':username', $username)->find();
        if (md5($password) != $result['password']) {
            echo 'false';
        } else {
            echo 'true';
        }
        exit();
    }

    /*
     * 检查登录
    */
    public function checkLogin()
    {
        if (!IS_POST) $this->error('非法访问');
        // 采用htmlspecialchars方法对$_GET['name'] 进行过滤，如果不存在则返回空字符串
        $username = I('post.username', '', 'htmlspecialchars');

        // 采用正则表达式进行变量过滤,如果正则匹配不通过的话，则返回默认值。
        I('get.name','','/^[A-Za-z]+$/');

        $password = md5(I('post.password'));

        $where = array('username' => $username);
        $user = M('User');
        $result = $user->where($where)->find();
        if (!$result || $password != $result['password']) {
            return $this->error('账号或密码错误');
        }

        if ($result['status'] == 0) return $this->error('账号不存在或者已经被禁用');
        //保存用户登录信息
        $data_arr = array(
            'user_id' => $result['user_id'],
            'logintime' => time(),
            'loginip' => get_client_ip(),
        );
        if ($user->save($data_arr))
        {
            // 获取$_SESSION['user_id'] 如果不存在则默认为0
            I('session.user_id',0);
            session('username', $result['username']);
            session('user_id', $result['user_id']);
            return $this->redirect('Index/index');
        } else {
            return $this->error('2222222222222');
        }

    }

    public function memberInfo()
    {
        $user_id = session('user_id');
        $user = D('User');
        $where = array('user_id' => $user_id);
        $result = $user->where($where)->select();
        $this->result = $result;
        $this->display();
    }

    /**
     * 获取apikey_values
     */

    public function apikey()
    {
        $secret = "6JNVkTk4jHsgF0e1oOVLwOZDeq83pDXa";
        $user_id = I('user_id', '', int);
        // $where = array('user_id = %d ',array($user_id));
        $user = M('User');
        // $result = $user->where($where)->find();
        $result = $user->where("user_id = %d", array($user_id))->find();

        $hash = sha1($result['user_id'] . $result['password'] . $secret);
        $data = array(
            'apikey_value' => $hash,
            'apikey_time' => time()
        );
        $where = array('user_id' => $user_id);
        $user->where($where)->save($data);
        $this->ajaxReturn($hash);
    }

    public function hash()
    {
        if (!IS_POST) {
            $out_data = array(
                'err_msg' => 'request method is error.',
                'is_success' => 'Fail'
            );
            exit(json_encode($out_data));
        };

        $username = I('username');
        $password = I('password');
        $where = array('username' => $username);

        $user = M('User');
        $result = $user->where($where)->find();
        if (!$result || $password != $result['password']) {
            $out_data = array(
                'err_msg' => 'Username or password is incorrect.',
                'is_success' => 'Fail'
            );
            exit(json_encode($out_data));
        }

        /**
         * HASH生成规则
         */
        $secret = "6JNVkTk4jHsgF0e1oOVLwOZDeq83pDXa";
        $hash = sha1($result['user_id'] . $result['password'] . $secret);

        $where = array('user_id' => $result['user_id']);
        $data["apikey_value"] = $hash;
        $data["apikey_time"] = time();
        $user->where($where)->save($data);

        $out_data = array(
            'is_success' => 'Success',
            'hash' => $hash
        );
        exit(json_encode($out_data));
    }

    public function relationTest()
    {
        echo get_client_ip();
    }

    public function logout()
    {
        session('username', NULL);
        session_unset();
        session_destroy();
        return $this->redirect('Login/index');
    }
}
