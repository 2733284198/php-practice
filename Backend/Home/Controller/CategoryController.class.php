<?php
namespace Home\Controller;

use Home\Controller\BaseController;

class CategoryController extends BaseController
{
    public function index()
    {
        $model = M('Category'); // return Object
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();
        $this->categorys = $result;
        $this->display();
    }

    /**
     * 按照树级目录分类
     */
    public function tree()
    {
        $model = M('Category'); // return Object
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();
        $this->categorys = $result;
        $this->display();
    }

    /**
     * 添加一个新分类
     */
    public function addCategory()
    {
        if (IS_POST) {
            $data['pid'] = I('post.pid');
            $data['name'] = I('post.name');
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
                    return $this->success('添加一个新分类成功', U('Index/index'));
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
                    return $this->error('添加一个新分类失败');
                } else {
                    return $this->success('添加一个新分类成功', U('Index/index'));
                }
            } else {
                return $this->error('添加一个新分类失败');
            }
        }
        $model = M('Category'); // return Object
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();
        foreach ($result as $key => $v) {
            $result[$key]['name'] = str_repeat('&nbsp;&nbsp;&nbsp;', $v['level']) . $v['name'];
        }
        $this->categorys = $result;
        $this->display();
    }


    /**
     * 添加一个新分类
     */
    public function ajaxAdd()
    {
        if (IS_POST) {
            $data['pid'] = I('post.pid');
            $data['name'] = I('post.name');
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
                    return $this->success('添加一个新分类成功', U('Index/index'));
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
                    return $this->error('添加一个新分类失败');
                } else {
                    return $this->success('添加一个新分类成功', U('Index/index'));
                }
            } else {
                return $this->error('添加一个新分类失败');
            }
        }
        $model = M('Category'); // return Object
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();
        foreach ($result as $key => $v) {
            $result[$key]['name'] = str_repeat('&nbsp;&nbsp;&nbsp;', $v['level']) . $v['name'];
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
        $prod = M('Product')->where(array('cId'=>$id))->find();
        if($prod){
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
     * 删除分类
     * 【1】删除分类同时删除分类下的商品
     * 删除分类之前，查看该分类下面是否有商品，如果有则提示，下删除该商品，才可以删除该分类
     */
    public function test()
    {
        echo 'category test';
    }


}