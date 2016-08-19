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
        $result = $file->imageUpload('Product', TRUE, 100, 100);
        if (!$result) {
            $result1['status'] = '0';
            $result1['list'] = null;
            $this->ajaxReturn($result1, 'JSON');
        }
        $model = M('File');
        $data['pid'] = $pid;
        $data['min_path'] = $result['mini_pic'];
        $data['path'] = $result['pic_path'];
        $insertId = $model->add($data);
        if (!$insertId) {
            $result1['status'] = '0';
            $result1['list'] = null;
            $this->ajaxReturn($result1, 'JSON');
        }
        $result['fileId'] = $insertId;
        $this->ajaxReturn(json_encode($result), 'JSON');

    }

    public function test(){
        $model = M('Product');
        //生成一定数量的随机数，并且不重复
        p(word_time(time()));
    }

}