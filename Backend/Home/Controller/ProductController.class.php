<?php
namespace Home\Controller;

use Home\Controller\BaseController;

class ProductController extends BaseController
{
    public function index()
    {
        if (IS_POST) {
            $data['pName'] = I('post.pName');
            $data['pSn'] = I('post.pSn');
            $data['pNum'] = I('post.pNum');
            $data['mPrice'] = I('post.mPrice');
            $data['cid'] = I('post.cid');
            $data['iPrice'] = I('post.file-id');

            $model = M('Product');
            $model->startTrans();
            $insertId = $model->add($data);

            $model2 = M('File');
            $model2->id = I('post.file-id');
            $model2->pid = $insertId;
            $saveId = $model2->save();
            if($saveId && $insertId){
                $model->commit();
                $this->success('添加一个新产品成功', U('Product/index'));
            }else{
                $model->rollback();
                $this->error('添加失败', U('Product/index'));
            }

        }
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

        //通过 A 方法跨模块调用操作,以下为实例化一个Home模块的控制器
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

}