<?php
/**
 * UserModel.class.php
 */
namespace Auth\Model;
use Think\Model;
use Think\Model\RelationModel;

class AdminRoleModel extends RelationModel{

	protected $_link=array(
		'AdminAccess'=>array(
			'mapping_type'	=>	self::MANY_TO_MANY,
			'foreign_key' => 'role_id',
			'relation_table' => 'tour_admin_access',	//多对多的中间关联表名称
			'relation_foreign_key' => 'node_id',	//关联表的外键名称 
		),
		
	);

}


?>