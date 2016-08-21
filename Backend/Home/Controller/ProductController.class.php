<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/8/19
 * Time: 9:18
 * Mail: Overcome.wan@Gmail.com
 */
namespace Home\Controller;

use Home\Controller\BaseController;

class ProductController extends BaseController
{
    /**
     * 添加一个商品
     */
    public function index()
    {
        if (IS_POST) {
            $data['pName'] = I('post.pName');
            $data['pSn'] = I('post.pSn');
            $data['pNum'] = I('post.pNum');
            $data['mPrice'] = I('post.mPrice');
            $data['cId'] = I('post.cid');
            $data['iPrice'] = I('post.file-id');
            $data['pubTime'] = date('Y-m-d H:i:s',time());
            $fileId = I('post.file-id');
            $model = M('Product');
            if (empty($fileId)) {
                $insertId = $model->add($data);
                if ($insertId) {
                    $this->success('添加一个新产品成功', U('Product/index'));
                }
                $this->error('添加失败', U('Product/index'));
            } else {
                $model->startTrans();
                $insertId = $model->add($data);

                $model2 = M('File');
                $model2->id = I('post.file-id');
                $model2->pid = $insertId;
                $saveId = $model2->save();
                if ($saveId && $insertId) {
                    $model->commit();
                    $this->success('添加一个新产品成功', U('Product/index'));
                }
                $model->rollback();
                $this->error('添加失败', U('Product/index'));
            }

        }
        $model = M('Category'); // return Object
        $result = $model->field("*,concat(path,',',id) as paths")->order('path')->select();
        $this->categorys = $result;
        $this->display();
    }

    /**
     * 商品列表
     */
    public function productList()
    {
        $db = M('Product');
        $count = $db->count();
        $Page = new \Think\Page($count, 6);
        $Page->setConfig('header', '共%TOTAL_ROW%条');
        $Page->setConfig('first', '首页');
        $Page->setConfig('last', '共%TOTAL_PAGE%页');
        $Page->setConfig('prev', '上一页');
        $Page->setConfig('next', '下一页');
        $Page->setConfig('link', 'indexpagenumb');
        $Page->setConfig('theme', '%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');
        $show = $Page->show();
        // 进行分页数据查询 注意limit方法的参数要使用Page类的属性
        $lists = $db->limit($Page->firstRow . ',' . $Page->listRows)->order('pubtime DESC')->select();
        $this->lists = $lists;
        $this->show = $show;
        $this->display('Product/productlist');
    }

    /**
     * 商品图片上传
     */
    public function UploadImage()
    {
        // 接受URL地址传递的参数
        $pid = I('get.pid');
        //接受 formData 动态传值
        $sessionId = $_POST['session_id'];

        //通过 A 方法跨模块调用操作,以下为实例化一个Home模块的File控制器，其实也就是实例化这个控制器了
        $file = A('Home/File');
        $result = $file->imageUpload('Product', TRUE, 100, 100, TRUE);
        if (!$result) {
            $result1['status'] = '0';
            $result1['list'] = null;
            $this->ajaxReturn($result1, 'JSON');
        }
        $model = M('File');
        $data['pid'] = $pid;
        $data['min_path'] = $result['mini_pic'];
        $data['path'] = $result['pic_path'];
        if($result['unlink']) $data['path'] = $result['mini_pic'];

        $insertId = $model->add($data);
        if (!$insertId) {
            $result1['status'] = '0';
            $result1['list'] = null;
            $this->ajaxReturn($result1, 'JSON');
        }
        $result['fileId'] = $insertId;
        $this->ajaxReturn(json_encode($result), 'JSON');

    }

    /**
     * 删除产品的同时删除掉对应的图片
     * 【1】开启事务
     * 【2】查看该物品是否存在
     * 【3】删除商品记录
     * 【3】删除商品图片【物理删除】,如果有空目录会一并删除
     * 【4】删除图片记录信息表
     * 【5】判断物品删除和图片删除是否都删除成功 【TURE 提交事务】【FALE 回滚事务】
     * 【6】JSON返回Client
     */
    public function delProduct()
    {
        $id = I('post.id');
        $model = M('Product');
        // 开启事务
        $model->startTrans();
        //$where['id'] = ':id';
        $find = $model->where(['id'=>':id'])->bind(':id', $id, \PDO::PARAM_INT)->find();
        if ($find == false) {
            $response = ['errcode' => 500, 'errmsg' => 'Product is not exists', 'dataList' => $find];
            $this->ajaxReturn($response, 'JSON');
        }
        $result = $model->where(['id'=>':id'])->bind(':id', $id, \PDO::PARAM_INT)->delete();
        if ($result == false) {
            $response = ['errcode' => 500, 'errmsg' => 'Product delete fail', 'dataList' => $result];
            $this->ajaxReturn($response, 'JSON');
        }
        // 遍历所有产品的图片，进行物理删除
        $where2['pid'] = ':pid';
        $thumbs = M('File')->where($where2)->bind(':pid', $id, \PDO::PARAM_INT)->select();

        if ($thumbs && is_array($thumbs)) {
            foreach ($thumbs as $thumb) {
                if (file_exists(C('UPLOAD_PATH') . $thumb['path'])) {
                    if (!unlink(C('UPLOAD_PATH') . $thumb['path'])) {
                        $response = ['errcode' => 500, 'errmsg' => 'unlink path fail'];
                        $this->ajaxReturn($response, 'JSON');
                    }
                }
                if (file_exists(C('UPLOAD_PATH') . $thumb['min_path'])) {
                    if (!unlink(C('UPLOAD_PATH') . $thumb['min_path'])) {
                        $response = ['errcode' => 500, 'errmsg' => 'unlink min_path fail'];
                        $this->ajaxReturn($response, 'JSON');
                    }
                }
                //如果目录文件为空，则删除目录文件，也就是个目录下面的最后一个文件一起删除的
                //dirname返回路径的目录部分,
                if (is_dir(dirname(C('UPLOAD_PATH') . $thumb['path']))) {
                    //如果目录文件为空，则删除目录文件
                    rmdir(dirname(C('UPLOAD_PATH') . $thumb['path']));
                    /**
                     * rmdir() 删除空白目录
                     * 注意：这里删除的对应的网站根目录。和网站域名是没有关系的,也就是完整路径哦
                     */
                }
            }
        }

        //同时删除文件记录表中数据file表中的数据
        $result2 = M('File')->where($where2)->bind(':pid', $id, \PDO::PARAM_INT)->delete();
        if ($thumbs && !$result2) {
            $response = ['errcode' => 500, 'errmsg' => 'File fail'];
            $this->ajaxReturn($response, 'JSON');
        }

        if ($thumbs) {
            if ($result && $result2) {
                $model->commit();
                $response = array('errcode' => 200, 'errmsg' => '恭喜你,删除成功!');
                $this->ajaxReturn($response, 'JSON');
            }
        } else {
            if ($result) {
                $model->commit();
                $response = array('errcode' => 200, 'errmsg' => '恭喜你,删除成功!');
                $this->ajaxReturn($response, 'JSON');
            }
        }
        $model->rollback();
        $response = ['errcode' => 500, 'errmsg' => 'File and Prodect delete', 'dataList' => $result];
        $this->ajaxReturn($response, 'JSON');
    }

    public function test()
    {
        $model = M('Product');
        //生成一定数量的随机数，并且不重复
        p(word_time(time()));
    }

}