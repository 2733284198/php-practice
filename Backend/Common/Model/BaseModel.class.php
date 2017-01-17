<?php
namespace Common\Model;

use Think\Model;

/**
 * 基础model
 */
class BaseModel extends Model
{
    //数据的保存
    public function store($data)
    {
        if ($this->create($data)) {
            $action = isset($data[$this->pk]) ? "save" : "add";
            $res = $this->$action($data);

            return ['status' => 'success', 'data' => $res, 'message' => '操作成功'];
        }

        return ['status' => 'failed', 'message' => $this->getError() ?: '未知错误'];
    }

}
