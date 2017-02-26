<?php
namespace Library\Controller;

use Phpml\Classification\KNearestNeighbors;
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

    public function email(){
        $email = '2680737855@qq.com';
        var_dump(filter_var($email,FILTER_VALIDATE_EMAIL));
    }

    public function simpleExample()
    {
        $samples = [[1, 3], [1, 4], [2, 4], [3, 1], [4, 1], [4, 2]];
        $labels = ['a', 'a', 'a', 'b', 'b', 'b'];
        $classifier = new KNearestNeighbors();
        $classifier->train($samples,$labels);
        $result = $classifier->predict([3,2]); // return b
        echo $result;
        var_dump($classifier);
    }


}