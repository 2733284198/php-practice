<?php
namespace Library\Controller;

use Think\Controller;

class IndexController extends Controller
{
    public function index()
    {
        // 获取到配置项
        $config = include './plugin/plugin' . substr($_GET['change'], -1) . '/config.php';
        // 如果是开启 那就关闭 如果是关闭 则开启
        $config['status'] = $config['status'] == 1 ? 0 : 1;
        // 将更改后的配置项写入到文件中
        $str = "<?php \r\n return " . var_export($config, true) . ';';
        file_put_contents('./plugin/' . $_GET['change'] . '/config.php', $str);
        header('Location:./');
    }

    /**
     * 生成二维码
     */
    public function qrcode()
    {
        $url = 'http://www.cnblogs.com/tinywan/';
        qrcode($url);
    }


    /**
     * 生成pdf
     */
    public function pdf()
    {
        $content = $_GET['content'];
        pdf($content);
    }

    /**
     * 发送邮件
     */
    public function send_email()
    {
        $name = I('post.name', '这是一份测试邮件名称');
        $address = I('post.address', '这是一份测试邮件发送的地址');
        $phone = I('post.phone', '13669361192');
        $email = '2680737855@qq.com';
        $str = <<<html
            姓名：$name <br>
            地址：$address <br>
            手机号：$phone
html;
        $result = send_email($email, '这个邮件是我用来做测试的,亲！', $str);
        if ($result['error'] == 1) {
            var_dump($result);
            die;
        }
        var_dump('发送完成');
    }

    //通过APache 服务器方式启动一个CLi进程
    public function apacheToCli()
    {
        // echo CLI_PATH."cli.php Library/index/test";
        echo '------------------------------------启动一个CLi进程 开始--------------------------------';
        //exec("E:\wamp64\bin\php\php7.0.10\php.exe E:\wamp64\www\ThinkPhpStudy\cli.php /Library/index/cmdCliTest 2>&1", $output, $return_val);
        exec("E:\wamp64\bin\php\php7.0.10\php.exe ".CLI_PATH."cli.php /Library/index/cmdCliTest 2>&1", $output, $return_val);
        echo "<hr/>";
        var_dump($output);  //命令执行后生成的数组
        echo "<hr/>";
        var_dump("执行的状态:" . $return_val); //执行的状态
        echo '-----------------------------------启动一个CLi进程 结束----------------------------------';
    }

    //这个方法将被cli模式调用
    public function cmdCliTest()
    {
        sleep(10); //方便我们在任务管理器查看PHP cli进程，
        echo date("Y-m-d H:i:s", time()) . ' cmdCliTest()这个方法将被cli模式调用: ThinnPHP cli Mode Run Success:';
    }

    //cli 命令行需要执行的php文件
    public function taskTable()
    {
        $model = M("TaskList");
        $status = 0;
        $conditions = array('status' => ':status');
        $result = $model->where($conditions)->bind(':status', $status)->select();
        if (empty($result)) exit('没有可发送的邮件');
        echo '开始发送邮件:' . "\r\n";
        foreach ($result as $key => $value) {
            //发送邮件
            $result = send_email($value['user_email'], 'Tinywan激活邮件', "https://github.com/Tinywan");
            //发送成功
            if ($result['error'] == 0) {
                //修改数据库字段status 的值为1
                $model->where(array('id' => $value['id']))->setField('status', 1);
            }
            sleep(10);
            //其实在这里可以添加一个状态表示没有发送成功的标记，修改数据库字段status 的值为2
//            $model->where(array('id' => $value['id']))->setField('status', 2);
        }
        exit('发送邮件结束');
    }

    public function apacheToCliEmail()
    {
        echo '------------------------------------启动一个CLi进程 开始--------------------------------';
        exec("E:\wamp64\bin\php\php7.0.10\php.exe E:\wamp64\www\ThinkPhpStudy\cli.php /Library/index/taskTable 2>&1", $output, $return_val);
        echo "<hr/>";
        var_dump($output);  //命令执行后生成的数组
        echo "<hr/>";
        var_dump("执行的状态:" . $return_val); //执行的状态
        echo '-----------------------------------启动一个CLi进程 结束----------------------------------';
    }


}