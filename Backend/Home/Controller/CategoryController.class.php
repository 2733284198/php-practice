<?php
/**
 * 无限分类是我们开发中经常会用的到功能,主要包括经典的递归实现和全路径实现两种方式.
 */
namespace Home\Controller;

use Org\Util\Tree;

class CategoryController extends BaseController
{
    public static $treeLink = [];

    /**
     * 全路径无限分类
     */
    public function index()
    {
        $model = M('Category'); // return Object
        $condition['type'] = 'channel';
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();
        $this->categorys = $result;
        $this->display();
    }

    /**
     * 全路径无限分类添加一个新分类
     */
    public function addCategory()
    {
        if (IS_POST) {
            $data['pid'] = I('post.pid');
            $data['name'] = I('post.name');
            $data['remark'] = I('post.remark');
            $data['type'] = I('post.type', 'system');
            $data['userId'] = session('uid');
            // 实例化一个数据表
            $model = M('Category');
            // 判断是否是顶级分类
            if (!empty($data['name']) && $data['pid'] != 0) {
                $path = $model->field('path')->find($data['pid']);
                //思路,先添加后修改
                $data['path'] = $path['path'];
                // substr_count() 函数计算子串在字符串中出现的次数
                $data['level'] = substr_count($path['path'], ',');
                // 在TP中 $data['pid'] = I('post.pid') 会返回当前插入的id
                $resultId = $model->add($data); // return add id
                $update['id'] = $resultId;
                $update['path'] = $path['path'] . ',' . $resultId;
                $update['level'] = $data['level'] + 1;
                $updateResult = $model->save($update);
                if (!$updateResult) {
                    return $this->error('添加一个新分类失败');
                } else {
                    return $this->success('添加一个新分类成功', U('Category/index'));
                }
            } elseif (!empty($data['name']) && $data['pid'] == 0) {
                $data['path'] = $data['pid'];
                $data['level'] = 1;
                // 在TP中 $data['pid'] = I('post.pid') 会返回当前插入的id
                $resultId = $model->add($data); // return add id
                $update['id'] = $resultId;
                $update['path'] = $data['path'] . ',' . $resultId;
                $updateResult = $model->save($update);
                if (!$updateResult) {
                    return $this->error('添加一个新分类失败', U('Category/addCategory'));
                } else {
                    return $this->success('添加一个新分类成功', U('Category/index'));
                }
            } else {
                return $this->error('添加一个新分类失败');
            }
        }
        $model = M('Category'); // return Object
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();
        foreach ($result as $key => $v) {
            $result[$key]['name'] = str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;', $v['level']) . '|--' . $v['name'];
        }
        $this->categorys = $result;
        $this->display();
    }


    /**
     * 删除分类
     * 【1】查找该分类下是否有商品，同时删除分类下的商品
     * 【2】其次查找该分类是否有子分类
     * 删除分类之前，查看该分类下面是否有商品，如果有则提示，下删除该商品，才可以删除该分类
     */
    public function checkCategory()
    {
        $id = I('post.id');
        $where['pid'] = ':pid';
        $model = M('Category');
        $model->startTrans();
        // 查看是否有子分类
        $result = $model->where($where)->bind(':pid', $id, \PDO::PARAM_INT)->find();
        if ($result) {
            $response = ['errcode' => 401, 'errmsg' => '请先删除子分类'];
            $this->ajaxReturn($response, 'JSON');
        }
        // 查看是否有商品该分类下面
        $prod = M('Product')->where(array('cId' => $id))->find();
        if ($prod) {
            $response = ['errcode' => 402, 'errmsg' => '请先删除该分类下的产品'];
            $this->ajaxReturn($response, 'JSON');
        }
        $delWhere['id'] = ':id';
        $delResult = $model->where($delWhere)->bind(':id', $id, \PDO::PARAM_INT)->delete();
        if (!$delResult) {
            $model->rollback();
            $response = ['errcode' => 500, 'errmsg' => '删除分类失败'];
            $this->ajaxReturn($response, 'JSON');
        }
        $model->commit();
        $response = ['errcode' => 200, 'errmsg' => '删除分类成功'];
        $this->ajaxReturn($response, 'JSON');
    }

    /**
     * 根据分类等级打印一个下拉列表输出
     * 全路径无限分类下拉列表的实现
     */
    public function printSelectOption()
    {
        $model = M('Category'); // return Object
        $condition['type'] = 'channel';
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();

        $str = "<select name='cate'>";
        foreach ($result as $key => $v) {
            $str .= "<option>" . $result[$key]['name'] = str_repeat('&nbsp;&nbsp;', $v['level']) . '|--' . $v['name'] . "</option>";
        }
        $str .= "</select>";
        print_r($str);
    }

    /**
     * 输出一个已经选中的下拉列表
     * $objectId 某一个具体的对象所属的分类ID
     */
    public function printCurrentSelect($objectId = 33)
    {
        $model = M('Category'); // return Object
        $condition['type'] = 'channel';
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();

        $str = "<select name='cate'>";
        foreach ($result as $key => $v) {
            $selected = '';
            if ($v['id'] == $objectId) $selected = "selected";
            $str .= "<option {$selected}>" . $result[$key]['name'] = str_repeat('&nbsp;&nbsp;', $v['level'])
                    . '|--' . $v['name'] . "</option>";
        }
        $str .= "</select>";
        print_r($str);
    }

    /**
     * 无限分类分类导航LINK的代码
     * 具体思路：倒序着查找直到根分类
     */
    public function printLink($cid = 33)
    {
        $model = M('Category'); // return Object
        $condition['id'] = $cid;
        $result = $model->select();
        print_r($result);
    }

    /**
     * 子类循环遍历找所有父级
     * @param int $cid
     * @param array $result
     * @return array
     */
    public static function getList($cid = 43, &$result = array())
    {
        $model = M('Category'); // return Object
        $condition['id'] = $cid;
        $row = $model->where($condition)->find();
        if ($row) {
            $result[] = $row;
            self::getList($row['pid'], $result);
        }
        krsort($result);
        return $result;
    }

    /**
     * @param string $url
     * @param int $cid
     * 打印效果：商城首页》视频直播》直播API 》查询转码配置信息》
     */
    public function treeLinkHref($url = 'index.php?page=1&id=', $cid = 49)
    {
        $result = self::getList($cid);
        foreach ($result as $key => $val) {
            echo "<a href='{$url}{$val['id']}'>{$val['name']}</a>》";
        }
    }

    //递归无限分类原理
    public static function recursiveFunction($i = 1)
    {
        echo $i;
        $i++;
        if ($i < 10) {
            static::recursiveFunction($i);
        }
    }


}