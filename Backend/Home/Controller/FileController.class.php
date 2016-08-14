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
    public function uploadFile()
    {
        $software_name = I('post.software_name');
        $software_zh = I('post.software_zh');
        $version_num = I('post.version_num');
        $description = I('post.description');
        $belongs_stage = I('post.belongs_stage');
        $config = array(
            'maxSize' => 536870912,
            'exts'    => array('rpm','apk','exe','zip','rar'),
            'replace' => true,
            'rootPath'=> './Uploads/',
            'saveName'=> $software_name . '_v' . $version_num,      //这个是文件名字
            'subName' => $software_name         //这个是文件上级目录名称，相对于rootPath的下级目录
        );

        $upload = new \Think\Upload($config);
        $info = $upload->upload();
        if($info == false) return $this->error($upload->getError());
        $file_arr = array();
        foreach($info as $v){
            $file_arr = array(
                'name' => $v['name'],   //上传文件本身名称
                'ext' => $v['ext'],
                'size' => $v['size'],
                'savename' => $v['savename'],
                'savepath' => $v['savepath'],
                'sha1' => $v['sha1']
            );
        }
        //url拼接
        $version_url = __ROOT__.'/Uploads/'.$file_arr['savepath'].$file_arr['savename'];

        $db = M('PublishTable');
        $db->software_name = $software_name;
        $db->software_zh = $software_zh;
        $db->version_num = $version_num;
        $db->size = $file_arr['size'];
        $db->url = $version_url;
        $db->publish_time = time();
        $db->description =$description;
        $db->belongs_stage = $belongs_stage;
        $db->sha1 = $file_arr['sha1'];
        if(!$db->add()){
            return $this->error('软件版本发布失败');
        }
        return $this->success('软件版本发布成功',U('Index/index'));
    }

}