<?php
namespace Home\Controller;

use Think\Controller;
use Org\Util\Rbac;

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
        //I('get.name','','/^[A-Za-z]+$/');
        $password = md5(I('post.password'));

        $user = D('AdminUser');
        $where = array('username' => $username);
        $fields = array('id', 'password', 'username', 'status', 'expire', 'logintime'); // 之查找需要的字段
        $result = $user->where($where)->field($fields)->find();


        if (!$result || $password != $result['password']) {
            return $this->error('账号或密码错误');
        }

        if ($result['status'] == 0) return $this->error('账号不存在或者已经被禁用');

        // 是否记住我的登录,设置一个Cookie，写在客户端
        if (isset($_POST['remember'])) {
            $value = $result['id'] . '|' . get_client_ip() . '|' . $result['username'];
            $value = encrytion($value, 1);
            @setcookie('remember', $value, C('AUTO_LOGIN_LIFETIME'), '/');
        }

        // 每天登录增加经验值
        $today = strtotime(date('Y-m-d')); // 获取今天0时0分0秒的时间
        // 如果上次的登录时间小于今天的时间，则增加经验值
        $where2 = array('id' => $result['id']);
        if ($result['logintime'] < $today) {
            $user->where($where2)->setInc('expire', 10);
        }

        //更新登录户登录信息
        $data_arr = array(
            'id' => $result['id'],
            'logintime' => time(),
            'loginip' => get_client_ip(),
        );
        if ($user->save($data_arr)) {
            // 获取$_SESSION['user_id'] 如果不存在则默认为0
            session('uid', 0);
            session('username', $result['username']);
            session('loginAccount', $result['username']);
            session('loginUserName', $result['username']);
            session('uid', $result['id']);
            //RBAC 开始,用户认证SESSION标记 ，默认为"authId"
            session(C('USER_AUTH_KEY'), $result['id']);
            // 是否是超级管理员
            if ($_SESSION['username'] == C('RBAC_SUPERADMIN')) {
                session(C('ADMIN_AUTH_KEY'), true);
            }
            //用于检测用户权限的方法,并保存到Session中
            Rbac::saveAccessList($result['id']);
            //添加操作日志中
            $desc = '登陆成功';
            addOperationLog($desc);
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
