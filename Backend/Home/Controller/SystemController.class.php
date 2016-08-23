<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/8/23
 * Time: 22:55
 */
namespace Home\Controller;

use Home\Controller\BaseController;

class SystemController extends BaseController
{
    public function index()
    {
        $this->display();
    }

    /**
     * 网站信息设置
     * [1] array_change_key_case() 函数将数组的所有的键都转换为大写字母或小写字母
     * [2] var_export() var_export必须返回合法的php代码， 也就是说，var_export返回的代码，
     *     可以直接当作php代码赋值个一个变量
     */
    Public function edit()
    {

        $file = CONF_PATH.'db.php';
        $config = array_merge(include $file, array_change_key_case($_POST, CASE_UPPER));
        // 以下将一个数组转换成一个字符串
        $str = "<?php\r\n return " . var_export($config, true) . ";\r\n?>";
        if (file_put_contents($file, $str)) {
           echo 1;
        } else {
            echo 0;
        }

    }


}