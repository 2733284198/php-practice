<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/8/23
 * Time: 22:55
 */
namespace Home\Controller;

use Home\Controller\BaseController;
use Think\Page;

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
    public function edit()
    {

        $file = CONF_PATH . 'db.php';
        $config = array_merge(include $file, array_change_key_case($_POST, CASE_UPPER));
        // 以下将一个数组转换成一个字符串
        $str = "<?php\r\n return " . var_export($config, true) . ";\r\n?>";
        if (file_put_contents($file, $str)) {
            return $this->success('系统信息修改成功');
        }
        return $this->success('系统信息修改失败');
    }

    /**
     * 记录管理员操作的日志
     */
    public function actionLog()
    {
        $model = M('Logs');
        $count = $model->count();
        $Page = new Page($count, 18);
        $Page->setConfig('header', '共%TOTAL_ROW%条');
        $Page->setConfig('first', '首页');
        $Page->setConfig('last', '共%TOTAL_PAGE%页');
        $Page->setConfig('prev', '上一页');
        $Page->setConfig('next', '下一页');
        $Page->setConfig('link', 'indexpagenumb');
        $Page->setConfig('theme', '%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');
        $show = $Page->show();
        $model = $model->order('addtime desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
        $this->logs = $model;
        $this->show = $show;
        $this->display();
    }

    /**
     * 数据库配置
     */
    public function dataBase()
    {
        if (IS_POST) {
            $file = CONF_PATH . 'db.php';
            $config = array_merge(include $file, array_change_key_case($_POST, CASE_UPPER));
            // 以下将一个数组转换成一个字符串
            $str = "<?php\r\n return " . var_export($config, true) . ";\r\n?>";
            if (file_put_contents($file, $str)) {
                $response = ['status' => 200, 'errmsg' => '权限改变成功', 'dataList' => 0];
                return $this->ajaxReturn($response, 'JSON');
            }
            $response = ['status' => 500, 'errmsg' => '权限改变失败', 'dataList' => 1];
            return $this->ajaxReturn($response, 'JSON');
        }
        $this->display();
    }

    /**
     * 数据库配置
     */
    public function setAuth()
    {
        if (IS_POST) {
            $file = CONF_PATH . 'rbac.php';
            $config = array_merge(include $file, array_change_key_case($_POST, CASE_UPPER));
            // 以下将一个数组转换成一个字符串
            $str = "<?php\r\n return " . var_export($config, true) . ";\r\n?>";
            if (file_put_contents($file, $str)) {
                $response = ['status' => 200, 'errmsg' => '权限改变成功', 'dataList' => 0];
                return $this->ajaxReturn($response, 'JSON');
            }
            $response = ['status' => 500, 'errmsg' => '权限改变失败', 'dataList' => 1];
            return $this->ajaxReturn($response, 'JSON');
        }
        $this->display();
    }



}