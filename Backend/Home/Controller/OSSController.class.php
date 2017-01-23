<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/1/20
 * |  Time: 16:25
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Home\Controller;

use Org\Util\MonoLogInstance;
use Org\Util\OssInstance;
use OSS\Core\OssException;
use OSS\OssClient;
use Think\Controller;

/**
 * help:https://yq.aliyun.com/articles/54024?spm=5176.doc32099.2.3.ar8ra2
 */
class OSSController extends Controller
{
    public function index()
    {
        echo __METHOD__;

    }

    /**
     * OssClient初始化
     */
    public function ossClient()
    {
        OssInstance::Instance();
    }

    /**
     * 【ok!】上传一个文件
     *  遇到的问题：刚开始在这里一直上传一个文件夹，始终上传不了，检查到最后结果是文件路径多一个‘/’,这个应该是官方的Debug吧！哈哈
     */
    public function uploadFile()
    {
        $bucket = C("OSS_CONFIG.bucket");
        $object = 'Uploads/BaiduApp/BaiduApp_v1.0.zip'; //！！！注意：这里要强调的是这个文件路径前面没有‘/’
        $file = './' . $object;  //这个才是文件在本地的真实路径，也是就是你要上传的文件信息
        $oss = OssInstance::Instance();
        try {
            $oss->uploadFile($bucket, $object, $file);
        } catch (OssException $e) {
            //Writes the current log
            MonoLogInstance::Instance()->addError('Oss Upload file failed err_msg:' . $e->getMessage(),
                [
                    'function' => __METHOD__,
                    'line' => __LINE__
                ]
            );
            return false;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }

    /**
     * 【ok!】上传一个文件夹
     *  一次性Success
     */
    public function uploadDir()
    {
        $bucket = "tinywan-test002";
        $object = "images";
        $content = './Uploads/BaiduApp'; // 这里的已经是根目录了
        $oss = OssInstance::Instance();
        $responseResult = $oss->uploadDir($bucket, $object, $content);
        if (!empty($responseResult['succeededList'])) {
            echo 'success';
            var_dump($responseResult['succeededList']);
        } else {
            exit('error!');
        }
    }

    /**
     * 上传字符串作为object的内容
     *
     * @param OssClient $ossClient OSSClient实例
     * @param string $bucket 存储空间名称
     * @return null
     */
    public function putObject()
    {
        $ossClient = OssInstance::Instance();
        $bucket = 'tinywan-test002';
        $object = "./Uploads/test-object-name.txt";
        $content = file_get_contents(__FILE__);
        try {
            $ossClient->putObject($bucket, $object, $content);
        } catch (OssException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        print(__FUNCTION__ . ": OK" . "\n");
    }


    /**
     * 存储空间操作
     */
    public function createBucket()
    {
        $bucket = "tinywan-test002";
        try {
            $responseResult = OssInstance::Instance()->createBucket($bucket);
        } catch (OssException $e) {
            print $e->getMessage();
        }
        var_dump($responseResult);
    }

    /**
     * 返回结果处理
     * Put，Delete类接口，接口返回null，如果没有OssException，即可认为操作成功
     * Get，List类接口，接口返回对应的数据，如果没有OssException，即可认为操作成功
     */
    public function responseResult()
    {
        $bucketListInfo = OssInstance::Instance()->listBuckets();
        $bucketList = $bucketListInfo->getBucketList();
        foreach ($bucketList as $bucket) {
            print($bucket->getLocation() . "\t" . $bucket->getName() . "\t" . $bucket->getCreatedate() . "\n");
        }
    }
}