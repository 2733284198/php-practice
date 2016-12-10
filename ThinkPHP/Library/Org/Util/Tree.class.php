<?php
namespace Org\Util;
class Tree
{
    public static $treeList = [];
    public static $treeLink = [];

    /** 获取权限节点列表
     * @param $data
     * @param int $pid
     * @return array
     */
    public static function create($data, $pid = 0)
    {
        foreach ($data as $key => $value) {
            if ($value['pid'] == $pid) {
                self::$treeList[] = $value;    //用类名或者self在非静态方法中访问静态成员
                unset($data[$key]);
                self::create($data, $value['id']);
            }
        }
        return self::$treeList;//返回本类的对象
    }

    /**
     * 获取导航栏信息
     * @param $data
     * @param int $pid
     * @return array
     */
    public static function treeLink($data, $pid = 0)
    {
        foreach ($data as $key => $value) {
            if ($value['pid'] == $pid) {
                self::$treeList[] = $value;    //用类名或者self在非静态方法中访问静态成员
                unset($data[$key]);
                self::create($data, $value['id']);
            }
        }
        return self::$treeList;//返回本类的对象
    }

    //一个简单的递归简单的方法
    public static function recursiveFunction($i = 1)
    {
        echo $i;
        $i++;
        if ($i < 10) {
            static::recursiveFunction($i);
        }
    }
}