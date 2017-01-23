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
use OSS\Core\OssException;
use OSS\OssClient;
use Think\Controller;

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
       var_dump(oss_instance());
    }

    /**
     * 文件操作
     */
    public function fileOption()
    {
        $bucket = "tinywan01";
        $object = "Images";
        $content = __ROOT__ . '/Uploads/20160815/57b14a3ef1fd9.png';
        try {
            $responseResult = $this->ossClient()->putObject($bucket, $object, $content);
        } catch (OssException $e) {
            print $e->getMessage();
        }

        var_dump($responseResult);
    }

    /**
     * 存储空间操作
     */
    public function createBucket()
    {
        $bucket = "tinywan-test002";
        try {
            $responseResult = $this->ossClient()->createBucket($bucket);
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
        $bucketListInfo = $this->ossClient()->listBuckets();
        $bucketList = $bucketListInfo->getBucketList();
        foreach($bucketList as $bucket) {
            print($bucket->getLocation() . "\t" . $bucket->getName() . "\t" . $bucket->getCreatedate() . "\n");
        }
    }
}