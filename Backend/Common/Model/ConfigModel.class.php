<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/1/19
 * |  Time: 18:15
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Common\Model;


class ConfigModel extends BaseModel
{
    protected $pk = 'id';
    protected $tableName = 'config';
    protected $_validate = [
        ['system', 'require', '系统配置不能为空'],
        ['wechat', 'require', '公众号配置不能为空']
    ];

    //保存数据
    public function store($data)
    {
        $data['id'] = 1;
        return parent::store($data);
    }
}