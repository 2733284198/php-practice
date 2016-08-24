<?php
/**
 * UserModel.class.php
 */
namespace Home\Model;

use Think\Model;
use Think\Model\RelationModel;

class UserModel extends RelationModel
{
    // 映射一个表名
    protected $tableName = 'user';
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
        'Role' => array(
            'mapping_type' => self::MANY_TO_MANY,
            'relation_table' => 'tour_user_role',    //多对多的中间关联表名称
            'foreign_key' => 'user_id',
            'relation_foreign_key' => 'role_id'    //关联表的外键名称 默认的关联表的外键名称是表名_id
            // 'mapping_name'	=>	'node',
            // 'mapping_order'	=>	'sort',
            // 'foreign_key'	=>	'user_id',	//与UserModel关联外键
            // // 'parent_key'	=>	'pid',
            // 'mapping_fields'	=>	'role_id',	//只是需要查询个别字段
            // 'as_fields' => 'role_id'   //直接把关联的字段值映射成数据对象中的某个字段
        ),

        'UserParent' => array(
            'mapping_type' => self::BELONGS_TO,
            'class_name' => 'UserParent',
            'foreign_key' => 'parent_id',
            'as_fields' => 'parent_name',
        ),
    );

}


?>