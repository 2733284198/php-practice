<?php
/**
 * UserModel.class.php
 */
namespace Home\Model;
use Think\Model;
use Think\Model\RelationModel;

class AdminUserModel extends RelationModel{

	protected $_link=array(
		'AdminRole'=>array(
			'mapping_type'	=>	self::MANY_TO_MANY,
			'foreign_key' => 'user_id',
			'relation_table' => 'tour_admin_role_user',	//多对多的中间关联表名称
			'relation_foreign_key' => 'role_id',	//关联表的外键名称 	
			'mapping_name' => 'role_name',
		),
		
	);

}


?>