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
        $version_url = __ROOT__ . '/Uploads/' . $file_arr['savepath'] . $file_arr['savename'];

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

    public function uploadImage()
    {

        if (!empty($_FILES)) {
            //图片上传设置
            $config = array(
                'maxSize' => 3145728,
                'savePath' => '',
                'saveName' => array('uniqid', ''),
                'exts' => array('jpg', 'png', 'jpeg'),
                'autoSub' => true,
                'subName' => array('date', 'Y-m-d'),
            );
            //得到上传的临时文件流
            $tempFile = $_FILES['Filedata']['tmp_name'];

            //允许的文件后缀
            $fileTypes = array('jpg', 'jpeg', 'gif', 'png');

            //得到文件原名
            $fileName = iconv("UTF-8", "GB2312", $_FILES["Filedata"]["name"]);
            $fileParts = pathinfo($_FILES['Filedata']['name']);

            //接受动态传值
            $files = $_POST['typeCode'];

            $upload = new \Think\Upload($config);// 实例化上传类
            $images = $upload->upload();
            //判断是否有图
            if ($images == false) {
                echo $fileName . "上传失败！";
            } else {
                echo $fileName . "上传成功！";
            }
        }
    }


}