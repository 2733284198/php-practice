<?php
/**
 * UserModel.class.php
 */
namespace Home\Model;

use Think\Model;
use Think\Model\RelationModel;

class AdminUserModel extends RelationModel
{
    /**
     * 服务器端自动验证
     */
    protected $_validate = array(
        array('username','require','用户名不能为空！'),
        array('username','','用户名已经存在！',0,'unique',1),
        array('username','/^[\x80-\xff\w]{2,14}$/s','用户名格式不正确',1,'regex'),

        array('password','require','密码不能为空',1),
        array('password','/^\w{6,18}$/','密码格式不正确',1,'regex'),
        array('pwded','password','确认密码不合适',1,'confirm'),
    );

    protected $_link = array(
        'AdminRole' => array(
            'mapping_type' => self::MANY_TO_MANY,
            'foreign_key' => 'user_id',
            'relation_table' => 'tour_admin_role_user',    //多对多的中间关联表名称
            'relation_foreign_key' => 'role_id',    //关联表的外键名称
            'mapping_name' => 'role_name',
        ),

    );

}


?>