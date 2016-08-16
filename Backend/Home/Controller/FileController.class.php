<?php
namespace Home\Controller;

use Home\Controller\BaseController;

class FileController extends BaseController
{
    public function index()
    {
        $this->display();
    }

    /**
     * 上传文件
     */
    public function uploadFile($thumbWidth = 100, $thumbHeight = 100)
    {

        $software_name = I('post.software_name');
        $software_zh = I('post.software_zh');
        $version_num = I('post.version_num');
        $description = I('post.description');
        $belongs_stage = I('post.belongs_stage');
        $config = array(
            'maxSize' => 536870912, // C('UPLOAD_MAX_SIZE')
            'exts' => array('rpm', 'apk', 'exe', 'zip', 'rar', 'jpg'),    //C('UPLOAD_EXTS')
            'rootPath' => './Uploads/',  //C('UPLOAD_PATH')
            'saveName' => iconv('UTF-8', 'GBK', $software_name . '_v' . $version_num),      //文件名规则,这个是文件名字,也就是文件需要保存的名称
            'subName' => iconv('UTF-8', 'GBK', $software_name),       //子目录创建规则，这个是文件上级目录名称，相对于rootPath的下级目录
            //'replace' => true,        //存在同名文件覆盖
            'autoSub' => true        //使用子目录保存
        );
        // 检测当前目录是否存在目录不存在的话,则尝试新建一个Uploads目录
        if (!is_dir($config['rootPath'])) mkdir(iconv('UTF-8', 'GBK', $config['rootPath']), 0777, true);

        $upload = new \Think\Upload($config);
        $info = $upload->upload();
        if ($info == false) return $this->error($upload->getError());

        //======================生成缩略图=============
        $image = new \Think\Image();

        $file_arr = array();
        foreach ($info as $v) {
            $thumb_file = $config['rootPath'] . $v['savepath'] . $v['savename'];
            $save_path = $config['rootPath'] . $v['savepath'] . 'mini_' . $v['savename'];
            $image->open($thumb_file);
            $image->thumb($thumbWidth, $thumbHeight, \Think\Image::IMAGE_THUMB_FIXED);
            $image->save($save_path);
            //======================生成缩略图=============
            $file_arr = array(
                'name' => $v['name'],   //上传文件本身名称
                'ext' => $v['ext'],
                'size' => $v['size'],
                'savename' => $v['savename'],
                'savepath' => $v['savepath'],
                'sha1' => $v['sha1'],
                'mini_pic' => $v['savepath'] . 'mini_' . $v['savename']
            );
            //unlink($thumb_file); //上传生成缩略图以后删除源文件
        }
        //url拼接
        $version_url = __ROOT__ . '/Uploads/' . iconv('UTF-8', 'GBK', $file_arr['savepath']) . iconv('UTF-8', 'GBK', $file_arr['savename']);

        $db = M('PublishTable');
        $db->software_name = $software_name;
        $db->software_zh = $software_zh;
        $db->version_num = $version_num;
        $db->size = $file_arr['size'];
        $db->url = $version_url;
        $db->publish_time = time();
        $db->description = $description;
        $db->belongs_stage = $belongs_stage;
        $db->sha1 = $file_arr['sha1'];
        $db->upload_name = $file_arr['mini_pic'];
        if (!$db->add()) {
            return $this->error('软件版本发布失败');
        }
        return $this->success('软件版本发布成功', U('Index/index'));
    }

    /**
     * Uploadify图片上传
     */
    public function image()
    {
        $this->display();
    }

    /**
     * 图片上传处理,包括缩略图的生成
     * @param [String] $path [保存文件夹名称，默认为Images]
     * @param [String] $thumb [是否生成缩略图,默认False不生成缩略图]
     * @param [String] $thumbWidth [缩略图宽度]
     * @param [String] $thumbHeight [缩略图高度]
     * @return [Array] [图片上传信息]
     */
    public function imageUpload($path = 'Images', $thumb = FALSE, $thumbWidth = 100, $thumbHeight = 100)
    {
        $typeCode = $_POST['typeCode'];
        // 检查配置目录是否存在，如果不存在，则创建一个
        if (!is_dir(C('UPLOAD_PATH'))) {
            mkdir(iconv('UTF-8', 'GBK', C('UPLOAD_PATH')), 0777, true);
        }
        //============支持在实例化后动态赋值上传参数===================
        $obj = new \Think\Upload();// 实例化上传类
        $obj->maxSize = C('UPLOAD_MAX_SIZE');// 设置附件上传大小
        $obj->rootPath = C('UPLOAD_PATH');// 保存根路径
        $obj->savePath = $path . '/'; // 设置附件上传目录
        $obj->exts = C('UPLOAD_EXTS');// 设置附件上传类型
        $obj->saveName = array('uniqid', '');//文件名规则
        $obj->replace = true;//存在同名文件覆盖
        $obj->autoSub = true;//使用子目录保存
        $obj->subName = array('date', 'Y-m-d');//子目录创建规则，
        $info = $obj->upload();
        // 没有上传成功，则直接返回错误信息
        if (!$info) return array('status' => 0, 'msg' => $obj->getError());

        //=============是否生成缩略图==================================
        if (TRUE == $thumb) {
            $image = new \Think\Image();
            // 循环获取上传文件信息
            foreach ($info as $file) {
                // 获取缩略图文件
                $thumbFile = C('UPLOAD_PATH') . $file['savepath'] . $file['savename'];
                // 保存缩略图路径,也就是需要保存的文件的格式
                $savePath = C('UPLOAD_PATH') . $file['savepath'] . 'mini_' . $file['savename'];
                //使用open方法打开图像文件进行相关操作
                $image->open($thumbFile);
                $width = $image->width(); // 返回图片的宽度
                $height = $image->height(); // 返回图片的高度
                $type = $image->type(); // 返回图片的类型
                $mime = $image->mime(); // 返回图片的mime类型
                $size = $image->size(); // 返回图片的尺寸数组 0 图片宽度 1 图片高度
                //使用thumb方法生成缩略图,IMAGE_THUMB_FILLED    =   2 ; 缩放后填充类型
                $image->thumb($thumbWidth, $thumbHeight, \Think\Image::IMAGE_THUMB_SCALE);
                $image->save($savePath);
                // 返回文件信息
                return array(
                    'status' => 1,
                    'savepath' => $file['savepath'],
                    'savename' => $file['savename'],
                    'width' => $width,
                    'height' => $height,
                    'type' => $type,
                    'sha1' => $file['sha1'],
                    'md5' => $file['md5'],
                    'mime' => $mime,
                    'pic_path' => $file['savepath'] . $file['savename'],
                    'mini_pic' => $file['savepath'] . 'mini_' . $file['savename'],
                    'typeCode' => $typeCode
                );
                //@unlink($thumb_file); //上传生成缩略图以后删除源文件
            }
            //=================================是否生成缩略图==================================
        } else {
            foreach ($info as $file) {
                // 返回文件信息
                return array(
                    'status' => 1,
                    'savepath' => $file['savepath'],
                    'savename' => $file['savename'],
                    'ext' => $file['ext'],
                    'size' => $file['size'],
                    'sha1' => $file['sha1'],
                    'md5' => $file['md5'],
                    'type' => $file['type'],
                    'pic_path' => $file['savepath'] . $file['savename']
                );
            }
        }
    }

    /**
     * 添加图片水印
     * @param string $path
     * @param bool $thumb
     * @param int $thumbWidth
     * @param int $thumbHeight
     * @return array
     */
    public function waterImage($path = 'Images', $water = FALSE)
    {
        // 检查配置目录是否存在，如果不存在，则创建一个
        if (!is_dir(C('UPLOAD_PATH'))) {
            mkdir(iconv('UTF-8', 'GBK', C('UPLOAD_PATH')), 0777, true);
        }
        //============支持在实例化后动态赋值上传参数===================
        $obj = new \Think\Upload();// 实例化上传类
        $obj->maxSize = C('UPLOAD_MAX_SIZE');// 设置附件上传大小
        $obj->rootPath = C('UPLOAD_PATH');// 保存根路径
        $obj->savePath = $path . '/'; // 设置附件上传目录
        $obj->exts = C('UPLOAD_EXTS');// 设置附件上传类型
        $obj->saveName = array('uniqid', '');//文件名规则
        $obj->replace = true;//存在同名文件覆盖
        $obj->autoSub = true;//使用子目录保存
        $obj->subName = array('date', 'Y-m-d');//子目录创建规则，
        $info = $obj->upload();
        // 没有上传成功，则直接返回错误信息
        if (!$info) return array('status' => 0, 'msg' => $obj->getError());

        //=============是否生成缩略图==================================
        if (TRUE == $water) {
            $image = new \Think\Image();
            // 循环获取上传文件信息
            foreach ($info as $file) {
                // 获取缩略图文件
                $waterFile = C('UPLOAD_PATH') . $file['savepath'] . $file['savename'];
                $logoFile = C('UPLOAD_PATH') . 'Logo/apple.png';
                // 保存水印图路径,也就是需要保存的文件的格式
                $waterPath = C('UPLOAD_PATH') . $file['savepath'] . 'water_' . $file['savename'];
                //使用open方法打开图像文件进行相关操作
                $image->open($waterFile);
                //将图片裁剪为440x440并保存为corp.jpg
                $image->water($logoFile, \Think\Image::IMAGE_THUMB_NORTHWEST, 50);
                $image->save($waterPath);

                // 返回文件信息
                return array(
                    'status' => 1,
                    'savepath' => $file['savepath'],
                    'savename' => $file['savename'],
                    'pic_path' => $file['savepath'] . $file['savename'],
                    'water_pic' => $file['savepath'] . 'water_' . $file['savename']
                );
                //@unlink($thumb_file); //上传生成缩略图以后删除源文件
            }
            //=================================是否生成缩略图==================================
        } else {
            foreach ($info as $file) {
                // 返回文件信息
                return array(
                    'status' => 1,
                    'savepath' => $file['savepath'],
                    'savename' => $file['savename'],
                    'ext' => $file['ext'],
                    'size' => $file['size'],
                    'sha1' => $file['sha1'],
                    'md5' => $file['md5'],
                    'type' => $file['type'],
                    'pic_path' => $file['savepath'] . $file['savename']
                );
            }
        }
    }

    /**
     * uploadify 文件上传,通过调用imageUpload（）方法
     */
    public function uploadImage()
    {
        $result = $this->imageUpload('Img', TRUE, 150, 150);
        var_dump($result);
    }

    /**
     * uploadify 文件上传,通过调用imageUpload（）方法
     */
    public function uploadifyUploadImage()
    {
        //$pid = I('post.pid');
        $pid = I('get.pid');
        $sessionId = $_POST['session_id'];
        $result = $this->imageUpload('Face', TRUE, 100, 100);
        $result['pid'] = $pid;
        $result['sessionId'] = $sessionId;
        $this->ajaxReturn(json_encode($result), 'JSON');
    }

    /**
     * 头像上传
     */
    Public function uploadFace()
    {
        if (!IS_POST) E('页面不存在');
        $result = $this->imageUpload('Face', TRUE, 100, 100);
        $this->ajaxReturn(json_encode($result), 'JSON');
    }

    /**
     * 修改用户头像
     */
    public function editFace()
    {
        if (!IS_POST) E('页面不存在');
        $model = M('user');
        $where = array('uid' => session('uid'));
        $field = array('face180');
        $old = $model->where($where)->field($field)->find();
        if ($model->where($where)->save($_POST)) {
            if (!empty($old['face180'])) {
                @unlink('./Uploads/'.$old['face180']);//删除之前的缩略图
            }
            $this->success('修改成功',U('index'));
        }else{
            $this->error('修改失败,请重试。。。');
        }
    }

    public function test()
    {
        if (!is_dir(C('UPLOAD_PATH'))) {
            var_dump(mkdir(iconv('UTF-8', 'GBK', C('UPLOAD_PATH')), 0777, true));
        }
        echo 1111111;
    }


}