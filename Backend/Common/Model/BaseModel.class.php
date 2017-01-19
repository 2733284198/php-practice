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


}
