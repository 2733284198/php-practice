<?php
/**
 * UserModel.class.php
 */
namespace Home\Logic;
use Think\Model;
use Think\Model\RelationModel;

class AdminNodeLogic extends RelationModel{

	protected $_link=array(
		'AdminNode'=>array(
			'mapping_type'	=>	self::HAS_MANY,			//AdminNode自己关联自己
			'class_name'    => 'AdminNode',
			'parent_key' => 'pid',
			'mapping_order' => 'sort desc',
			'mapping_name' => 'node',	//关联的映射名称，用于获取数据用 该名称不要和当前模型的字段有重复，
		),
		
	);

}


?>