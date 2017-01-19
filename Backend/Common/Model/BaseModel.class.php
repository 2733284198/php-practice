<?php
namespace Common\Model;

use Think\Model;

/**
 * 基础model
 */
class BaseModel extends Model
{
    /**
     * 添加数据
     * @param  array $data 添加的数据
     * @return int          新增的数据id
     */
    public function addData($data)
    {
        // 去除键值首尾的空格
        foreach ($data as $k => $v) {
            $data[$k] = trim($v);
        }
        $id = $this->add($data);
        return $id;
    }

    /**
     * 修改数据
     * @param   array $map where语句数组形式
     * @param   array $data 数据
     * @return  boolean         操作是否成功
     */
    public function editData($map, $data)
    {
        // 去除键值首位空格
        foreach ($data as $k => $v) {
            $data[$k] = trim($v);
        }
        $result = $this->where($map)->save($data);
        return $result;
    }


}
