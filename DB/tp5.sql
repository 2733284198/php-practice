/*
Navicat MySQL Data Transfer

Source Server         : 本地连接
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : tp5

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-09-02 00:14:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bjyadmin_admin_nav
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_admin_nav`;
CREATE TABLE `bjyadmin_admin_nav` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜单表',
  `pid` int(11) unsigned DEFAULT '0' COMMENT '所属菜单',
  `name` varchar(15) DEFAULT '' COMMENT '菜单名称',
  `mca` varchar(255) DEFAULT '' COMMENT '模块、控制器、方法',
  `ico` varchar(20) DEFAULT '' COMMENT 'font-awesome图标',
  `order_number` int(11) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bjyadmin_admin_nav
-- ----------------------------
INSERT INTO `bjyadmin_admin_nav` VALUES ('1', '0', '系统设置', 'Admin/ShowNav/config', 'cog', '1');
INSERT INTO `bjyadmin_admin_nav` VALUES ('2', '1', '菜单管理', 'Admin/Nav/index', null, null);
INSERT INTO `bjyadmin_admin_nav` VALUES ('7', '4', '权限管理', 'Admin/Rule/index', '', '1');
INSERT INTO `bjyadmin_admin_nav` VALUES ('4', '0', '权限控制', 'Admin/ShowNav/rule', 'expeditedssl', '2');
INSERT INTO `bjyadmin_admin_nav` VALUES ('8', '4', '用户组管理', 'Admin/Rule/group', '', '2');
INSERT INTO `bjyadmin_admin_nav` VALUES ('9', '4', '管理员列表', 'Admin/Rule/admin_user_list', '', '3');
INSERT INTO `bjyadmin_admin_nav` VALUES ('16', '0', '会员管理', 'Admin/ShowNav/', 'users', '4');
INSERT INTO `bjyadmin_admin_nav` VALUES ('17', '16', '会员列表', 'Admin/User/index', '', null);
INSERT INTO `bjyadmin_admin_nav` VALUES ('36', '0', '文章管理', 'Admin/ShowNav/posts', 'th', '6');
INSERT INTO `bjyadmin_admin_nav` VALUES ('37', '36', '文章列表', 'Admin/Posts/index', '', null);

-- ----------------------------
-- Table structure for bjyadmin_alipay_order
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_alipay_order`;
CREATE TABLE `bjyadmin_alipay_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '支付宝回执单主键id',
  `product_order_sn` bigint(15) NOT NULL COMMENT '订单号',
  `price` decimal(10,2) unsigned NOT NULL COMMENT '支付金额',
  `alipay_sn` varchar(255) NOT NULL DEFAULT '' COMMENT '阿里支付单号',
  `buyer_email` varchar(255) NOT NULL DEFAULT '' COMMENT '购买者邮箱',
  `pay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支付时间',
  `detail` text NOT NULL COMMENT '详细内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=140 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bjyadmin_alipay_order
-- ----------------------------

-- ----------------------------
-- Table structure for bjyadmin_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_auth_group`;
CREATE TABLE `bjyadmin_auth_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text NOT NULL COMMENT '规则id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of bjyadmin_auth_group
-- ----------------------------
INSERT INTO `bjyadmin_auth_group` VALUES ('1', '超级管理员', '1', '6,96,20,1,2,3,4,5,64,21,7,8,9,10,11,12,13,14,15,16,123,124,125,19,104,105,106,107,108,118,109,110,111,112,117');
INSERT INTO `bjyadmin_auth_group` VALUES ('2', '产品管理员', '1', '6,96,1,2,3,4,56,57,60,61,63,71,72,65,67,74,75,66,68,69,70,73,77,78,82,83,88,89,90,99,91,92,97,98,104,105,106,107,108,118,109,110,111,112,117,113,114');
INSERT INTO `bjyadmin_auth_group` VALUES ('4', '文章编辑', '1', '6,96,57,60,61,63,71,72,65,67,74,75,66,68,69,73,79,80,78,82,83,88,89,90,99,100,97,98,104,105,106,107,108,118,109,110,111,112,117,113,114');

-- ----------------------------
-- Table structure for bjyadmin_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_auth_group_access`;
CREATE TABLE `bjyadmin_auth_group_access` (
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `group_id` int(11) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组明细表';

-- ----------------------------
-- Records of bjyadmin_auth_group_access
-- ----------------------------
INSERT INTO `bjyadmin_auth_group_access` VALUES ('88', '1');
INSERT INTO `bjyadmin_auth_group_access` VALUES ('89', '2');
INSERT INTO `bjyadmin_auth_group_access` VALUES ('89', '4');

-- ----------------------------
-- Table structure for bjyadmin_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_auth_rule`;
CREATE TABLE `bjyadmin_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of bjyadmin_auth_rule
-- ----------------------------
INSERT INTO `bjyadmin_auth_rule` VALUES ('1', '20', 'Admin/ShowNav/nav', '菜单管理', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('2', '1', 'Admin/Nav/index', '菜单列表', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('3', '1', 'Admin/Nav/add', '添加菜单', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('4', '1', 'Admin/Nav/edit', '修改菜单', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('5', '1', 'Admin/Nav/delete', '删除菜单', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('21', '0', 'Admin/ShowNav/rule', '权限控制', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('7', '21', 'Admin/Rule/index', '权限管理', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('8', '7', 'Admin/Rule/add', '添加权限', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('9', '7', 'Admin/Rule/edit', '修改权限', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('10', '7', 'Admin/Rule/delete', '删除权限', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('11', '21', 'Admin/Rule/group', '用户组管理', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('12', '11', 'Admin/Rule/add_group', '添加用户组', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('13', '11', 'Admin/Rule/edit_group', '修改用户组', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('14', '11', 'Admin/Rule/delete_group', '删除用户组', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('15', '11', 'Admin/Rule/rule_group', '分配权限', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('16', '11', 'Admin/Rule/check_user', '添加成员', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('19', '21', 'Admin/Rule/admin_user_list', '管理员列表', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('20', '0', 'Admin/ShowNav/config', '系统设置', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('6', '0', 'Admin/Index/index', '后台首页', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('64', '1', 'Admin/Nav/order', '菜单排序', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('96', '6', 'Admin/Index/welcome', '欢迎界面', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('104', '0', 'Admin/ShowNav/posts', '文章管理', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('105', '104', 'Admin/Posts/index', '文章列表', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('106', '105', 'Admin/Posts/add_posts', '添加文章', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('107', '105', 'Admin/Posts/edit_posts', '修改文章', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('108', '105', 'Admin/Posts/delete_posts', '删除文章', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('109', '104', 'Admin/Posts/category_list', '分类列表', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('110', '109', 'Admin/Posts/add_category', '添加分类', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('111', '109', 'Admin/Posts/edit_category', '修改分类', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('112', '109', 'Admin/Posts/delete_category', '删除分类', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('117', '109', 'Admin/Posts/order_category', '分类排序', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('118', '105', 'Admin/Posts/order_posts', '文章排序', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('123', '11', 'Admin/Rule/add_user_to_group', '设置为管理员', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('124', '11', 'Admin/Rule/add_admin', '添加管理员', '1', '1', '');
INSERT INTO `bjyadmin_auth_rule` VALUES ('125', '11', 'Admin/Rule/edit_admin', '修改管理员', '1', '1', '');

-- ----------------------------
-- Table structure for bjyadmin_oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_oauth_user`;
CREATE TABLE `bjyadmin_oauth_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联的本站用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型 1：融云   2：友盟',
  `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '第三方昵称',
  `head_img` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `access_token` varchar(255) NOT NULL DEFAULT '' COMMENT 'access_token token',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=672 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bjyadmin_oauth_user
-- ----------------------------
INSERT INTO `bjyadmin_oauth_user` VALUES ('671', '88', '2', '白俊遥', '', '', 'k2232R1tBYJ232XJQelszNuV2tlzgsdj9m8A6JtRJXMtM2tfOffQP3U0qNG5zL2qnw9Envm4TqeJtIbMjwAZYMaLjnXw==', '1457693930', '1457693930');

-- ----------------------------
-- Table structure for bjyadmin_order
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_order`;
CREATE TABLE `bjyadmin_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单主键',
  `order_sn` int(11) unsigned NOT NULL COMMENT '订单号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bjyadmin_order
-- ----------------------------

-- ----------------------------
-- Table structure for bjyadmin_province_city_area
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_province_city_area`;
CREATE TABLE `bjyadmin_province_city_area` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` varchar(25) NOT NULL DEFAULT '' COMMENT '城市名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3511 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bjyadmin_province_city_area
-- ----------------------------
INSERT INTO `bjyadmin_province_city_area` VALUES ('1', '0', '北京');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2', '1', '北京市辖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3', '2', '东城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('4', '2', '西城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('5', '2', '崇文区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('6', '2', '宣武区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('7', '2', '朝阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('8', '2', '丰台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('9', '2', '石景山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('10', '2', '海淀区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('11', '2', '门头沟区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('12', '2', '房山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('13', '2', '通州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('14', '2', '顺义区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('15', '2', '昌平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('16', '1', '北京县辖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('17', '16', '大兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('18', '16', '平谷县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('19', '16', '怀柔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('20', '16', '密云县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('21', '16', '延庆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('22', '0', '天津');
INSERT INTO `bjyadmin_province_city_area` VALUES ('23', '22', '天津市辖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('24', '23', '和平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('25', '23', '河东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('26', '23', '河西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('27', '23', '南开区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('28', '23', '河北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('29', '23', '红桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('30', '23', '塘沽区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('31', '23', '汉沽区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('32', '23', '大港区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('33', '23', '东丽区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('34', '23', '西青区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('35', '23', '津南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('36', '23', '北辰区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('37', '23', '武清区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('38', '22', '天津县辖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('39', '38', '宁河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('40', '38', '静海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('41', '38', '宝坻县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('42', '38', '蓟  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('43', '0', '河北');
INSERT INTO `bjyadmin_province_city_area` VALUES ('44', '43', '石家庄');
INSERT INTO `bjyadmin_province_city_area` VALUES ('45', '44', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('46', '44', '长安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('47', '44', '桥东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('48', '44', '桥西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('49', '44', '新华区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('50', '44', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('51', '44', '井陉矿区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('52', '44', '井陉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('53', '44', '正定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('54', '44', '栾城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('55', '44', '行唐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('56', '44', '灵寿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('57', '44', '高邑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('58', '44', '深泽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('59', '44', '赞皇县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('60', '44', '无极县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('61', '44', '平山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('62', '44', '元氏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('63', '44', '赵  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('64', '44', '辛集市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('65', '44', '藁城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('66', '44', '晋州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('67', '44', '新乐市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('68', '44', '鹿泉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('69', '43', '唐山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('70', '69', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('71', '69', '路南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('72', '69', '路北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('73', '69', '古冶区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('74', '69', '开平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('75', '69', '新  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('76', '69', '丰润县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('77', '69', '滦  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('78', '69', '滦南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('79', '69', '乐亭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('80', '69', '迁西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('81', '69', '玉田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('82', '69', '唐海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('83', '69', '遵化市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('84', '69', '丰南市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('85', '69', '迁安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('86', '43', '秦皇岛');
INSERT INTO `bjyadmin_province_city_area` VALUES ('87', '86', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('88', '86', '海港区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('89', '86', '山海关区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('90', '86', '北戴河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('91', '86', '青龙满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('92', '86', '昌黎县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('93', '86', '抚宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('94', '86', '卢龙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('95', '43', '邯郸');
INSERT INTO `bjyadmin_province_city_area` VALUES ('96', '95', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('97', '95', '邯山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('98', '95', '丛台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('99', '95', '复兴区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('100', '95', '峰峰矿区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('101', '95', '邯郸县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('102', '95', '临漳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('103', '95', '成安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('104', '95', '大名县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('105', '95', '涉  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('106', '95', '磁  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('107', '95', '肥乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('108', '95', '永年县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('109', '95', '邱  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('110', '95', '鸡泽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('111', '95', '广平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('112', '95', '馆陶县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('113', '95', '魏  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('114', '95', '曲周县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('115', '95', '武安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('116', '43', '邢台');
INSERT INTO `bjyadmin_province_city_area` VALUES ('117', '116', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('118', '116', '桥东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('119', '116', '桥西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('120', '116', '邢台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('121', '116', '临城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('122', '116', '内丘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('123', '116', '柏乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('124', '116', '隆尧县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('125', '116', '任  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('126', '116', '南和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('127', '116', '宁晋县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('128', '116', '巨鹿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('129', '116', '新河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('130', '116', '广宗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('131', '116', '平乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('132', '116', '威  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('133', '116', '清河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('134', '116', '临西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('135', '116', '南宫市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('136', '116', '沙河市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('137', '43', '保定');
INSERT INTO `bjyadmin_province_city_area` VALUES ('138', '137', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('139', '137', '新市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('140', '137', '北市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('141', '137', '南市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('142', '137', '满城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('143', '137', '清苑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('144', '137', '涞水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('145', '137', '阜平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('146', '137', '徐水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('147', '137', '定兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('148', '137', '唐  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('149', '137', '高阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('150', '137', '容城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('151', '137', '涞源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('152', '137', '望都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('153', '137', '安新县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('154', '137', '易  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('155', '137', '曲阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('156', '137', '蠡  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('157', '137', '顺平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('158', '137', '博野县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('159', '137', '雄  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('160', '137', '涿州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('161', '137', '定州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('162', '137', '安国市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('163', '137', '高碑店市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('164', '43', '张家口');
INSERT INTO `bjyadmin_province_city_area` VALUES ('165', '164', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('166', '164', '桥东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('167', '164', '桥西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('168', '164', '宣化区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('169', '164', '下花园区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('170', '164', '宣化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('171', '164', '张北县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('172', '164', '康保县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('173', '164', '沽源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('174', '164', '尚义县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('175', '164', '蔚  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('176', '164', '阳原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('177', '164', '怀安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('178', '164', '万全县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('179', '164', '怀来县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('180', '164', '涿鹿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('181', '164', '赤城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('182', '164', '崇礼县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('183', '43', '承德');
INSERT INTO `bjyadmin_province_city_area` VALUES ('184', '183', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('185', '183', '双桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('186', '183', '双滦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('187', '183', '鹰手营子矿区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('188', '183', '承德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('189', '183', '兴隆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('190', '183', '平泉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('191', '183', '滦平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('192', '183', '隆化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('193', '183', '丰宁满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('194', '183', '宽城满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('196', '43', '沧州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('197', '196', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('198', '196', '新华区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('199', '196', '运河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('200', '196', '沧  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('201', '196', '青  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('202', '196', '东光县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('203', '196', '海兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('204', '196', '盐山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('205', '196', '肃宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('206', '196', '南皮县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('207', '196', '吴桥县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('208', '196', '献  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('209', '196', '孟村回族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('210', '196', '泊头市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('211', '196', '任丘市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('212', '196', '黄骅市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('213', '196', '河间市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('214', '43', '廊坊');
INSERT INTO `bjyadmin_province_city_area` VALUES ('215', '214', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('216', '214', '安次区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('217', '214', '廊坊市广阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('218', '214', '固安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('219', '214', '永清县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('220', '214', '香河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('221', '214', '大城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('222', '214', '文安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('223', '214', '大厂回族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('224', '214', '霸州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('225', '214', '三河市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('226', '43', '衡水');
INSERT INTO `bjyadmin_province_city_area` VALUES ('227', '226', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('228', '226', '桃城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('229', '226', '枣强县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('230', '226', '武邑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('231', '226', '武强县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('232', '226', '饶阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('233', '226', '安平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('234', '226', '故城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('235', '226', '景  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('236', '226', '阜城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('237', '226', '冀州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('238', '226', '深州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('239', '0', '山西');
INSERT INTO `bjyadmin_province_city_area` VALUES ('240', '239', '太原');
INSERT INTO `bjyadmin_province_city_area` VALUES ('241', '240', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('242', '240', '小店区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('243', '240', '迎泽区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('244', '240', '杏花岭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('245', '240', '尖草坪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('246', '240', '万柏林区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('247', '240', '晋源区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('248', '240', '清徐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('249', '240', '阳曲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('250', '240', '娄烦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('251', '240', '古交市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('252', '239', '大同');
INSERT INTO `bjyadmin_province_city_area` VALUES ('253', '252', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('254', '252', '城  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('255', '252', '矿  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('256', '252', '南郊区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('257', '252', '新荣区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('258', '252', '阳高县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('259', '252', '天镇县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('260', '252', '广灵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('261', '252', '灵丘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('262', '252', '浑源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('263', '252', '左云县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('264', '252', '大同县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('265', '239', '阳泉');
INSERT INTO `bjyadmin_province_city_area` VALUES ('266', '265', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('267', '265', '城  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('268', '265', '矿  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('269', '265', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('270', '265', '平定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('271', '265', '盂  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('272', '239', '长治');
INSERT INTO `bjyadmin_province_city_area` VALUES ('273', '272', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('274', '272', '城  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('275', '272', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('276', '272', '长治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('277', '272', '襄垣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('278', '272', '屯留县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('279', '272', '平顺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('280', '272', '黎城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('281', '272', '壶关县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('282', '272', '长子县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('283', '272', '武乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('284', '272', '沁  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('285', '272', '沁源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('286', '272', '潞城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('287', '239', '晋城');
INSERT INTO `bjyadmin_province_city_area` VALUES ('288', '287', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('289', '287', '城  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('290', '287', '沁水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('291', '287', '阳城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('292', '287', '陵川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('293', '287', '泽州县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('294', '287', '高平市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('295', '239', '朔州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('296', '295', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('297', '295', '朔城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('298', '295', '平鲁区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('299', '295', '山阴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('300', '295', '应  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('301', '295', '右玉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('302', '295', '怀仁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('303', '239', '晋中');
INSERT INTO `bjyadmin_province_city_area` VALUES ('304', '303', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('305', '303', '榆次区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('306', '303', '榆社县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('307', '303', '左权县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('308', '303', '和顺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('309', '303', '昔阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('310', '303', '寿阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('311', '303', '太谷县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('312', '303', '祁  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('313', '303', '平遥县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('314', '303', '灵石县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('315', '303', '介休市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('316', '239', '运城');
INSERT INTO `bjyadmin_province_city_area` VALUES ('317', '316', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('318', '316', '盐湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('319', '316', '临猗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('320', '316', '万荣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('321', '316', '闻喜县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('322', '316', '稷山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('323', '316', '新绛县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('324', '316', '绛  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('325', '316', '垣曲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('326', '316', '夏  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('327', '316', '平陆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('328', '316', '芮城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('329', '316', '永济市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('330', '316', '河津市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('331', '239', '忻州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('332', '331', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('333', '331', '忻府区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('334', '331', '定襄县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('335', '331', '五台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('336', '331', '代  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('337', '331', '繁峙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('338', '331', '宁武县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('339', '331', '静乐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('340', '331', '神池县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('341', '331', '五寨县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('342', '331', '岢岚县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('343', '331', '河曲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('344', '331', '保德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('345', '331', '偏关县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('346', '331', '原平市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('347', '239', '临汾');
INSERT INTO `bjyadmin_province_city_area` VALUES ('348', '347', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('349', '347', '尧都区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('350', '347', '曲沃县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('351', '347', '翼城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('352', '347', '襄汾县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('353', '347', '洪洞县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('354', '347', '古  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('355', '347', '安泽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('356', '347', '浮山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('357', '347', '吉  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('358', '347', '乡宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('359', '347', '大宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('360', '347', '隰  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('361', '347', '永和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('362', '347', '蒲  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('363', '347', '汾西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('364', '347', '侯马市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('365', '347', '霍州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('366', '239', '吕梁地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('367', '366', '孝义市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('368', '366', '离石市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('369', '366', '汾阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('370', '366', '文水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('371', '366', '交城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('372', '366', '兴  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('373', '366', '临  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('374', '366', '柳林县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('375', '366', '石楼县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('376', '366', '岚  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('377', '366', '方山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('378', '366', '中阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('379', '366', '交口县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('380', '0', '内蒙古');
INSERT INTO `bjyadmin_province_city_area` VALUES ('381', '380', '呼和浩特');
INSERT INTO `bjyadmin_province_city_area` VALUES ('382', '381', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('383', '381', '新城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('384', '381', '回民区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('385', '381', '玉泉区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('386', '381', '赛罕区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('387', '381', '土默特左旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('388', '381', '托克托县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('389', '381', '和林格尔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('390', '381', '清水河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('391', '381', '武川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('392', '380', '包头');
INSERT INTO `bjyadmin_province_city_area` VALUES ('393', '392', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('394', '392', '东河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('395', '392', '昆都伦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('396', '392', '青山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('397', '392', '石拐区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('398', '392', '白云矿区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('399', '392', '九原区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('400', '392', '土默特右旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('401', '392', '固阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('403', '380', '乌海');
INSERT INTO `bjyadmin_province_city_area` VALUES ('404', '403', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('405', '403', '海勃湾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('406', '403', '海南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('407', '403', '乌达区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('408', '380', '赤峰');
INSERT INTO `bjyadmin_province_city_area` VALUES ('409', '408', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('410', '408', '红山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('411', '408', '元宝山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('412', '408', '松山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('413', '408', '阿鲁科尔沁旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('414', '408', '巴林左旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('415', '408', '巴林右旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('416', '408', '林西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('417', '408', '克什克腾旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('418', '408', '翁牛特旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('419', '408', '喀喇沁旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('420', '408', '宁城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('421', '408', '敖汉旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('422', '380', '通辽');
INSERT INTO `bjyadmin_province_city_area` VALUES ('423', '422', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('424', '422', '科尔沁区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('425', '422', '科尔沁左翼中旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('426', '422', '科尔沁左翼后旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('427', '422', '开鲁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('428', '422', '库伦旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('429', '422', '奈曼旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('430', '422', '扎鲁特旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('431', '422', '霍林郭勒市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('432', '380', '呼伦贝尔盟');
INSERT INTO `bjyadmin_province_city_area` VALUES ('433', '432', '海拉尔市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('434', '432', '满洲里市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('435', '432', '扎兰屯市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('436', '432', '牙克石市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('437', '432', '根河市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('438', '432', '额尔古纳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('439', '432', '阿荣旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('441', '432', '鄂伦春自治旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('442', '432', '鄂温克族自治旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('443', '432', '新巴尔虎右旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('444', '432', '新巴尔虎左旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('445', '432', '陈巴尔虎旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('446', '380', '兴安盟');
INSERT INTO `bjyadmin_province_city_area` VALUES ('447', '446', '乌兰浩特市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('448', '446', '阿尔山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('449', '446', '科尔沁右翼前旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('450', '446', '科尔沁右翼中旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('451', '446', '扎赉特旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('452', '446', '突泉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('453', '380', '锡林郭勒盟');
INSERT INTO `bjyadmin_province_city_area` VALUES ('454', '453', '二连浩特市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('455', '453', '锡林浩特市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('456', '453', '阿巴嘎旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('457', '453', '苏尼特左旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('458', '453', '苏尼特右旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('459', '453', '东乌珠穆沁旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('460', '453', '西乌珠穆沁旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('461', '453', '太仆寺旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('462', '453', '镶黄旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('463', '453', '正镶白旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('464', '453', '正蓝旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('465', '453', '多伦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('466', '380', '乌兰察布盟');
INSERT INTO `bjyadmin_province_city_area` VALUES ('467', '466', '集宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('468', '466', '丰镇市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('469', '466', '卓资县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('470', '466', '化德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('471', '466', '商都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('472', '466', '兴和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('473', '466', '凉城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('474', '466', '察哈尔右翼前旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('475', '466', '察哈尔右翼中旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('476', '466', '察哈尔右翼后旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('477', '466', '四子王旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('478', '380', '伊克昭盟');
INSERT INTO `bjyadmin_province_city_area` VALUES ('479', '478', '东胜市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('480', '478', '达拉特旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('481', '478', '准格尔旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('482', '478', '鄂托克前旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('483', '478', '鄂托克旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('484', '478', '杭锦旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('485', '478', '乌审旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('486', '478', '伊金霍洛旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('487', '380', '巴彦淖尔盟');
INSERT INTO `bjyadmin_province_city_area` VALUES ('488', '487', '临河市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('489', '487', '五原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('490', '487', '磴口县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('491', '487', '乌拉特前旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('492', '487', '乌拉特中旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('493', '487', '乌拉特后旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('494', '487', '杭锦后旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('495', '380', '阿拉善盟');
INSERT INTO `bjyadmin_province_city_area` VALUES ('496', '495', '阿拉善左旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('497', '495', '阿拉善右旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('498', '495', '额济纳旗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('499', '0', '辽宁');
INSERT INTO `bjyadmin_province_city_area` VALUES ('500', '499', '沈阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('501', '500', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('502', '500', '和平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('503', '500', '沈河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('504', '500', '大东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('505', '500', '皇姑区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('506', '500', '铁西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('507', '500', '苏家屯区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('508', '500', '东陵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('509', '500', '新城子区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('510', '500', '于洪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('511', '500', '辽中县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('512', '500', '康平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('513', '500', '法库县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('514', '500', '新民市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('515', '499', '大连');
INSERT INTO `bjyadmin_province_city_area` VALUES ('516', '515', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('517', '515', '中山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('518', '515', '西岗区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('519', '515', '沙河口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('520', '515', '甘井子区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('521', '515', '旅顺口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('522', '515', '金州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('523', '515', '长海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('524', '515', '瓦房店市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('525', '515', '普兰店市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('526', '515', '庄河市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('527', '499', '鞍山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('528', '527', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('529', '527', '铁东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('530', '527', '铁西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('531', '527', '立山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('532', '527', '千山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('533', '527', '台安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('534', '527', '岫岩满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('535', '527', '海城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('536', '499', '抚顺');
INSERT INTO `bjyadmin_province_city_area` VALUES ('537', '536', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('538', '536', '新抚区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('539', '536', '东洲区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('540', '536', '望花区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('541', '536', '顺城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('542', '536', '抚顺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('543', '536', '新宾满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('544', '536', '清原满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('545', '499', '本溪');
INSERT INTO `bjyadmin_province_city_area` VALUES ('546', '545', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('547', '545', '平山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('548', '545', '溪湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('549', '545', '明山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('550', '545', '南芬区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('551', '545', '本溪满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('552', '545', '桓仁满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('553', '499', '丹东');
INSERT INTO `bjyadmin_province_city_area` VALUES ('554', '553', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('555', '553', '元宝区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('556', '553', '振兴区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('557', '553', '振安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('558', '553', '宽甸满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('559', '553', '东港市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('560', '553', '凤城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('561', '499', '锦州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('562', '561', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('563', '561', '古塔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('564', '561', '凌河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('565', '561', '太和区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('566', '561', '黑山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('567', '561', '义  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('568', '561', '凌海市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('569', '561', '北宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('570', '499', '营口');
INSERT INTO `bjyadmin_province_city_area` VALUES ('571', '570', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('572', '570', '站前区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('573', '570', '西市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('574', '570', '鲅鱼圈区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('575', '570', '老边区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('576', '570', '盖州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('577', '570', '大石桥市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('578', '499', '阜新');
INSERT INTO `bjyadmin_province_city_area` VALUES ('579', '578', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('580', '578', '海州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('581', '578', '新邱区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('582', '578', '太平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('583', '578', '清河门区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('584', '578', '细河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('585', '578', '阜新蒙古族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('586', '578', '彰武县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('587', '499', '辽阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('588', '587', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('589', '587', '白塔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('590', '587', '文圣区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('591', '587', '宏伟区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('592', '587', '弓长岭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('593', '587', '太子河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('594', '587', '辽阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('595', '587', '灯塔市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('596', '499', '盘锦');
INSERT INTO `bjyadmin_province_city_area` VALUES ('597', '596', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('598', '596', '双台子区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('599', '596', '兴隆台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('600', '596', '大洼县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('601', '596', '盘山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('602', '499', '铁岭');
INSERT INTO `bjyadmin_province_city_area` VALUES ('603', '602', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('604', '602', '银州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('605', '602', '清河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('606', '602', '铁岭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('607', '602', '西丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('608', '602', '昌图县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('609', '602', '铁法市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('610', '602', '开原市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('611', '499', '朝阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('612', '611', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('613', '611', '双塔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('614', '611', '龙城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('615', '611', '朝阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('616', '611', '建平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('618', '611', '北票市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('619', '611', '凌源市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('620', '499', '葫芦岛');
INSERT INTO `bjyadmin_province_city_area` VALUES ('621', '620', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('622', '620', '连山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('623', '620', '龙港区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('624', '620', '南票区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('625', '620', '绥中县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('626', '620', '建昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('627', '620', '兴城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('628', '0', '吉林');
INSERT INTO `bjyadmin_province_city_area` VALUES ('629', '628', '长春');
INSERT INTO `bjyadmin_province_city_area` VALUES ('630', '629', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('631', '629', '南关区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('632', '629', '宽城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('633', '629', '朝阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('634', '629', '二道区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('635', '629', '绿园区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('636', '629', '双阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('637', '629', '农安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('638', '629', '九台市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('639', '629', '榆树市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('640', '629', '德惠市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('641', '628', '吉林');
INSERT INTO `bjyadmin_province_city_area` VALUES ('642', '641', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('643', '641', '昌邑区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('644', '641', '龙潭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('645', '641', '船营区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('646', '641', '丰满区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('647', '641', '永吉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('648', '641', '蛟河市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('649', '641', '桦甸市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('650', '641', '舒兰市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('651', '641', '磐石市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('652', '628', '四平');
INSERT INTO `bjyadmin_province_city_area` VALUES ('653', '652', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('654', '652', '铁西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('655', '652', '铁东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('656', '652', '梨树县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('657', '652', '伊通满族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('658', '652', '公主岭市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('659', '652', '双辽市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('660', '628', '辽源');
INSERT INTO `bjyadmin_province_city_area` VALUES ('661', '660', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('662', '660', '龙山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('663', '660', '西安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('664', '660', '东丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('665', '660', '东辽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('666', '628', '通化');
INSERT INTO `bjyadmin_province_city_area` VALUES ('667', '666', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('668', '666', '东昌区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('669', '666', '二道江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('670', '666', '通化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('671', '666', '辉南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('672', '666', '柳河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('673', '666', '梅河口市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('674', '666', '集安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('675', '628', '白山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('676', '675', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('677', '675', '八道江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('678', '675', '抚松县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('679', '675', '靖宇县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('680', '675', '长白朝鲜族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('681', '675', '江源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('682', '675', '临江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('683', '628', '松原');
INSERT INTO `bjyadmin_province_city_area` VALUES ('684', '683', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('685', '683', '宁江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('687', '683', '长岭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('688', '683', '乾安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('689', '683', '扶余县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('690', '628', '白城');
INSERT INTO `bjyadmin_province_city_area` VALUES ('691', '690', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('692', '690', '洮北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('693', '690', '镇赉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('694', '690', '通榆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('695', '690', '洮南市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('696', '690', '大安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('697', '628', '延边朝鲜族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('698', '697', '延吉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('699', '697', '图们市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('700', '697', '敦化市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('701', '697', '珲春市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('702', '697', '龙井市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('703', '697', '和龙市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('704', '697', '汪清县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('705', '697', '安图县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('706', '0', '黑龙江');
INSERT INTO `bjyadmin_province_city_area` VALUES ('707', '706', '哈尔滨');
INSERT INTO `bjyadmin_province_city_area` VALUES ('708', '707', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('709', '707', '道里区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('710', '707', '南岗区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('711', '707', '道外区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('712', '707', '太平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('713', '707', '香坊区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('714', '707', '动力区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('715', '707', '平房区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('716', '707', '呼兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('717', '707', '依兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('718', '707', '方正县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('719', '707', '宾  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('720', '707', '巴彦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('721', '707', '木兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('722', '707', '通河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('723', '707', '延寿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('724', '707', '阿城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('725', '707', '双城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('726', '707', '尚志市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('727', '707', '五常市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('728', '706', '齐齐哈尔');
INSERT INTO `bjyadmin_province_city_area` VALUES ('729', '728', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('730', '728', '龙沙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('731', '728', '建华区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('732', '728', '铁锋区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('733', '728', '昂昂溪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('734', '728', '富拉尔基区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('735', '728', '碾子山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('736', '728', '梅里斯达斡尔族区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('737', '728', '龙江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('738', '728', '依安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('739', '728', '泰来县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('740', '728', '甘南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('741', '728', '富裕县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('742', '728', '克山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('743', '728', '克东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('744', '728', '拜泉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('745', '728', '讷河市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('746', '706', '鸡西');
INSERT INTO `bjyadmin_province_city_area` VALUES ('747', '746', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('748', '746', '鸡冠区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('749', '746', '恒山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('750', '746', '滴道区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('751', '746', '梨树区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('752', '746', '城子河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('753', '746', '麻山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('754', '746', '鸡东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('755', '746', '虎林市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('756', '746', '密山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('757', '706', '鹤岗');
INSERT INTO `bjyadmin_province_city_area` VALUES ('758', '757', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('759', '757', '向阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('760', '757', '工农区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('761', '757', '南山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('762', '757', '兴安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('763', '757', '东山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('764', '757', '兴山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('765', '757', '萝北县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('766', '757', '绥滨县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('767', '706', '双鸭山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('768', '767', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('769', '767', '尖山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('770', '767', '岭东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('771', '767', '四方台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('772', '767', '宝山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('773', '767', '集贤县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('774', '767', '友谊县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('775', '767', '宝清县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('776', '767', '饶河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('777', '706', '大庆');
INSERT INTO `bjyadmin_province_city_area` VALUES ('778', '777', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('779', '777', '萨尔图区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('780', '777', '龙凤区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('781', '777', '让胡路区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('782', '777', '红岗区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('783', '777', '大同区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('784', '777', '肇州县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('785', '777', '肇源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('786', '777', '林甸县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('788', '706', '伊春');
INSERT INTO `bjyadmin_province_city_area` VALUES ('789', '788', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('790', '788', '伊春区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('791', '788', '南岔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('792', '788', '友好区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('793', '788', '西林区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('794', '788', '翠峦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('795', '788', '新青区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('796', '788', '美溪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('797', '788', '金山屯区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('798', '788', '五营区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('799', '788', '乌马河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('800', '788', '汤旺河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('801', '788', '带岭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('802', '788', '乌伊岭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('803', '788', '红星区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('804', '788', '上甘岭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('805', '788', '嘉荫县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('806', '788', '铁力市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('807', '706', '佳木斯');
INSERT INTO `bjyadmin_province_city_area` VALUES ('808', '807', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('809', '807', '永红区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('810', '807', '向阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('811', '807', '前进区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('812', '807', '东风区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('813', '807', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('814', '807', '桦南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('815', '807', '桦川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('816', '807', '汤原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('817', '807', '抚远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('818', '807', '同江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('819', '807', '富锦市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('820', '706', '七台河');
INSERT INTO `bjyadmin_province_city_area` VALUES ('821', '820', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('822', '820', '新兴区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('823', '820', '桃山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('824', '820', '茄子河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('825', '820', '勃利县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('826', '706', '牡丹江');
INSERT INTO `bjyadmin_province_city_area` VALUES ('827', '826', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('828', '826', '东安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('829', '826', '阳明区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('830', '826', '爱民区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('831', '826', '西安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('832', '826', '东宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('833', '826', '林口县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('834', '826', '绥芬河市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('835', '826', '海林市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('836', '826', '宁安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('837', '826', '穆棱市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('838', '706', '黑河');
INSERT INTO `bjyadmin_province_city_area` VALUES ('839', '838', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('840', '838', '爱辉区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('841', '838', '嫩江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('842', '838', '逊克县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('843', '838', '孙吴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('844', '838', '北安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('845', '838', '五大连池市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('846', '706', '绥化');
INSERT INTO `bjyadmin_province_city_area` VALUES ('847', '846', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('848', '846', '北林区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('849', '846', '望奎县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('850', '846', '兰西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('851', '846', '青冈县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('852', '846', '庆安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('853', '846', '明水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('854', '846', '绥棱县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('855', '846', '安达市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('856', '846', '肇东市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('857', '846', '海伦市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('858', '706', '大兴安岭地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('859', '858', '呼玛县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('860', '858', '塔河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('861', '858', '漠河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('862', '0', '上海');
INSERT INTO `bjyadmin_province_city_area` VALUES ('863', '862', '上海市辖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('864', '863', '黄浦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('865', '863', '卢湾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('866', '863', '徐汇区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('867', '863', '长宁区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('868', '863', '静安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('869', '863', '普陀区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('870', '863', '闸北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('871', '863', '虹口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('872', '863', '杨浦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('873', '863', '闵行区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('874', '863', '宝山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('875', '863', '嘉定区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('876', '863', '浦东新区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('877', '863', '金山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('878', '863', '松江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('879', '863', '青浦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('880', '862', '上海县辖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('881', '880', '南汇县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('882', '880', '奉贤县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('883', '880', '崇明县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('884', '0', '江苏');
INSERT INTO `bjyadmin_province_city_area` VALUES ('885', '884', '南京');
INSERT INTO `bjyadmin_province_city_area` VALUES ('886', '885', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('887', '885', '玄武区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('888', '885', '白下区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('889', '885', '秦淮区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('890', '885', '建邺区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('891', '885', '鼓楼区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('892', '885', '下关区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('893', '885', '浦口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('894', '885', '大厂区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('895', '885', '栖霞区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('896', '885', '雨花台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('897', '885', '江宁区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('898', '885', '江浦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('899', '885', '六合县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('900', '885', '溧水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('901', '885', '高淳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('902', '884', '无锡');
INSERT INTO `bjyadmin_province_city_area` VALUES ('903', '902', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('904', '902', '崇安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('905', '902', '南长区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('906', '902', '北塘区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('907', '902', '锡山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('908', '902', '惠山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('909', '902', '滨湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('910', '902', '江阴市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('911', '902', '宜兴市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('912', '884', '徐州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('913', '912', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('914', '912', '鼓楼区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('915', '912', '云龙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('916', '912', '九里区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('917', '912', '贾汪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('918', '912', '泉山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('919', '912', '丰  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('920', '912', '沛  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('921', '912', '铜山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('922', '912', '睢宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('923', '912', '新沂市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('924', '912', '邳州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('925', '884', '常州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('926', '925', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('927', '925', '天宁区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('928', '925', '钟楼区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('929', '925', '戚墅堰区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('930', '925', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('931', '925', '溧阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('932', '925', '金坛市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('933', '925', '武进市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('934', '884', '苏州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('935', '934', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('936', '934', '沧浪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('937', '934', '平江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('938', '934', '金阊区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('939', '934', '虎丘区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('940', '934', '吴中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('941', '934', '相城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('942', '934', '常熟市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('943', '934', '张家港市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('944', '934', '昆山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('945', '934', '吴江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('946', '934', '太仓市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('947', '884', '南通');
INSERT INTO `bjyadmin_province_city_area` VALUES ('948', '947', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('949', '947', '崇川区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('950', '947', '港闸区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('951', '947', '海安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('952', '947', '如东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('953', '947', '启东市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('954', '947', '如皋市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('955', '947', '通州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('956', '947', '海门市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('957', '884', '连云港');
INSERT INTO `bjyadmin_province_city_area` VALUES ('958', '957', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('959', '957', '连云区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('960', '957', '云台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('961', '957', '新浦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('962', '957', '海州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('963', '957', '赣榆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('964', '957', '东海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('965', '957', '灌云县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('966', '957', '灌南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('967', '884', '淮安');
INSERT INTO `bjyadmin_province_city_area` VALUES ('968', '967', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('969', '967', '清河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('970', '967', '楚州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('971', '967', '淮阴区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('972', '967', '清浦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('973', '967', '涟水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('974', '967', '洪泽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('975', '967', '盱眙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('976', '967', '金湖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('977', '884', '盐城');
INSERT INTO `bjyadmin_province_city_area` VALUES ('978', '977', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('979', '977', '城  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('980', '977', '响水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('981', '977', '滨海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('982', '977', '阜宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('983', '977', '射阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('984', '977', '建湖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('985', '977', '盐都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('986', '977', '东台市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('987', '977', '大丰市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('988', '884', '扬州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('989', '988', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('990', '988', '广陵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('991', '988', '邗江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('992', '988', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('993', '988', '宝应县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('994', '988', '仪征市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('995', '988', '高邮市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('996', '988', '江都市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('997', '884', '镇江');
INSERT INTO `bjyadmin_province_city_area` VALUES ('998', '997', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('999', '997', '京口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1000', '997', '润州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1001', '997', '丹徒县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1002', '997', '丹阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1003', '997', '扬中市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1004', '997', '句容市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1005', '884', '泰州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1006', '1005', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1007', '1005', '海陵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1008', '1005', '高港区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1009', '1005', '兴化市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1010', '1005', '靖江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1011', '1005', '泰兴市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1012', '1005', '姜堰市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1013', '884', '宿迁');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1014', '1013', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1015', '1013', '宿城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1016', '1013', '宿豫县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1017', '1013', '沭阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1018', '1013', '泗阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1019', '1013', '泗洪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1020', '0', '浙江');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1021', '1020', '杭州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1022', '1021', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1023', '1021', '上城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1024', '1021', '下城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1025', '1021', '江干区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1026', '1021', '拱墅区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1027', '1021', '西湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1028', '1021', '滨江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1029', '1021', '桐庐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1030', '1021', '淳安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1031', '1021', '萧山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1032', '1021', '建德市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1033', '1021', '富阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1034', '1021', '余杭市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1035', '1021', '临安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1036', '1020', '宁波');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1037', '1036', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1038', '1036', '海曙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1039', '1036', '江东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1040', '1036', '江北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1041', '1036', '北仑区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1042', '1036', '镇海区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1043', '1036', '象山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1044', '1036', '宁海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1045', '1036', '鄞  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1046', '1036', '余姚市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1047', '1036', '慈溪市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1048', '1036', '奉化市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1049', '1020', '温州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1050', '1049', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1051', '1049', '鹿城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1052', '1049', '龙湾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1053', '1049', '瓯海区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1054', '1049', '洞头县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1055', '1049', '永嘉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1056', '1049', '平阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1057', '1049', '苍南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1058', '1049', '文成县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1059', '1049', '泰顺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1060', '1049', '瑞安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1061', '1049', '乐清市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1062', '1020', '嘉兴');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1063', '1062', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1064', '1062', '秀城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1065', '1062', '秀洲区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1066', '1062', '嘉善县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1067', '1062', '海盐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1068', '1062', '海宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1069', '1062', '平湖市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1070', '1062', '桐乡市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1071', '1020', '湖州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1072', '1071', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1073', '1071', '德清县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1074', '1071', '长兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1075', '1071', '安吉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1076', '1020', '绍兴');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1077', '1076', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1078', '1076', '越城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1079', '1076', '绍兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1080', '1076', '新昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1081', '1076', '诸暨市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1082', '1076', '上虞市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1083', '1076', '嵊州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1084', '1020', '金华');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1085', '1084', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1086', '1084', '婺城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1087', '1084', '金东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1088', '1084', '武义县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1089', '1084', '浦江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1090', '1084', '磐安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1091', '1084', '兰溪市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1092', '1084', '义乌市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1093', '1084', '东阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1094', '1084', '永康市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1095', '1020', '衢州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1096', '1095', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1097', '1095', '柯城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1098', '1095', '衢  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1099', '1095', '常山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1100', '1095', '开化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1101', '1095', '龙游县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1102', '1095', '江山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1103', '1020', '舟山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1104', '1103', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1105', '1103', '定海区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1106', '1103', '普陀区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1107', '1103', '岱山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1108', '1103', '嵊泗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1109', '1020', '台州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1110', '1109', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1111', '1109', '椒江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1112', '1109', '黄岩区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1113', '1109', '路桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1114', '1109', '玉环县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1115', '1109', '三门县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1116', '1109', '天台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1117', '1109', '仙居县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1118', '1109', '温岭市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1119', '1109', '临海市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1120', '1020', '丽水');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1121', '1120', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1122', '1120', '莲都区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1123', '1120', '青田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1124', '1120', '缙云县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1125', '1120', '遂昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1126', '1120', '松阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1127', '1120', '云和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1128', '1120', '庆元县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1129', '1120', '景宁畲族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1130', '1120', '龙泉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1131', '0', '安徽');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1132', '1131', '合肥');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1133', '1132', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1134', '1132', '东市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1135', '1132', '中市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1136', '1132', '西市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1137', '1132', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1138', '1132', '长丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1139', '1132', '肥东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1140', '1132', '肥西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1141', '1131', '芜湖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1142', '1141', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1143', '1141', '镜湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1144', '1141', '马塘区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1145', '1141', '新芜区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1146', '1141', '鸠江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1147', '1141', '芜湖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1148', '1141', '繁昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1149', '1141', '南陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1150', '1131', '蚌埠');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1151', '1150', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1152', '1150', '东市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1153', '1150', '中市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1154', '1150', '西市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1155', '1150', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1156', '1150', '怀远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1157', '1150', '五河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1158', '1150', '固镇县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1159', '1131', '淮南');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1160', '1159', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1161', '1159', '大通区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1162', '1159', '田家庵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1163', '1159', '谢家集区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1164', '1159', '八公山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1165', '1159', '潘集区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1166', '1159', '凤台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1167', '1131', '马鞍山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1168', '1167', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1169', '1167', '金家庄区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1170', '1167', '花山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1171', '1167', '雨山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1172', '1167', '向山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1173', '1167', '当涂县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1174', '1131', '淮北');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1175', '1174', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1176', '1174', '杜集区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1177', '1174', '相山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1178', '1174', '烈山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1179', '1174', '濉溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1180', '1131', '铜陵');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1181', '1180', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1182', '1180', '铜官山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1183', '1180', '狮子山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1184', '1180', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1185', '1180', '铜陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1186', '1131', '安庆');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1187', '1186', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1188', '1186', '迎江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1189', '1186', '大观区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1190', '1186', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1191', '1186', '怀宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1192', '1186', '枞阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1193', '1186', '潜山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1194', '1186', '太湖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1195', '1186', '宿松县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1196', '1186', '望江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1197', '1186', '岳西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1198', '1186', '桐城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1199', '1131', '黄山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1200', '1199', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1201', '1199', '屯溪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1202', '1199', '黄山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1203', '1199', '徽州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1204', '1199', '歙  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1205', '1199', '休宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1206', '1199', '黟  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1207', '1199', '祁门县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1208', '1131', '滁州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1209', '1208', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1210', '1208', '琅琊区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1211', '1208', '南谯区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1212', '1208', '来安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1213', '1208', '全椒县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1214', '1208', '定远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1215', '1208', '凤阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1216', '1208', '天长市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1217', '1208', '明光市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1218', '1131', '阜阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1219', '1218', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1220', '1218', '颍州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1221', '1218', '颍东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1222', '1218', '颍泉区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1223', '1218', '临泉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1224', '1218', '太和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1225', '1218', '阜南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1226', '1218', '颍上县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1227', '1218', '界首市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1228', '1131', '宿州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1229', '1228', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1230', '1228', '墉桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1231', '1228', '砀山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1232', '1228', '萧  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1233', '1228', '灵璧县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1234', '1228', '泗  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1235', '1131', '巢湖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1236', '1235', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1237', '1235', '居巢区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1238', '1235', '庐江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1239', '1235', '无为县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1240', '1235', '含山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1241', '1235', '和  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1242', '1131', '六安');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1243', '1242', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1244', '1242', '金安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1245', '1242', '裕安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1246', '1242', '寿  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1247', '1242', '霍邱县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1248', '1242', '舒城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1249', '1242', '金寨县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1250', '1242', '霍山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1251', '1131', '亳州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1252', '1251', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1253', '1251', '谯城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1254', '1251', '涡阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1255', '1251', '蒙城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1256', '1251', '利辛县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1257', '1131', '池州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1258', '1257', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1259', '1257', '贵池区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1260', '1257', '东至县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1261', '1257', '石台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1262', '1257', '青阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1263', '1131', '宣城');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1264', '1263', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1265', '1263', '宣州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1266', '1263', '郎溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1267', '1263', '广德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1268', '1263', '泾  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1269', '1263', '绩溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1270', '1263', '旌德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1271', '1263', '宁国市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1272', '0', '福建');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1273', '1272', '福州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1274', '1273', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1275', '1273', '鼓楼区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1276', '1273', '台江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1277', '1273', '仓山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1278', '1273', '马尾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1279', '1273', '晋安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1280', '1273', '闽侯县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1281', '1273', '连江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1282', '1273', '罗源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1283', '1273', '闽清县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1284', '1273', '永泰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1285', '1273', '平潭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1286', '1273', '福清市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1287', '1273', '长乐市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1288', '1272', '厦门');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1289', '1288', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1290', '1288', '鼓浪屿区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1291', '1288', '思明区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1292', '1288', '开元区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1293', '1288', '杏林区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1294', '1288', '湖里区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1295', '1288', '集美区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1296', '1288', '同安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1297', '1272', '莆田');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1298', '1297', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1299', '1297', '城厢区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1300', '1297', '涵江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1301', '1297', '莆田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1302', '1297', '仙游县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1303', '1272', '三明');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1304', '1303', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1305', '1303', '梅列区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1306', '1303', '三元区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1307', '1303', '明溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1308', '1303', '清流县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1309', '1303', '宁化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1310', '1303', '大田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1311', '1303', '尤溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1312', '1303', '沙  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1313', '1303', '将乐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1314', '1303', '泰宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1315', '1303', '建宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1316', '1303', '永安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1317', '1272', '泉州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1318', '1317', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1319', '1317', '鲤城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1320', '1317', '丰泽区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1321', '1317', '洛江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1322', '1317', '泉港区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1323', '1317', '惠安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1324', '1317', '安溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1325', '1317', '永春县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1326', '1317', '德化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1327', '1317', '金门县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1328', '1317', '石狮市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1329', '1317', '晋江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1330', '1317', '南安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1331', '1272', '漳州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1332', '1331', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1333', '1331', '芗城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1334', '1331', '龙文区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1335', '1331', '云霄县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1336', '1331', '漳浦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1337', '1331', '诏安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1338', '1331', '长泰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1339', '1331', '东山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1340', '1331', '南靖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1341', '1331', '平和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1342', '1331', '华安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1343', '1331', '龙海市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1344', '1272', '南平');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1345', '1344', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1346', '1344', '延平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1347', '1344', '顺昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1348', '1344', '浦城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1349', '1344', '光泽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1350', '1344', '松溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1351', '1344', '政和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1352', '1344', '邵武市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1353', '1344', '武夷山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1354', '1344', '建瓯市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1355', '1344', '建阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1356', '1272', '龙岩');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1357', '1356', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1358', '1356', '新罗区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1359', '1356', '长汀县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1360', '1356', '永定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1361', '1356', '上杭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1362', '1356', '武平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1363', '1356', '连城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1364', '1356', '漳平市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1365', '1272', '宁德');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1366', '1365', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1367', '1365', '蕉城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1368', '1365', '霞浦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1369', '1365', '古田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1370', '1365', '屏南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1371', '1365', '寿宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1372', '1365', '周宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1373', '1365', '柘荣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1374', '1365', '福安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1375', '1365', '福鼎市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1376', '0', '江西');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1377', '1376', '南昌');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1378', '1377', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1379', '1377', '东湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1380', '1377', '西湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1381', '1377', '青云谱区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1382', '1377', '湾里区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1383', '1377', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1384', '1377', '南昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1385', '1377', '新建县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1386', '1377', '安义县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1387', '1377', '进贤县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1388', '1376', '景德镇');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1389', '1388', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1390', '1388', '昌江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1391', '1388', '珠山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1392', '1388', '浮梁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1393', '1388', '乐平市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1394', '1376', '萍乡');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1395', '1394', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1396', '1394', '安源区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1397', '1394', '湘东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1398', '1394', '莲花县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1399', '1394', '上栗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1400', '1394', '芦溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1401', '1376', '九江');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1402', '1401', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1403', '1401', '庐山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1404', '1401', '浔阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1405', '1401', '九江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1406', '1401', '武宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1407', '1401', '修水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1408', '1401', '永修县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1409', '1401', '德安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1410', '1401', '星子县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1411', '1401', '都昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1412', '1401', '湖口县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1413', '1401', '彭泽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1414', '1401', '瑞昌市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1415', '1376', '新余');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1416', '1415', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1417', '1415', '渝水区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1418', '1415', '分宜县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1419', '1376', '鹰潭');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1420', '1419', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1421', '1419', '月湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1422', '1419', '余江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1423', '1419', '贵溪市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1424', '1376', '赣州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1425', '1424', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1426', '1424', '章贡区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1427', '1424', '赣  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1428', '1424', '信丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1429', '1424', '大余县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1430', '1424', '上犹县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1431', '1424', '崇义县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1432', '1424', '安远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1433', '1424', '龙南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1434', '1424', '定南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1435', '1424', '全南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1436', '1424', '宁都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1437', '1424', '于都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1438', '1424', '兴国县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1439', '1424', '会昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1440', '1424', '寻乌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1441', '1424', '石城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1442', '1424', '瑞金市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1443', '1424', '南康市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1444', '1376', '吉安');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1445', '1444', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1446', '1444', '吉州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1447', '1444', '青原区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1448', '1444', '吉安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1449', '1444', '吉水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1450', '1444', '峡江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1451', '1444', '新干县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1452', '1444', '永丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1453', '1444', '泰和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1454', '1444', '遂川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1455', '1444', '万安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1456', '1444', '安福县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1457', '1444', '永新县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1458', '1444', '井冈山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1459', '1376', '宜春');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1460', '1459', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1461', '1459', '袁州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1462', '1459', '奉新县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1463', '1459', '万载县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1464', '1459', '上高县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1465', '1459', '宜丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1466', '1459', '靖安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1467', '1459', '铜鼓县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1468', '1459', '丰城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1469', '1459', '樟树市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1470', '1459', '高安市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1471', '1376', '抚州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1472', '1471', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1473', '1471', '临川区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1474', '1471', '南城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1475', '1471', '黎川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1476', '1471', '南丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1477', '1471', '崇仁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1478', '1471', '乐安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1479', '1471', '宜黄县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1480', '1471', '金溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1481', '1471', '资溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1482', '1471', '东乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1483', '1471', '广昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1484', '1376', '上饶');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1485', '1484', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1486', '1484', '信州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1487', '1484', '上饶县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1488', '1484', '广丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1489', '1484', '玉山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1490', '1484', '铅山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1491', '1484', '横峰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1492', '1484', '弋阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1493', '1484', '余干县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1494', '1484', '波阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1495', '1484', '万年县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1496', '1484', '婺源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1497', '1484', '德兴市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1498', '0', '山东');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1499', '1498', '济南');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1500', '1499', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1501', '1499', '历下区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1502', '1499', '市中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1503', '1499', '槐荫区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1504', '1499', '天桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1505', '1499', '历城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1506', '1499', '长清县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1507', '1499', '平阴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1508', '1499', '济阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1509', '1499', '商河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1510', '1499', '章丘市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1511', '1498', '青岛');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1512', '1511', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1513', '1511', '市南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1514', '1511', '市北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1515', '1511', '四方区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1516', '1511', '黄岛区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1517', '1511', '崂山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1518', '1511', '李沧区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1519', '1511', '城阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1520', '1511', '胶州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1521', '1511', '即墨市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1522', '1511', '平度市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1523', '1511', '胶南市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1524', '1511', '莱西市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1525', '1498', '淄博');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1526', '1525', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1527', '1525', '淄川区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1528', '1525', '张店区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1529', '1525', '博山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1530', '1525', '临淄区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1531', '1525', '周村区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1532', '1525', '桓台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1533', '1525', '高青县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1534', '1525', '沂源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1535', '1498', '枣庄');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1536', '1535', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1537', '1535', '市中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1538', '1535', '薛城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1539', '1535', '峄城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1540', '1535', '台儿庄区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1541', '1535', '山亭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1542', '1535', '滕州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1543', '1498', '东营');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1544', '1543', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1545', '1543', '东营区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1546', '1543', '河口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1547', '1543', '垦利县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1548', '1543', '利津县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1549', '1543', '广饶县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1550', '1498', '烟台');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1551', '1550', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1552', '1550', '芝罘区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1553', '1550', '福山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1554', '1550', '牟平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1555', '1550', '莱山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1556', '1550', '长岛县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1557', '1550', '龙口市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1558', '1550', '莱阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1559', '1550', '莱州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1560', '1550', '蓬莱市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1561', '1550', '招远市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1562', '1550', '栖霞市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1563', '1550', '海阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1564', '1498', '潍坊');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1565', '1564', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1566', '1564', '潍城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1567', '1564', '寒亭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1568', '1564', '坊子区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1569', '1564', '奎文区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1570', '1564', '临朐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1571', '1564', '昌乐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1572', '1564', '青州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1573', '1564', '诸城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1574', '1564', '寿光市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1575', '1564', '安丘市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1576', '1564', '高密市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1577', '1564', '昌邑市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1578', '1498', '济宁');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1579', '1578', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1580', '1578', '市中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1581', '1578', '任城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1582', '1578', '微山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1583', '1578', '鱼台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1584', '1578', '金乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1585', '1578', '嘉祥县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1586', '1578', '汶上县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1587', '1578', '泗水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1588', '1578', '梁山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1589', '1578', '曲阜市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1590', '1578', '兖州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1591', '1578', '邹城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1592', '1498', '泰安');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1593', '1592', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1594', '1592', '泰山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1595', '1592', '岱岳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1596', '1592', '宁阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1597', '1592', '东平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1598', '1592', '新泰市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1599', '1592', '肥城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1600', '1498', '威海');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1601', '1600', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1602', '1600', '环翠区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1603', '1600', '文登市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1604', '1600', '荣成市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1605', '1600', '乳山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1606', '1498', '日照');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1607', '1606', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1608', '1606', '东港区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1609', '1606', '五莲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1610', '1606', '莒  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1611', '1498', '莱芜');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1612', '1611', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1613', '1611', '莱城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1614', '1611', '钢城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1615', '1498', '临沂');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1616', '1615', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1617', '1615', '兰山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1618', '1615', '罗庄区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1619', '1615', '河东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1620', '1615', '沂南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1621', '1615', '郯城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1622', '1615', '沂水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1623', '1615', '苍山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1624', '1615', '费  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1625', '1615', '平邑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1626', '1615', '莒南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1627', '1615', '蒙阴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1628', '1615', '临沭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1629', '1498', '德州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1630', '1629', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1631', '1629', '德城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1632', '1629', '陵  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1633', '1629', '宁津县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1634', '1629', '庆云县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1635', '1629', '临邑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1636', '1629', '齐河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1637', '1629', '平原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1638', '1629', '夏津县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1639', '1629', '武城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1640', '1629', '乐陵市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1641', '1629', '禹城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1642', '1498', '聊城');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1643', '1642', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1644', '1642', '东昌府区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1645', '1642', '阳谷县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1646', '1642', '莘  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1647', '1642', '茌平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1648', '1642', '东阿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1649', '1642', '冠  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1650', '1642', '高唐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1651', '1642', '临清市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1652', '1498', '滨州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1653', '1652', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1654', '1652', '滨城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1655', '1652', '惠民县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1656', '1652', '阳信县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1657', '1652', '无棣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1658', '1652', '沾化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1659', '1652', '博兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1660', '1652', '邹平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1661', '1498', '菏泽');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1662', '1661', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1663', '1661', '牡丹区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1664', '1661', '曹  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1665', '1661', '单  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1666', '1661', '成武县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1667', '1661', '巨野县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1668', '1661', '郓城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1669', '1661', '鄄城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1670', '1661', '定陶县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1671', '1661', '东明县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1672', '0', '河南');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1673', '1672', '郑州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1674', '1673', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1675', '1673', '中原区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1676', '1673', '二七区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1677', '1673', '管城回族区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1678', '1673', '金水区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1679', '1673', '上街区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1680', '1673', '邙山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1681', '1673', '中牟县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1682', '1673', '巩义市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1683', '1673', '荥阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1684', '1673', '新密市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1685', '1673', '新郑市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1686', '1673', '登封市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1687', '1672', '开封');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1688', '1687', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1689', '1687', '龙亭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1690', '1687', '顺河回族区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1691', '1687', '鼓楼区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1692', '1687', '南关区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1693', '1687', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1694', '1687', '杞  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1695', '1687', '通许县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1696', '1687', '尉氏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1697', '1687', '开封县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1698', '1687', '兰考县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1699', '1672', '洛阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1700', '1699', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1701', '1699', '老城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1702', '1699', '西工区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1703', '1699', '廛河回族区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1704', '1699', '涧西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1705', '1699', '吉利区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1706', '1699', '洛龙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1707', '1699', '孟津县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1708', '1699', '新安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1709', '1699', '栾川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1710', '1699', '嵩  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1711', '1699', '汝阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1712', '1699', '宜阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1713', '1699', '洛宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1714', '1699', '伊川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1715', '1699', '偃师市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1716', '1672', '平顶山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1717', '1716', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1718', '1716', '新华区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1719', '1716', '卫东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1720', '1716', '石龙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1721', '1716', '湛河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1722', '1716', '宝丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1723', '1716', '叶  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1724', '1716', '鲁山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1725', '1716', '郏  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1726', '1716', '舞钢市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1727', '1716', '汝州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1728', '1672', '安阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1729', '1728', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1730', '1728', '文峰区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1731', '1728', '北关区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1732', '1728', '铁西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1733', '1728', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1734', '1728', '安阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1735', '1728', '汤阴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1736', '1728', '滑  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1737', '1728', '内黄县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1738', '1728', '林州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1739', '1672', '鹤壁');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1740', '1739', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1741', '1739', '鹤山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1742', '1739', '山城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1743', '1739', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1744', '1739', '浚  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1745', '1739', '淇  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1746', '1672', '新乡');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1747', '1746', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1748', '1746', '红旗区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1749', '1746', '新华区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1750', '1746', '北站区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1751', '1746', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1752', '1746', '新乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1753', '1746', '获嘉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1754', '1746', '原阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1755', '1746', '延津县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1756', '1746', '封丘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1757', '1746', '长垣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1758', '1746', '卫辉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1759', '1746', '辉县市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1760', '1672', '焦作');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1761', '1760', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1762', '1760', '解放区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1763', '1760', '中站区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1764', '1760', '马村区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1765', '1760', '山阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1766', '1760', '修武县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1767', '1760', '博爱县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1768', '1760', '武陟县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1769', '1760', '温  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1770', '1760', '济源市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1771', '1760', '沁阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1772', '1760', '孟州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1773', '1672', '濮阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1774', '1773', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1775', '1773', '市  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1776', '1773', '清丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1777', '1773', '南乐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1778', '1773', '范  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1779', '1773', '台前县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1780', '1773', '濮阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1781', '1672', '许昌');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1782', '1781', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1783', '1781', '魏都区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1784', '1781', '许昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1785', '1781', '鄢陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1786', '1781', '襄城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1787', '1781', '禹州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1788', '1781', '长葛市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1789', '1672', '漯河');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1790', '1789', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1791', '1789', '源汇区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1792', '1789', '舞阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1793', '1789', '临颍县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1794', '1789', '郾城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1795', '1672', '三门峡');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1796', '1795', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1797', '1795', '湖滨区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1798', '1795', '渑池县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1799', '1795', '陕  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1800', '1795', '卢氏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1801', '1795', '义马市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1802', '1795', '灵宝市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1803', '1672', '南阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1804', '1803', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1805', '1803', '宛城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1806', '1803', '卧龙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1807', '1803', '南召县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1808', '1803', '方城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1809', '1803', '西峡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1810', '1803', '镇平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1811', '1803', '内乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1812', '1803', '淅川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1813', '1803', '社旗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1814', '1803', '唐河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1815', '1803', '新野县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1816', '1803', '桐柏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1817', '1803', '邓州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1818', '1672', '商丘');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1819', '1818', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1820', '1818', '梁园区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1821', '1818', '睢阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1822', '1818', '民权县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1823', '1818', '睢  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1824', '1818', '宁陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1825', '1818', '柘城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1826', '1818', '虞城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1827', '1818', '夏邑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1828', '1818', '永城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1829', '1672', '信阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1830', '1829', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1831', '1829', '师河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1832', '1829', '平桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1833', '1829', '罗山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1834', '1829', '光山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1835', '1829', '新  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1836', '1829', '商城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1837', '1829', '固始县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1838', '1829', '潢川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1839', '1829', '淮滨县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1840', '1829', '息  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1841', '1672', '周口');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1842', '1841', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1843', '1841', '川汇区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1844', '1841', '扶沟县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1845', '1841', '西华县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1846', '1841', '商水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1847', '1841', '沈丘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1848', '1841', '郸城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1849', '1841', '淮阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1850', '1841', '太康县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1851', '1841', '鹿邑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1852', '1841', '项城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1853', '1672', '驻马店');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1854', '1853', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1855', '1853', '驿城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1856', '1853', '西平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1857', '1853', '上蔡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1858', '1853', '平舆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1859', '1853', '正阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1860', '1853', '确山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1861', '1853', '泌阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1862', '1853', '汝南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1863', '1853', '遂平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1864', '1853', '新蔡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1865', '0', '湖北');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1866', '1865', '武汉');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1867', '1866', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1868', '1866', '江岸区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1869', '1866', '江汉区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1870', '1866', '乔口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1871', '1866', '汉阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1872', '1866', '武昌区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1873', '1866', '青山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1874', '1866', '洪山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1875', '1866', '东西湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1876', '1866', '汉南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1877', '1866', '蔡甸区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1878', '1866', '江夏区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1879', '1866', '黄陂区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1880', '1866', '新洲区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1881', '1865', '黄石');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1882', '1881', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1883', '1881', '黄石港区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1884', '1881', '石灰窑区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1885', '1881', '下陆区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1886', '1881', '铁山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1887', '1881', '阳新县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1888', '1881', '大冶市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1889', '1865', '十堰');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1890', '1889', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1891', '1889', '茅箭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1892', '1889', '张湾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1893', '1889', '郧  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1894', '1889', '郧西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1895', '1889', '竹山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1896', '1889', '竹溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1897', '1889', '房  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1898', '1889', '丹江口市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1899', '1865', '宜昌');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1900', '1899', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1901', '1899', '西陵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1902', '1899', '伍家岗区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1903', '1899', '点军区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1904', '1899', '虎亭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1905', '1899', '宜昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1906', '1899', '远安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1907', '1899', '兴山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1908', '1899', '秭归县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1909', '1899', '长阳土家族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1910', '1899', '五峰土家族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1911', '1899', '宜都市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1912', '1899', '当阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1913', '1899', '枝江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1914', '1865', '襄樊');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1915', '1914', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1916', '1914', '襄城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1917', '1914', '樊城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1918', '1914', '襄阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1919', '1914', '南漳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1920', '1914', '谷城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1921', '1914', '保康县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1922', '1914', '老河口市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1923', '1914', '枣阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1924', '1914', '宜城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1925', '1865', '鄂州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1926', '1925', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1927', '1925', '梁子湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1928', '1925', '华容区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1929', '1925', '鄂城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1930', '1865', '荆门');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1931', '1930', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1932', '1930', '东宝区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1933', '1930', '京山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1934', '1930', '沙洋县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1935', '1930', '钟祥市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1936', '1865', '孝感');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1937', '1936', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1938', '1936', '孝南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1939', '1936', '孝昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1940', '1936', '大悟县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1941', '1936', '云梦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1942', '1936', '应城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1943', '1936', '安陆市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1944', '1936', '汉川市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1945', '1865', '荆州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1946', '1945', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1947', '1945', '沙市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1948', '1945', '荆州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1949', '1945', '公安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1950', '1945', '监利县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1951', '1945', '江陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1952', '1945', '石首市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1953', '1945', '洪湖市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1954', '1945', '松滋市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1955', '1865', '黄冈');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1956', '1955', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1957', '1955', '黄州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1958', '1955', '团风县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1959', '1955', '红安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1960', '1955', '罗田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1961', '1955', '英山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1962', '1955', '浠水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1963', '1955', '蕲春县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1964', '1955', '黄梅县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1965', '1955', '麻城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1966', '1955', '武穴市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1967', '1865', '咸宁');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1968', '1967', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1969', '1967', '咸安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1970', '1967', '嘉鱼县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1971', '1967', '通城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1972', '1967', '崇阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1973', '1967', '通山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1974', '1967', '赤壁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1975', '1865', '随州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1976', '1975', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1977', '1975', '曾都区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1978', '1975', '广水市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1980', '1979', '恩施市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1981', '1979', '利川市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1982', '1979', '建始县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1983', '1979', '巴东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1984', '1979', '宣恩县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1985', '1979', '咸丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1986', '1979', '来凤县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1987', '1979', '鹤峰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1988', '1865', '省直辖行政单位');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1989', '1988', '仙桃市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1990', '1988', '潜江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1991', '1988', '天门市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1992', '1988', '神农架林区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1993', '0', '湖南');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1994', '1993', '长沙');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1995', '1994', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1996', '1994', '芙蓉区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1997', '1994', '天心区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1998', '1994', '岳麓区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('1999', '1994', '开福区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2000', '1994', '雨花区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2001', '1994', '长沙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2002', '1994', '望城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2003', '1994', '宁乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2004', '1994', '浏阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2005', '1993', '株洲');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2006', '2005', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2007', '2005', '荷塘区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2008', '2005', '芦淞区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2009', '2005', '石峰区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2010', '2005', '天元区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2011', '2005', '株洲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2012', '2005', '攸  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2013', '2005', '茶陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2014', '2005', '炎陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2015', '2005', '醴陵市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2016', '1993', '湘潭');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2017', '2016', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2018', '2016', '雨湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2019', '2016', '岳塘区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2020', '2016', '湘潭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2021', '2016', '湘乡市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2022', '2016', '韶山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2023', '1993', '衡阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2024', '2023', '市辖区');

-- ----------------------------
-- Table structure for bjyadmin_users
-- ----------------------------
DROP TABLE IF EXISTS `bjyadmin_users`;
CREATE TABLE `bjyadmin_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；mb_password加密',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像，相对于upload/avatar目录',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `email_code` varchar(60) DEFAULT NULL COMMENT '激活码',
  `phone` bigint(11) unsigned DEFAULT NULL COMMENT '手机号',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '用户状态 0：禁用； 1：正常 ；2：未验证',
  `register_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` int(10) unsigned NOT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bjyadmin_users
-- ----------------------------
INSERT INTO `bjyadmin_users` VALUES ('88', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '/Upload/avatar/user1.jpg', '', '', null, '1', '1449199996', '', '0');
INSERT INTO `bjyadmin_users` VALUES ('89', 'admin2', 'e10adc3949ba59abbe56e057f20f883e', '/Upload/avatar/user2.jpg', '', '', null, '1', '1449199996', '', '0');

-- ----------------------------
-- Table structure for tour_admin_access
-- ----------------------------
DROP TABLE IF EXISTS `tour_admin_access`;
CREATE TABLE `tour_admin_access` (
  `role_id` smallint(6) unsigned NOT NULL,
  `node_id` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) NOT NULL,
  `module` varchar(50) DEFAULT NULL,
  KEY `groupId` (`role_id`) USING BTREE,
  KEY `nodeId` (`node_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_admin_access
-- ----------------------------
INSERT INTO `tour_admin_access` VALUES ('1', '221', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '220', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '219', '2', null);
INSERT INTO `tour_admin_access` VALUES ('2', '220', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '219', '2', null);
INSERT INTO `tour_admin_access` VALUES ('1', '228', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '218', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '217', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '216', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '215', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '214', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '213', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '212', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '218', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '213', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '210', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '209', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '205', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '203', '2', null);
INSERT INTO `tour_admin_access` VALUES ('2', '191', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '211', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '210', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '209', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '207', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '206', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '205', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '203', '2', null);
INSERT INTO `tour_admin_access` VALUES ('1', '191', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '190', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '189', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '188', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '187', '2', null);
INSERT INTO `tour_admin_access` VALUES ('1', '192', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '179', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '178', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '177', '2', null);
INSERT INTO `tour_admin_access` VALUES ('1', '176', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '175', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '174', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '173', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '172', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '171', '2', null);
INSERT INTO `tour_admin_access` VALUES ('2', '190', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '189', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '188', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '187', '2', null);
INSERT INTO `tour_admin_access` VALUES ('2', '177', '2', null);
INSERT INTO `tour_admin_access` VALUES ('2', '176', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '175', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '174', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '173', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '172', '3', null);
INSERT INTO `tour_admin_access` VALUES ('2', '171', '2', null);
INSERT INTO `tour_admin_access` VALUES ('2', '166', '1', null);
INSERT INTO `tour_admin_access` VALUES ('1', '166', '1', null);

-- ----------------------------
-- Table structure for tour_admin_node
-- ----------------------------
DROP TABLE IF EXISTS `tour_admin_node`;
CREATE TABLE `tour_admin_node` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `remark` varchar(255) DEFAULT NULL,
  `sort` smallint(6) unsigned DEFAULT NULL,
  `pid` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `class` varchar(32) DEFAULT NULL,
  `menus` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `level` (`level`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=229 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_admin_node
-- ----------------------------
INSERT INTO `tour_admin_node` VALUES ('166', 'Home', '云数据后台', '1', null, null, '0', '1', null, '2');
INSERT INTO `tour_admin_node` VALUES ('219', 'System', '系统管理', '1', null, null, '166', '2', ' icon-cogs', '1');
INSERT INTO `tour_admin_node` VALUES ('171', 'File', '文件管理', '1', null, null, '166', '2', ' icon-folder-open', '1');
INSERT INTO `tour_admin_node` VALUES ('172', 'index', '列表', '0', null, null, '171', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('173', 'uploadFile', '文件上传', '1', null, null, '171', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('174', 'image', '图片', '1', null, null, '171', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('175', 'imageUpload', '图片上传', '1', null, null, '171', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('176', 'waterImage', '水印', '1', null, null, '171', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('177', 'Category', '分类管理', '1', null, null, '166', '2', 'icon-bar-chart', '1');
INSERT INTO `tour_admin_node` VALUES ('178', 'addCategory', '添加分类', '1', null, null, '177', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('179', 'checkCategory', '检查分类', '1', null, null, '177', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('223', 'createnode', 'createnode', '1', null, null, '166', '2', 'icon-calendar', '1');
INSERT INTO `tour_admin_node` VALUES ('225', 'createnode1', 'createnode', '1', null, null, '223', '3', 'icon-calendar', '1');
INSERT INTO `tour_admin_node` VALUES ('187', 'Product', '商品管理', '1', null, null, '166', '2', 'icon-gift', '1');
INSERT INTO `tour_admin_node` VALUES ('188', 'index', '添加', '1', null, null, '187', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('189', 'productList', '列表', '1', null, null, '187', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('190', 'UploadImage', '商品图片', '1', null, null, '187', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('191', 'delProduct', '删除商品', '1', null, null, '187', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('192', 'ajaxAdd', '添加分类', '1', null, null, '177', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('203', 'Rbac', '权限管理', '1', null, null, '166', '2', ' icon-group', '1');
INSERT INTO `tour_admin_node` VALUES ('220', 'index', '网站详情', '1', null, null, '219', '3', 'icon-calendar', '1');
INSERT INTO `tour_admin_node` VALUES ('221', 'edit', '网站设置', '1', null, null, '219', '3', 'icon-calendar', '0');
INSERT INTO `tour_admin_node` VALUES ('218', 'userIndex', '用户列表', '1', null, null, '203', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('205', 'createAdminUser', '添加用户', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('206', 'delUser', '删除用户', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('207', 'userStatus', '用户状态', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('209', 'nodeIndex', '节点列表', '1', null, null, '203', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('210', 'createNode', '新建节点', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('211', 'delNode', '删除节点', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('212', 'NodeStatus', '节点状态', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('213', 'roleIndex', '角色列表', '1', null, null, '203', '3', null, '1');
INSERT INTO `tour_admin_node` VALUES ('214', 'createAdminRole', '添加角色', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('215', 'addNode', '权限分配', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('216', 'delRole', '删除角色', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('217', 'roleStatus', '角色状态', '1', null, null, '203', '3', null, '0');
INSERT INTO `tour_admin_node` VALUES ('228', 'showMenus', '菜单栏显示', null, null, null, '203', '3', 'icon-calendar', '0');

-- ----------------------------
-- Table structure for tour_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `tour_admin_role`;
CREATE TABLE `tour_admin_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `pid` smallint(6) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT '1',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_admin_role
-- ----------------------------
INSERT INTO `tour_admin_role` VALUES ('1', '超级管理员', null, '1', '超级管理员超级管理员');
INSERT INTO `tour_admin_role` VALUES ('2', '管理员', null, '1', '管理员描述');
INSERT INTO `tour_admin_role` VALUES ('26', '系统基本信息', '0', '1', '系统基本信息');

-- ----------------------------
-- Table structure for tour_admin_role_user
-- ----------------------------
DROP TABLE IF EXISTS `tour_admin_role_user`;
CREATE TABLE `tour_admin_role_user` (
  `role_id` mediumint(9) unsigned DEFAULT NULL,
  `user_id` char(32) DEFAULT NULL,
  KEY `group_id` (`role_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_admin_role_user
-- ----------------------------
INSERT INTO `tour_admin_role_user` VALUES ('3', '72');
INSERT INTO `tour_admin_role_user` VALUES ('12', '73');
INSERT INTO `tour_admin_role_user` VALUES ('13', '74');
INSERT INTO `tour_admin_role_user` VALUES ('1', '86');
INSERT INTO `tour_admin_role_user` VALUES ('3', '69');
INSERT INTO `tour_admin_role_user` VALUES ('3', '70');
INSERT INTO `tour_admin_role_user` VALUES ('2', '71');
INSERT INTO `tour_admin_role_user` VALUES ('26', '165');
INSERT INTO `tour_admin_role_user` VALUES ('2', '110');
INSERT INTO `tour_admin_role_user` VALUES ('2', '111');
INSERT INTO `tour_admin_role_user` VALUES ('1', '112');
INSERT INTO `tour_admin_role_user` VALUES ('2', '113');
INSERT INTO `tour_admin_role_user` VALUES ('1', '114');
INSERT INTO `tour_admin_role_user` VALUES ('1', '146');
INSERT INTO `tour_admin_role_user` VALUES ('1', '163');
INSERT INTO `tour_admin_role_user` VALUES ('2', '164');
INSERT INTO `tour_admin_role_user` VALUES ('26', '155');
INSERT INTO `tour_admin_role_user` VALUES ('1', '160');
INSERT INTO `tour_admin_role_user` VALUES ('1', '161');
INSERT INTO `tour_admin_role_user` VALUES ('2', '162');

-- ----------------------------
-- Table structure for tour_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `tour_admin_user`;
CREATE TABLE `tour_admin_user` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL COMMENT '平台用户名',
  `password` varchar(60) DEFAULT NULL COMMENT '密码',
  `logintime` varchar(128) DEFAULT NULL COMMENT '登陆时间',
  `loginip` text COMMENT '登陆Ip地址',
  `status` int(2) DEFAULT '0' COMMENT '状态',
  `expire` int(32) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_admin_user
-- ----------------------------
INSERT INTO `tour_admin_user` VALUES ('86', 'admin', 'f85a836c2434e41638fe37b7ec992447', '1470401515', '115.205.238.94', '1', '0');
INSERT INTO `tour_admin_user` VALUES ('146', 'Tinywan', 'e10adc3949ba59abbe56e057f20f883e', '1471057757', '115.193.175.224', '1', '0');
INSERT INTO `tour_admin_user` VALUES ('155', 'admin123', '123123131', '1472051649', '127.0.0.1', '1', '0');
INSERT INTO `tour_admin_user` VALUES ('160', 'admin6', 'e10adc3949ba59abbe56e057f20f883e', '1472057821', '127.0.0.1', '0', '140');
INSERT INTO `tour_admin_user` VALUES ('161', 'admin888', 'e10adc3949ba59abbe56e057f20f883e', '1472744911', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('162', 'admin666', 'e10adc3949ba59abbe56e057f20f883e', '1472744669', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('163', 'admin110', 'e10adc3949ba59abbe56e057f20f883e', '1472693697', '127.0.0.1', '0', '10');
INSERT INTO `tour_admin_user` VALUES ('164', 'admin123789', 'e10adc3949ba59abbe56e057f20f883e', '1472733997', '127.0.0.1', '0', '10');
INSERT INTO `tour_admin_user` VALUES ('165', '管理人', 'e10adc3949ba59abbe56e057f20f883e', '1472744696', '127.0.0.1', '1', '10');

-- ----------------------------
-- Table structure for tour_category
-- ----------------------------
DROP TABLE IF EXISTS `tour_category`;
CREATE TABLE `tour_category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pid` int(10) NOT NULL,
  `path` varchar(255) NOT NULL,
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '级别',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `order` int(32) DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_category
-- ----------------------------
INSERT INTO `tour_category` VALUES ('1', '服装', '0', '0,1', '1', '1', null, null);
INSERT INTO `tour_category` VALUES ('2', '西服', '1', '0,1,2', '2', '1', null, null);
INSERT INTO `tour_category` VALUES ('3', '鞋子', '0', '0,3', '1', null, null, null);
INSERT INTO `tour_category` VALUES ('4', '皮鞋', '2', '0,3,4', '2', '1', null, null);
INSERT INTO `tour_category` VALUES ('5', '黑皮鞋', '4', '0,3,4,5', '3', '1', null, null);
INSERT INTO `tour_category` VALUES ('7', '西服测试', '2', '0,1,2', '2', null, null, null);
INSERT INTO `tour_category` VALUES ('14', '童装', '1', '0,1,14', '2', null, null, null);
INSERT INTO `tour_category` VALUES ('15', '凉鞋', '3', '0,3,15', '2', null, null, null);
INSERT INTO `tour_category` VALUES ('22', '童装衣服33', '14', '0,1,14,22', '3', '1', null, null);
INSERT INTO `tour_category` VALUES ('23', '服装分类33-33', '22', '0,1,14,22,23', '4', '1', null, null);

-- ----------------------------
-- Table structure for tour_download_log
-- ----------------------------
DROP TABLE IF EXISTS `tour_download_log`;
CREATE TABLE `tour_download_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` varchar(128) DEFAULT NULL COMMENT '下载软件版本id',
  `download_num` int(128) DEFAULT NULL,
  `download_time` varchar(128) DEFAULT '' COMMENT '下载日期',
  `download_user` varchar(128) DEFAULT NULL COMMENT '下载用户信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_download_log
-- ----------------------------
INSERT INTO `tour_download_log` VALUES ('231', '172', '0', '', null);
INSERT INTO `tour_download_log` VALUES ('232', '171', null, '1464492855', 'admin');
INSERT INTO `tour_download_log` VALUES ('233', '171', null, '1464492856', 'admin');
INSERT INTO `tour_download_log` VALUES ('234', '171', null, '1464492857', 'admin');
INSERT INTO `tour_download_log` VALUES ('235', '171', null, '1464492857', 'admin');
INSERT INTO `tour_download_log` VALUES ('236', '171', null, '1464492858', 'admin');
INSERT INTO `tour_download_log` VALUES ('237', '172', null, '1464492874', 'admin');
INSERT INTO `tour_download_log` VALUES ('238', '172', null, '1464492875', 'admin');
INSERT INTO `tour_download_log` VALUES ('239', '172', null, '1464492876', 'admin');

-- ----------------------------
-- Table structure for tour_file
-- ----------------------------
DROP TABLE IF EXISTS `tour_file`;
CREATE TABLE `tour_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL,
  `min_path` varchar(100) NOT NULL,
  `path` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_file
-- ----------------------------
INSERT INTO `tour_file` VALUES ('35', '1', 'Product/2016-08-17/mini_57b47810d7435.jpg', 'Product/2016-08-17/57b47810d7435.jpg');
INSERT INTO `tour_file` VALUES ('36', '1', 'Product/2016-08-17/mini_57b478cbf362c.jpg', 'Product/2016-08-17/57b478cbf362c.jpg');
INSERT INTO `tour_file` VALUES ('37', '1', 'Product/2016-08-17/mini_57b478f91ffcf.jpg', 'Product/2016-08-17/57b478f91ffcf.jpg');
INSERT INTO `tour_file` VALUES ('38', '1', 'Product/2016-08-17/mini_57b479456851c.jpg', 'Product/2016-08-17/57b479456851c.jpg');
INSERT INTO `tour_file` VALUES ('39', '1', 'Product/2016-08-17/mini_57b4795d8ba20.jpg', 'Product/2016-08-17/57b4795d8ba20.jpg');
INSERT INTO `tour_file` VALUES ('40', '1', 'Product/2016-08-17/mini_57b47a0768546.jpg', 'Product/2016-08-17/57b47a0768546.jpg');
INSERT INTO `tour_file` VALUES ('41', '1', 'Product/2016-08-17/mini_57b47ab41b150.jpg', 'Product/2016-08-17/57b47ab41b150.jpg');
INSERT INTO `tour_file` VALUES ('42', '1', 'Product/2016-08-17/mini_57b47accd74d7.jpg', 'Product/2016-08-17/57b47accd74d7.jpg');
INSERT INTO `tour_file` VALUES ('43', '1', 'Product/2016-08-17/mini_57b47aed0c88d.jpg', 'Product/2016-08-17/57b47aed0c88d.jpg');
INSERT INTO `tour_file` VALUES ('44', '1', 'Product/2016-08-17/mini_57b47d4098bb0.jpg', 'Product/2016-08-17/57b47d4098bb0.jpg');
INSERT INTO `tour_file` VALUES ('45', '1', 'Product/2016-08-17/mini_57b47d8417502.jpg', 'Product/2016-08-17/57b47d8417502.jpg');
INSERT INTO `tour_file` VALUES ('46', '1', 'Product/2016-08-17/mini_57b47da53d457.jpg', 'Product/2016-08-17/57b47da53d457.jpg');
INSERT INTO `tour_file` VALUES ('47', '1', 'Product/2016-08-17/mini_57b47e44692c1.jpg', 'Product/2016-08-17/57b47e44692c1.jpg');
INSERT INTO `tour_file` VALUES ('48', '1', 'Product/2016-08-17/mini_57b47e66538ae.jpg', 'Product/2016-08-17/57b47e66538ae.jpg');
INSERT INTO `tour_file` VALUES ('49', '1', 'Product/2016-08-17/mini_57b47eb99f333.jpg', 'Product/2016-08-17/57b47eb99f333.jpg');
INSERT INTO `tour_file` VALUES ('50', '1', 'Product/2016-08-17/mini_57b47ef511f6f.jpg', 'Product/2016-08-17/57b47ef511f6f.jpg');
INSERT INTO `tour_file` VALUES ('51', '1', 'Product/2016-08-17/mini_57b480cd2751b.jpg', 'Product/2016-08-17/57b480cd2751b.jpg');
INSERT INTO `tour_file` VALUES ('52', '1', 'Product/2016-08-17/mini_57b48115165eb.jpg', 'Product/2016-08-17/57b48115165eb.jpg');
INSERT INTO `tour_file` VALUES ('53', '1', 'Product/2016-08-17/mini_57b4816140045.jpg', 'Product/2016-08-17/57b4816140045.jpg');
INSERT INTO `tour_file` VALUES ('54', '2', 'Product/2016-08-17/mini_57b481b0b4196.jpg', 'Product/2016-08-17/57b481b0b4196.jpg');
INSERT INTO `tour_file` VALUES ('55', '1', 'Product/2016-08-17/mini_57b483c375905.jpg', 'Product/2016-08-17/57b483c375905.jpg');
INSERT INTO `tour_file` VALUES ('57', '26', 'Product/2016-08-17/mini_57b48493cdcfb.jpg', 'Product/2016-08-17/57b48493cdcfb.jpg');
INSERT INTO `tour_file` VALUES ('58', '29', 'Product/2016-08-17/mini_57b486725c59b.jpg', 'Product/2016-08-17/57b486725c59b.jpg');
INSERT INTO `tour_file` VALUES ('60', '35', 'Product/2016-08-20/mini_57b7f1b323690.jpg', 'Product/2016-08-20/57b7f1b323690.jpg');
INSERT INTO `tour_file` VALUES ('62', '1', 'Product/2016-08-20/mini_57b803956e123.jpg', 'Product/2016-08-20/57b803956e123.jpg');
INSERT INTO `tour_file` VALUES ('64', '1', 'Product/2016-08-20/mini_57b804d07ffea.jpg', 'Product/2016-08-20/57b804d07ffea.jpg');
INSERT INTO `tour_file` VALUES ('79', '53', 'Product/2016-08-21/mini_57b91be818c06.jpg', 'Product/2016-08-21/57b91be818c06.jpg');
INSERT INTO `tour_file` VALUES ('80', '1', 'Product/2016-08-21/mini_57b91c614af52.jpg', 'Product/2016-08-21/57b91c614af52.jpg');
INSERT INTO `tour_file` VALUES ('81', '54', 'Product/2016-08-21/mini_57b91db2c2528.jpg', 'Product/2016-08-21/57b91db2c2528.jpg');
INSERT INTO `tour_file` VALUES ('82', '55', 'Product/2016-08-21/mini_57b91e8f93f38.jpg', 'Product/2016-08-21/mini_57b91e8f93f38.jpg');
INSERT INTO `tour_file` VALUES ('83', '56', 'Product/2016-08-21/mini_57b9221439e69.jpg', 'Product/2016-08-21/mini_57b9221439e69.jpg');
INSERT INTO `tour_file` VALUES ('84', '59', 'Product/2016-08-21/mini_57b92362b466c.jpg', 'Product/2016-08-21/mini_57b92362b466c.jpg');
INSERT INTO `tour_file` VALUES ('85', '60', 'Product/2016-08-22/mini_57baff688d243.png', 'Product/2016-08-22/mini_57baff688d243.png');
INSERT INTO `tour_file` VALUES ('86', '61', 'Product/2016-08-23/mini_57bc55471c333.jpg', 'Product/2016-08-23/mini_57bc55471c333.jpg');

-- ----------------------------
-- Table structure for tour_logs
-- ----------------------------
DROP TABLE IF EXISTS `tour_logs`;
CREATE TABLE `tour_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guid` varchar(100) NOT NULL,
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `account` varchar(100) NOT NULL,
  `nickname` varchar(100) NOT NULL,
  `app` varchar(100) NOT NULL,
  `action` varchar(100) NOT NULL,
  `method` varchar(100) NOT NULL,
  `query_string` text NOT NULL,
  `is_desc` varchar(100) NOT NULL,
  `desc` varchar(100) NOT NULL,
  `ipaddr` varchar(100) NOT NULL,
  `unique_flag` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_logs
-- ----------------------------
INSERT INTO `tour_logs` VALUES ('27', '158', '2016-09-01 00:04:01', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('28', '158', '2016-09-01 00:15:42', 'admin4', 'admin4', 'Home', 'Index', 'userAgent', '', '0', '', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('29', '158', '2016-09-01 00:24:13', 'admin4', 'admin4', 'Home', 'AdminUser', 'createadminuser', 'admin888--123456--1', '1', '给ID为:[1]的角色,新增用户:[admin888],密码为:[123456]其他参数Array', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('30', '161', '2016-09-01 00:24:23', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('31', '161', '2016-09-01 00:29:47', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('32', '161', '2016-09-01 00:38:19', 'admin888', 'admin888', 'Home', 'AdminUser', 'createadminuser', 'admin666--123456--2', '1', '给ID为:[2]的角色,新增用户:[admin666],密码为:[123456]其他参数Array', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('33', '162', '2016-09-01 00:38:45', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('34', '161', '2016-09-01 00:39:22', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('35', '158', '2016-09-01 09:31:09', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('36', '161', '2016-09-01 09:31:26', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('37', '161', '2016-09-01 09:32:54', 'admin888', 'admin888', 'Home', 'AdminUser', 'delUser', '147', '1', '删除用户ID:147成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('38', '161', '2016-09-01 09:34:27', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('39', '161', '2016-09-01 09:34:57', 'admin888', 'admin888', 'Home', 'AdminUser', 'createadminuser', 'admin110--123456--1', '1', '给ID为:[1]的角色,新增用户:[admin110],密码为:[123456]其他参数Array', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('40', '162', '2016-09-01 09:37:05', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('41', '161', '2016-09-01 10:07:25', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('42', '161', '2016-09-01 10:07:48', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('43', '161', '2016-09-01 10:08:46', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('44', '161', '2016-09-01 10:09:12', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('45', '158', '2016-09-01 10:09:37', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('46', '162', '2016-09-01 10:13:07', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('47', '158', '2016-09-01 10:27:09', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('48', '162', '2016-09-01 10:27:20', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('49', '158', '2016-09-01 10:29:45', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('50', '162', '2016-09-01 10:32:34', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('51', '162', '2016-09-01 13:55:46', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('52', '161', '2016-09-01 14:04:06', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('53', '162', '2016-09-01 14:27:38', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('54', '158', '2016-09-01 14:47:09', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('55', '157', '2016-09-01 14:47:56', 'admin456', 'admin456', 'Home', 'Login', 'checkLogin', 'admin456--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('56', '158', '2016-09-01 14:50:22', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('57', '162', '2016-09-01 14:52:07', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('58', '158', '2016-09-01 14:53:22', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('59', '162', '2016-09-01 14:53:48', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('60', '158', '2016-09-01 14:56:04', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('61', '162', '2016-09-01 14:57:18', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('62', '158', '2016-09-01 15:11:33', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('63', '158', '2016-09-01 15:11:51', 'admin4', 'admin4', 'Home', 'Rbac', 'delUser', '152', '1', '删除用户ID:152成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('64', '158', '2016-09-01 15:11:59', 'admin4', 'admin4', 'Home', 'Rbac', 'delUser', '151', '1', '删除用户ID:151成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('65', '158', '2016-09-01 15:17:26', 'admin4', 'admin4', 'Home', 'Rbac', 'createadminuser', 'admin123789--123456--2', '1', '给ID为:[2]的角色,新增用户:[admin123789],密码为:[123456]其他参数Array', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('66', '158', '2016-09-01 15:17:42', 'admin4', 'admin4', 'Home', 'Rbac', 'delUser', '159', '1', '删除用户ID:159成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('67', '158', '2016-09-01 15:17:48', 'admin4', 'admin4', 'Home', 'Rbac', 'delUser', '157', '1', '删除用户ID:157成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('68', '158', '2016-09-01 15:17:55', 'admin4', 'admin4', 'Home', 'Rbac', 'delUser', '158', '1', '删除用户ID:158成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('69', '162', '2016-09-01 16:05:29', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('70', '161', '2016-09-01 16:08:45', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('71', '161', '2016-09-01 16:14:38', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('72', '161', '2016-09-01 17:37:41', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('73', '164', '2016-09-01 17:43:51', 'admin123789', 'admin123789', 'Home', 'Login', 'checkLogin', 'admin123789--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('74', '164', '2016-09-01 17:45:33', 'admin123789', 'admin123789', 'Home', 'Login', 'checkLogin', 'admin123789--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('75', '161', '2016-09-01 17:47:30', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('76', '164', '2016-09-01 17:48:38', 'admin123789', 'admin123789', 'Home', 'Login', 'checkLogin', 'admin123789--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('77', '161', '2016-09-01 17:49:54', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('78', '164', '2016-09-01 17:50:23', 'admin123789', 'admin123789', 'Home', 'Login', 'checkLogin', 'admin123789--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('79', '162', '2016-09-01 17:52:00', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('80', '161', '2016-09-01 18:03:37', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('81', '162', '2016-09-01 18:06:38', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('82', '161', '2016-09-01 18:14:19', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('83', '162', '2016-09-01 18:17:27', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('84', '161', '2016-09-01 18:21:29', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('85', '162', '2016-09-01 18:24:54', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('86', '164', '2016-09-01 20:46:37', 'admin123789', 'admin123789', 'Home', 'Login', 'checkLogin', 'admin123789--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('87', '164', '2016-09-01 20:49:10', 'admin123789', 'admin123789', 'Home', 'Rbac', 'userStatus', '108', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('88', '164', '2016-09-01 20:49:27', 'admin123789', 'admin123789', 'Home', 'Rbac', 'userStatus', '164', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('89', '164', '2016-09-01 20:52:23', 'admin123789', 'admin123789', 'Home', 'Rbac', 'userStatus', '108', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('90', '164', '2016-09-01 20:53:04', 'admin123789', 'admin123789', 'Home', 'Rbac', 'userStatus', '164', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('91', '164', '2016-09-01 20:53:14', 'admin123789', 'admin123789', 'Home', 'Rbac', 'userStatus', '', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('92', '164', '2016-09-01 20:55:21', 'admin123789', 'admin123789', 'Home', 'Rbac', 'userStatus', '164', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('93', '164', '2016-09-01 20:55:38', 'admin123789', 'admin123789', 'Home', 'Rbac', 'userStatus', '164', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('94', '164', '2016-09-01 20:58:46', 'admin123789', 'admin123789', 'Home', 'Rbac', 'userStatus', '', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('95', '161', '2016-09-01 20:59:40', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('96', '161', '2016-09-01 20:59:56', 'admin888', 'admin888', 'Home', 'Rbac', 'delUser', '108', '1', '删除用户ID:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('97', '161', '2016-09-01 21:00:51', 'admin888', 'admin888', 'Home', 'Rbac', 'delUser', '108', '1', '删除用户ID:108成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('98', '162', '2016-09-01 21:04:45', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('99', '162', '2016-09-01 21:05:08', 'admin666', 'admin666', 'Home', 'Rbac', 'userStatus', '', '1', '设置用户状态:失败', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('100', '161', '2016-09-01 22:28:01', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('101', '161', '2016-09-01 22:50:24', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('102', '161', '2016-09-01 22:51:16', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('103', '162', '2016-09-01 23:40:11', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('104', '161', '2016-09-01 23:43:00', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('105', '162', '2016-09-01 23:44:29', 'admin666', 'admin666', 'Home', 'Login', 'checkLogin', 'admin666--123456', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('106', '162', '2016-09-01 23:44:56', 'admin666', 'admin666', 'Home', 'Rbac', 'createadminuser', '管理人--123456--26', '1', '给ID为:[26]的角色,新增用户:[管理人],密码为:[123456]其他参数Array', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('107', '161', '2016-09-01 23:48:31', 'admin888', 'admin888', 'Home', 'Login', 'checkLogin', 'admin888--123456', '1', '登陆成功', '127.0.0.1', 'system');

-- ----------------------------
-- Table structure for tour_product
-- ----------------------------
DROP TABLE IF EXISTS `tour_product`;
CREATE TABLE `tour_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pName` varchar(255) NOT NULL,
  `pSn` varchar(50) NOT NULL,
  `pNum` int(10) unsigned NOT NULL DEFAULT '1',
  `mPrice` decimal(10,2) NOT NULL,
  `iPrice` decimal(10,2) NOT NULL,
  `pDesc` text NOT NULL,
  `pubTime` datetime NOT NULL,
  `isShow` tinyint(1) NOT NULL DEFAULT '1',
  `isHot` tinyint(1) NOT NULL DEFAULT '0',
  `cId` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pName` (`pName`),
  UNIQUE KEY `pName_2` (`pName`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_product
-- ----------------------------
INSERT INTO `tour_product` VALUES ('1', 'IMOOC苹果（APPLE）iPhone 4S 8G版 3G手机', '98122', '9999', '2000.00', '1999.00', '<p>\r\n	<span style=\"color:#666666;font-family:微软雅黑;font-size:14px;line-height:21px;background-color:#FFFFFF;\">双核，让 A5 芯片双倍强大，图形处理快达 7 倍1。你会感觉到它所带来的效果 — 飞快。iPhone 4S 快速，反应灵敏，当你启动应用软件、浏览网页，以及做各种操作时，就会体验到它所成就的与众不同。而且无论你正在做什么，都可以持续进行。A5 芯片具有极高的效能，赋予 iPhone 4S 超长的电池使用时间。</span> \r\n</p>\r\n<p>\r\n	<span style=\"color:#666666;font-family:微软雅黑;font-size:14px;line-height:21px;background-color:#FFFFFF;\"><span style=\"color:#666666;font-family:微软雅黑;font-size:14px;line-height:21px;background-color:#FFFFFF;\">双核，让 A5 芯片双倍强大，图形处理快达 7 倍1。你会感觉到它所带来的效果 — 飞快。iPhone 4S 快速，反应灵敏，当你启动应用软件、浏览网页，以及做各种操作时，就会体验到它所成就的与众不同。而且无论你正在做什么，都可以持续进行。A5 芯片具有极高的效能，赋予 iPhone 4S 超长的电池使用时间。</span><br />\r\n</span> \r\n</p>', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('2', 'IMOOC华为 荣耀3C （白色）3G手机 TD-SCDMA/GSM 2G RAM ', '1056969', '9999', '1099.00', '659.00', '<div style=\"margin:0px;padding:0px;background-color:#FFFFFF;color:#717071;font-family:微软雅黑;font-size:24px;\">\r\n	5英寸黑瀑布屏，全贴合工艺，LTPS技术\r\n</div>\r\n<p>\r\n	全贴合工艺，宛如黑瀑布，显示跃然屏上，清晰度更高，画质更细腻逼真 <br />\r\nLTPS低温多晶硅技术屏幕，响应速度快，更鲜艳\r\n</p>\r\n<p>\r\n	1280*720高清分辨率，1600万色，极佳的色彩表现，全视角\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<div style=\"margin:0px;padding:0px;background-color:#FFFFFF;color:#717071;font-family:微软雅黑;font-size:24px;\">\r\n	<br />\r\n</div>', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('3', '三星（SAMSUNG）I9158P 3G手机（白色）TD-SCDMA/GSM', '1072545', '9999', '1699.00', '1299.00', '<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-size:14px;font-weight:700;color:#666666;font-family:Arial, Helvetica, sans-serif;background-color:#FFFFFF;\">\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-weight:700;\">\r\n			5.8英寸清晰大屏，精彩“大”有不同\r\n		</div>\r\n		<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n			智能手机上也能畅享平板体验？GALAXY MEGA I9158P让平板和智能手机完美结合。它纤薄轻巧，让您轻松随身携带。极窄边框设计，让您单手亦可舒适掌握。更让您惊喜的是，它拥有5.8英寸的清晰大屏，提供更大的文字和图片显示，带来无比震撼的视觉冲击。\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n			<img alt=\"\" src=\"http://img20.360buyimg.com/vc/g14/M00/03/00/rBEhVVHL_jcIAAAAAAHZgUsur7oAAAl3ALoDUQAAdmZ750.jpg\" class=\"err-product\" />\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n			主屏支持竖屏、横屏两种显示模式，为您呈现更丰富的内容，提供最开阔的视野。无论您玩游戏、播放视频还是浏览网页，都可获得最大化的视觉体验。\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n			<img alt=\"\" src=\"http://img20.360buyimg.com/vc/g15/M09/03/00/rBEhWlHL_oMIAAAAAADnHDxBzd4AAAl3AE0jZQAAOc0328.jpg\" class=\"err-product\" />\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-weight:700;\">\r\n			多窗口多任务，一览无余，高效自如\r\n		</div>\r\n		<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n			需要处理多个任务时不想手忙脚乱、频繁切换窗口？GALAXY MEGA I9158P可在超大屏幕上同时运行两个程序窗口，让您体验真正便捷高效的多任务处理。\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n			<img alt=\"\" src=\"http://img20.360buyimg.com/vc/g15/M00/03/00/rBEhWFHL_u8IAAAAAACxViCPakQAAAl3QIhLpUAALFu557.jpg\" class=\"err-product\" />\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n			您可以在访问网页或与好友聊天的同时，发送邮件或观看视频，一举多得。您还可通过Pop Up play画中画功能，一边发短信、电子邮件或处理其它应用，一边欣赏大片，绝不错失任何精彩。并可根据需要，将视频窗口拖曳到任何位置，让娱乐更自由。\r\n		</div>\r\n	</div>\r\n</div>\r\n<div class=\"formwork_text\" style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Helvetica, sans-serif;font-size:14px;background-color:#FFFFFF;\">\r\n</div>', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('5', '胜伟 高支棉斜纹四件套裸婚时代100%棉1.5/1.8米床', '10569691', '99999', '149.00', '119.00', '<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	产品资料\r\n</p>\r\n<p class=\"formwork_titleleft2\" style=\"font-size:14px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	胜伟高支棉斜纹四<span class=\"wiki-words\" id=\"wiki-keyword-1\">件套</span>裸婚时代<br />\r\n<span class=\"wiki-words\" id=\"wiki-keyword-2\">面料</span>：40S全棉<br />\r\n适合床：1.5/1.8米床<br />\r\n规格：被套230*200&nbsp;<span class=\"wiki-words\" id=\"wiki-keyword-0\">床单</span>250*230 枕套48*74*2只<br />\r\n毛重：2.1kg\r\n</p>', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('7', 'XP 热 阿迪达斯adidas2014新款生活男鞋网面低帮场下篮球文化板鞋', '2342123', '9999', '555.00', '333.00', '<h1 style=\"font-size:16px;font-family:arial, \'microsoft yahei\';color:#666666;background-color:#FFFFFF;\">\r\n	XP 热 阿迪达斯adidas2014新款生活男鞋网面低帮场下篮球文化板鞋Q33480 尊贵蓝+亮黄荧光+白 43\r\n</h1>', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('9', '韩都衣舍 韩版2014夏装新款女装两件套圆领短袖T恤NW3201肆 白色 M', '1056333', '55', '134.00', '90.00', '<p>\r\n	<span style=\"color:#5C5C5C;font-family:微软雅黑;background-color:#FFFFFF;\">外衣大身：95%粘纤 5%氨纶&nbsp;外衣袖子：70%棉 25%锦纶 5%粘纤 内搭：95%粘纤 5%氨纶</span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#5C5C5C;font-family:微软雅黑;background-color:#FFFFFF;\">\r\n	<div class=\"content ke-post\" align=\"center\" style=\"margin:0px;padding:10px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img id=\"desc-module-3\" class=\"desc_anchor err-product\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t184/155/168032383/43/9acceab1/5382ee5eN2be51f49.gif\" />\r\n	</div>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t178/287/178335129/2820/609e02e3/5382ee60N2b1ddab5.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t148/50/186325206/7981/1e0aaf04/5382ee60N5e88de2b.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div class=\"content ke-post\" align=\"center\" style=\"margin:0px;padding:10px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img width=\"750\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t181/258/177275435/97121/d1daeccd/5382ee60N6a3f30e6.jpg\" class=\"err-product\" />\r\n	</div>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t205/334/168709737/134760/b4fbaff4/5382ee61N65bda1a9.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t190/165/182664900/141536/9c71d740/5382ee61N9e78a437.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t148/55/172181392/151420/bdf9cc8a/5382ee62Ne1afea73.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t196/125/192440496/118964/372173ca/5382ee62N7f1915a8.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t148/54/168991084/155385/fe5ee665/5382ee63N9832bd69.jpg\" class=\"err-product\" />\r\n	</p>\r\n<br />\r\n</span>\r\n</p>', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('10', '洛诗琳2014夏装新款女装欧根纱盘花荷叶边修身雪纺连衣裙', '102228144', '78', '786.00', '249.00', '<div style=\"margin:0px auto;padding:0px;color:#666666;background-color:#FFFFFF;border:1px dashed #AAAAAA;font-family:微软雅黑;\">\r\n	<p>\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g13/M00/01/18/rBEhU1NwdFUIAAAAAAAm5FOXIIcAANDzwPv_p8AACb8961.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"748\" class=\"ke-zeroborder\">\r\n		<tbody>\r\n			<tr>\r\n				<td align=\"middle\" rowspan=\"2\" valign=\"top\" width=\"218\">\r\n					<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g17/M00/00/06/rBEbSlNwdFkIAAAAAACS82hCKUUAAAPeQOPPtsAAJML149.jpg\" class=\"err-product\" />\r\n				</td>\r\n				<td rowspan=\"2\" width=\"10\">\r\n				</td>\r\n				<td valign=\"top\" width=\"250\">\r\n					<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"250\" style=\"text-align:center;color:#FFFFFF;font-size:12px;\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"25\" style=\"text-align:left;background-color:#555555;font-size:15px;\">\r\n									<strong>基本参数</strong>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"20\" style=\"text-align:left;color:#000000;font-size:13px;\">\r\n									<strong>款号：</strong>XDR114340\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"20\" style=\"text-align:left;color:#000000;font-size:13px;\">\r\n									<strong>品名：</strong>欧根纱盘花荷叶边修身雪纺连衣裙\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"20\" style=\"text-align:left;color:#000000;font-size:13px;\">\r\n									<strong>市场价：</strong>786RMB\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"30\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"25\" style=\"text-align:left;background-color:#555555;font-size:15px;\">\r\n									<strong>基本参数</strong>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" width=\"65\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>面料指数：</strong>\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									宽松\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									略松\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									合身\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									紧身\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>衣长指数：</strong>\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									超短\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									短\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									常规\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									中长\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>弹力指数：</strong>\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									无弹\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									微弹\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									弹力\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									超弹\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>面料质感：</strong>\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									顺滑\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									滑\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									适中\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									粒感\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>拉链位置：</strong>\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									无\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									背后\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									左侧\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									右侧\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>有无里衬：</strong>\r\n								</td>\r\n								<td colspan=\"3\" style=\"background-color:#DBA64A;\">\r\n									有\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td colspan=\"3\" style=\"background-color:#999999;\">\r\n									无\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td width=\"10\">\r\n				</td>\r\n				<td valign=\"top\">\r\n					<div style=\"margin:0px;padding:0px 20px;font-family:微软雅黑;background-color:#E6E6E6;font-size:13px;\">\r\n						<div style=\"margin:10px 0px 0px;padding:0px;font-size:15px;\">\r\n							<strong>面料信息</strong>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							&nbsp;\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							面料：乔其&nbsp;<br />\r\n里料：配色弹力双绉\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							&nbsp;\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							&nbsp;\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							面布成分:聚酯纤维100%&nbsp;<br />\r\n里布成分:聚酯纤维100%\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							&nbsp;\r\n						</div>\r\n						<div style=\"margin:10px 0px 0px;padding:0px;font-size:15px;\">\r\n							<strong>洗涤说明：</strong>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							<span style=\"color:#FF0000;\">手洗不可漂白</span>，冷水单独洗涤；\r\n						</div>\r\n					</div>\r\n				</td>\r\n				<td width=\"10\">\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"3\" valign=\"top\">\r\n					<div style=\"margin:15px auto;padding:0px;text-align:center;font-family:微软雅黑;background-color:#E6E6E6;font-size:15px;font-weight:bold;\">\r\n						身体尺寸参照表\r\n					</div>\r\n					<table cellpadding=\"0\" cellspacing=\"0\" height=\"170\" width=\"100%\" style=\"border:1px double #CCCCCC;text-align:center;font-family:微软雅黑;font-size:13px;\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#000\" height=\"25\" style=\"color:#FFFFFF;\">\r\n									尺码\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									S\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									M\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									L\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									XL\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									2XL\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									3XL\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									胸围(cm)\r\n								</td>\r\n								<td valign=\"center\">\r\n									83\r\n								</td>\r\n								<td valign=\"center\">\r\n									86\r\n								</td>\r\n								<td valign=\"center\">\r\n									90\r\n								</td>\r\n								<td valign=\"center\">\r\n									94\r\n								</td>\r\n								<td valign=\"center\">\r\n									98\r\n								</td>\r\n								<td valign=\"center\">\r\n									102\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									腰围(cm)\r\n								</td>\r\n								<td valign=\"center\">\r\n									67(2.01尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									70(2.1尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									74(2.22尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									78(2.34尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									82(2.46尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									84(2.52尺)\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									臀围(cm)\r\n								</td>\r\n								<td valign=\"center\">\r\n									89\r\n								</td>\r\n								<td valign=\"center\">\r\n									92\r\n								</td>\r\n								<td valign=\"center\">\r\n									96\r\n								</td>\r\n								<td valign=\"center\">\r\n									100\r\n								</td>\r\n								<td valign=\"center\">\r\n									104\r\n								</td>\r\n								<td valign=\"center\">\r\n									108\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									适合体重(kg)\r\n								</td>\r\n								<td valign=\"center\">\r\n									50kg以内\r\n								</td>\r\n								<td valign=\"center\">\r\n									55kg左右\r\n								</td>\r\n								<td valign=\"center\">\r\n									60kg左右\r\n								</td>\r\n								<td valign=\"center\">\r\n									65kg左右\r\n								</td>\r\n								<td valign=\"center\">\r\n									70kg左右\r\n								</td>\r\n								<td valign=\"center\">\r\n									75kg左右\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n					<div style=\"margin:0px;padding:0px;font-family:微软雅黑;color:#666666;font-size:11px;\">\r\n						注：以上均为身体尺寸（身体尺寸是人体裸身尺寸，即未穿着衣物时身体三围尺寸。)\r\n					</div>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"6\">\r\n					<div style=\"margin:10px 0px 0px 10px;padding:0px;\">\r\n						&nbsp;\r\n					</div>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td align=\"middle\" valign=\"top\">\r\n					<img width=\"210\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/02/1F/rBEhVVNwdKAIAAAAAABQNfYAS4oAANKaAGzIeQAAFBN916.jpg\" class=\"err-product\" />\r\n				</td>\r\n				<td>\r\n				</td>\r\n				<td colspan=\"3\">\r\n					<div style=\"margin:15px auto;padding:0px;text-align:center;font-family:微软雅黑;background-color:#E6E6E6;font-size:15px;font-weight:bold;\">\r\n						衣服平铺尺寸参照表\r\n					</div>\r\n					<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border:1px double #CCCCCC;text-align:center;font-family:微软雅黑;font-size:13px;\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#000\" height=\"25\" width=\"11%\" style=\"color:#FFFFFF;\">\r\n									尺码\r\n								</td>\r\n								<td width=\"11%\">\r\n									衣长\r\n								</td>\r\n								<td width=\"11%\">\r\n									肩宽\r\n								</td>\r\n								<td width=\"11%\">\r\n									胸围\r\n								</td>\r\n								<td width=\"11%\">\r\n									腰围\r\n								</td>\r\n								<td width=\"11%\">\r\n									臀围\r\n								</td>\r\n								<td width=\"12%\">\r\n									下摆围\r\n								</td>\r\n								<td width=\"11%\">\r\n									前领围\r\n								</td>\r\n								<td width=\"11%\">\r\n									后领围\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									S\r\n								</td>\r\n								<td valign=\"center\">\r\n									82.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									10.73\r\n								</td>\r\n								<td valign=\"center\">\r\n									88\r\n								</td>\r\n								<td valign=\"center\">\r\n									70.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									93\r\n								</td>\r\n								<td valign=\"center\">\r\n									114\r\n								</td>\r\n								<td valign=\"center\">\r\n									32.9\r\n								</td>\r\n								<td valign=\"center\">\r\n									26.1\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									M\r\n								</td>\r\n								<td valign=\"center\">\r\n									84\r\n								</td>\r\n								<td valign=\"center\">\r\n									11\r\n								</td>\r\n								<td valign=\"center\">\r\n									91\r\n								</td>\r\n								<td valign=\"center\">\r\n									73.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									96\r\n								</td>\r\n								<td valign=\"center\">\r\n									117\r\n								</td>\r\n								<td valign=\"center\">\r\n									33.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									26.5\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									L\r\n								</td>\r\n								<td valign=\"center\">\r\n									85.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									11.27\r\n								</td>\r\n								<td valign=\"center\">\r\n									95\r\n								</td>\r\n								<td valign=\"center\">\r\n									77.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									100\r\n								</td>\r\n								<td valign=\"center\">\r\n									121\r\n								</td>\r\n								<td valign=\"center\">\r\n									34.1\r\n								</td>\r\n								<td valign=\"center\">\r\n									26.9\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									XL\r\n								</td>\r\n								<td valign=\"center\">\r\n									87\r\n								</td>\r\n								<td valign=\"center\">\r\n									11.54\r\n								</td>\r\n								<td valign=\"center\">\r\n									99\r\n								</td>\r\n								<td valign=\"center\">\r\n									81.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									104\r\n								</td>\r\n								<td valign=\"center\">\r\n									125\r\n								</td>\r\n								<td valign=\"center\">\r\n									34.7\r\n								</td>\r\n								<td valign=\"center\">\r\n									27.3\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									XXL\r\n								</td>\r\n								<td valign=\"center\">\r\n									88.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									11.81\r\n								</td>\r\n								<td valign=\"center\">\r\n									103\r\n								</td>\r\n								<td valign=\"center\">\r\n									85.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									108\r\n								</td>\r\n								<td valign=\"center\">\r\n									129\r\n								</td>\r\n								<td valign=\"center\">\r\n									35.3\r\n								</td>\r\n								<td valign=\"center\">\r\n									27.7\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n					<div style=\"margin:0px;padding:0px;font-family:微软雅黑;color:#666666;font-size:11px;\">\r\n						注：因手工测量方式不同，存在2~4cm误差皆属合理范围(尺寸单位：cm)。\r\n					</div>\r\n				</td>\r\n				<td>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	&nbsp;\r\n</p>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	&nbsp;<img align=\"absmiddle\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g1/M04/00/06/rBEGD1NwdKAIAAAAAALvlgVmWdUAABa2APzcpQAAu-u912.jpg\" class=\"err-product\" />\r\n</p>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	<img align=\"absMiddle\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M01/02/1F/rBEhVVNwdFoIAAAAAAAiT7IZyYoAANKZwNHUUIAACJn018.jpg\" class=\"err-product\" />\r\n</p>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	<img align=\"absMiddle\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g3/M05/00/06/rBEGFFNwdFoIAAAAAAD1X7RYjwEAABa3AEKcHEAAPV3940.jpg\" class=\"err-product\" />\r\n</p>', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('11', '韩衣丽舍 CY2014夏新款韩版女装牛仔拼接雪纺连衣裙牛仔裙长裙', '8866LYQ', '45', '169.00', '199.00', '<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"07fa5f8b0f644c76a62797fe4f0223fd \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t160/219/133431860/416493/1f76f4da/5381b727Ncc768598.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"33b92c2981f64ed284db15bfcf8ec883 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t157/9/166904638/396606/e139ba1b/5381b728Nf85cf14e.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"24af0f32f1564c6b9561b37ae76564c2 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t169/236/141384077/453903/ecd40fcd/5381b729Naa51a872.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"9e11efaccd814d2591cd289cfdc30151 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t199/201/156259466/298191/c67a93b2/5381b729Nae8b4b38.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<a href=\"http://item.jd.com/1024261341.html\" target=\"_blank\"><img alt=\"\" id=\"1b0b1f8de179444693cd910e750d6478 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t151/27/138670676/358548/17c3a50f/5381b72aN69f0c395.jpg\" class=\"err-product\" /></a>\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"097734a9f5574c6891bb0f9e9916590d \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t199/203/141943017/319697/36542a9e/5381b72bNd8ad94aa.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"6315ea92fe624a59803f0ffa4b186651 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t172/26/143204448/477155/923b5a9b/5381b72cN62693c95.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"0bfcabc7649c4c7d81354988ab8feec4 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t208/355/136154145/377474/1cc3487e/5381b72cN65bcfb73.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"f6d36b1cfed141728277798329a57e1d \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t196/175/139809136/367694/57154e3a/5381b72dN28879b33.jpg\" class=\"err-product\" />\r\n</div>', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('12', '艾致倩 2014夏装新款韩版修身女装欧根纱短袖连衣裙', 'OXN6805', '12', '599.00', '168.00', '<img id=\"3615ebb4221f4797afef81df134a9b8a\" alt=\"\" src=\"http://img30.360buyimg.com/popWareDetail/g14/M02/1F/04/rBEhVVNWAwIIAAAAAAeVJL9aHNIAAMZ9wBR6tMAB5U8412.jpg\" class=\"err-product\" /><span style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">&nbsp;</span><br />\r\n<img id=\"bad72c8c72d448bab8963da4699f7534\" alt=\"\" src=\"http://img30.360buyimg.com/popWareDetail/g14/M05/1F/03/rBEhVVNWAvcIAAAAAAdlMWR8PEkAAMZ9QGb3jkAB2VJ750.jpg\" class=\"err-product\" />', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('13', '韩版修身女装欧根纱短袖短裤淑女套装两件套AZQHYYF887', '1056912', '5000', '168.00', '112.00', '<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g10/M00/1E/04/rBEQWFNknEUIAAAAAAsP7Wb7szsAAF51gFbMekACxAF429.jpg\" class=\"err-product\" />', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('14', '韩版修身女装雪纺短袖短裤淑女气质套装 ', 'AZQHYYF889', '12', '388.00', '188.00', '<img alt=\"\" id=\"ac037fb766d54957a20c15671cc07e58 \" src=\"http://img30.360buyimg.com/popWaterMark/g13/M00/00/0B/rBEhU1Nkk10IAAAAAAYkTiWQM-YAAMxZwM1CJ4ABiRm591.jpg\" class=\"err-product\" /><span style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">&nbsp;</span><br />\r\n<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M06/01/18/rBEhVlNkk4IIAAAAAAS2Qxpw2j0AAM66ALdnUYABLZb573.jpg\" class=\"err-product\" /><span style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">&nbsp;</span><br />\r\n<br />\r\n<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M06/01/18/rBEhV1Nkk4QIAAAAAA3vRomcFbcAAM66APTC2UADe9e973.jpg\" class=\"err-product\" /><span style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">&nbsp;</span>', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('15', '韩版修身无袖淑女圆领雪纺衫女短裙套装套裤两件套', '7546435', '34', '399.00', '148.00', '<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhV1NFProIAAAAAABCG8xwEJ0AALoUgMMgjQAAEIz736.jpg\" class=\"err-product\" />\r\n</p>\r\n<table height=\"298\" align=\"center\" border=\"1\" bordercolor=\"#000000\" width=\"730\" style=\"background-color:#FFFFFF;font-size:14px;font-family:tahoma, arial, 宋体, sans-serif;color:#333333;\">\r\n	<tbody>\r\n		<tr>\r\n			<td height=\"33\" width=\"162\">\r\n				<div align=\"center\" style=\"margin:0px;padding:0px;\">\r\n					<strong>测量方法</strong>\r\n				</div>\r\n			</td>\r\n			<td width=\"60\">\r\n				<div align=\"center\" style=\"margin:0px;padding:0px;\">\r\n					<strong>尺码</strong>\r\n				</div>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong>&nbsp;&nbsp;&nbsp;腰围&nbsp;&nbsp;&nbsp;</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong>&nbsp;&nbsp;&nbsp; 肩宽&nbsp;&nbsp;</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong>&nbsp;&nbsp;&nbsp; 胸围 &nbsp;&nbsp;&nbsp;</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong>&nbsp;&nbsp;&nbsp;衣长&nbsp;/裤长&nbsp;&nbsp;&nbsp;</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong></strong><br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td rowspan=\"6\">\r\n				<strong></strong><br />\r\n<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhVlNFPrsIAAAAAACJkb4NtKQAALoUgMczN0AAImp921.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td height=\"36\" style=\"text-align:center;\">\r\n				<strong>M</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				72\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				33\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				88\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				60/30\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td height=\"36\">\r\n				<div align=\"center\" style=\"margin:0px;padding:0px;\">\r\n					<strong>L</strong>\r\n				</div>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				76\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				34\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				92\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				61/31\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td height=\"36\" style=\"text-align:center;\">\r\n				<strong>XL</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				80\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				35\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				96\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				62/32\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td height=\"36\" style=\"text-align:center;\">\r\n				<strong>XXL</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				84\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				36\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				100\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				62/33\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td colspan=\"6\" height=\"36\" style=\"text-align:center;\">\r\n				<div align=\"center\" style=\"margin:0px;padding:0px;\">\r\n					注意：以上数据为平铺测量所得，没有拉伸，不考虑弹性范围内的数据。误差范围在1-3CM范围之内\r\n				</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td colspan=\"6\" height=\"36\" style=\"text-align:center;\">\r\n				模特资料：身高：166CM&nbsp;体重47KG&nbsp;三围：85/65/89&nbsp;&nbsp;试穿尺码：M码\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	<font ??=\"\" style=\"margin: 0px; padding: 0px;\"><img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhVlNFPrsIAAAAAAHgq5TGtdQAALoUgMpNVQAAeDD587.jpg\" class=\"err-product\" /><img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhV1NFPrsIAAAAAABHcavPyIkAALoUgMvFt0AAEeJ853.jpg\" class=\"err-product\" /></span>\r\n</p>\r\n<font ??=\"\" style=\"margin: 0px; padding: 0px;\"><font ??=\"\" style=\"margin: 0px; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Verdana, 宋体; white-space: normal; background-color: rgb(255, 255, 255);\"><img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhVlNFPr0IAAAAAAe5mj9H7m8AALoUgNdJlgAB7my558.jpg\" class=\"err-product\" /><img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhV1NFPr4IAAAAAAkjMBqbLScAALoUgOqf1UACSNI791.jpg\" class=\"err-product\" /></span></span>', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('16', '夏普（SHARP） 46英寸日本原装面板', 'LCD-46DS20A', '34', '3599.00', '3299.00', '<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M08/0C/0C/rBEhV1LP23gIAAAAAAKrQhwc71wAAH6PAG0qlgAAqta883.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div style=\"margin:0px;padding:0px;font-size:14px;\">\r\n		采用FullHD液晶屏，以1920x1080分辨力迎接数字时代\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		以1920×1080分辨力迎接数字电视新时代，呈现非凡出色的超精细画面。\r\n	</div>\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<div style=\"margin:0px;padding:0px;font-size:14px;\">\r\n		新1080/24P技术，以每秒24帧数的电影般播放模式\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		电影是由24帧数来拍摄的，新1080/24P技术，以每秒24帧数的电影般播放模式（在HDMI下支持1080P/24Hz）为您带来真正的影院效果，从未有过的视觉盛宴由AQUOS液晶电视带给您。\r\n	</div>\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M09/0C/0C/rBEhVVLP3FQIAAAAAAAzIX57aKYAAH6PQNxDKEAADM5955.jpg\" class=\"err-product\" />\r\n	</p>\r\n</div>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g15/M00/01/15/rBEhWFLP3MEIAAAAAAGzHsv9egUAAHx-gEQcIQAAbM2697.jpg\" class=\"err-product\" />\r\n</p>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<div style=\"margin:0px;padding:0px;font-size:14px;\">\r\n		倍速FullHD液晶驱动技术，高速动作处理更佳\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		夏普倍速液晶驱动技术。在通常50帧/秒的动画影像中，在两帧画像之间插入一帧画像，使信号提升2倍，即100帧/秒进行播放。使画面更流畅，全方位改善画面残留，大大减少画面拖尾现象，清晰再现高速运动的画面，带来更具震撼力的视觉体验。\r\n	</div>\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M0A/0C/0C/rBEhVlLP3SwIAAAAAAJH2h94X20AAH6PwB_qykAAkfy060.jpg\" class=\"err-product\" />\r\n	</p>\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M0A/0C/0C/rBEhVlLP3VgIAAAAAAHsx7Wj3xMAAH6PwNaDmUAAezf214.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		采用可以精确亮度控制并能告诉应答的LED背光源系统。结合新一代X超晶面板的使用，实现画面高对比度，在黑暗环境里也能再现纯正黑色和绚丽红色。\r\n	</div>\r\n</div>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g13/M03/0F/0E/rBEhU1LCir4IAAAAAAHPn-F09dQAAHevQI9mdUAAc-3112.jpg\" class=\"err-product\" />\r\n</p>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g14/M03/0A/16/rBEhVVLCi3MIAAAAAAMPUHuec08AAHlSwCCk4QAAw9o903.jpg\" class=\"err-product\" />\r\n</p>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g13/M09/0F/0E/rBEhU1LCi4wIAAAAAAKJJy-A0GcAAHewADfnfgAAok_965.jpg\" class=\"err-product\" />\r\n</p>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g14/M03/0A/16/rBEhVlLCi58IAAAAAAH146RVN9kAAHlSwMK9ogAAfX7360.jpg\" class=\"err-product\" />\r\n</p>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g15/M09/1F/1F/rBEhWVLCi7MIAAAAAALNsLPK9lkAAHdGAAHZZMAAs3I673.jpg\" class=\"err-product\" />\r\n</p>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M02/11/03/rBEhVFLP4CwIAAAAAAIrnR5jwgQAAHzuQAUq3YAAiu1444.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		采用数码环绕声技术，身临其境的感受，为您带来家庭影院级的享受，&nbsp;<br />\r\n再现电影或体育节目等扣人心弦的声音。\r\n	</div>\r\n</div>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g13/M02/11/03/rBEhVFLP4EoIAAAAAAGLXSBSAuQAAHzuQMw-80AAYt1128.jpg\" class=\"err-product\" />\r\n</p>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g15/M06/01/15/rBEhWFLP4G8IAAAAAAA16DDFBoMAAHyAAP4qTcAADYA742.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div style=\"margin:0px;padding:0px;font-size:14px;\">\r\n		您可以通过MHL线（市面有售），将支持MHL的智能手机与电视机连接，可以实现在电视&nbsp;<br />\r\n机的大画面上观看手机中的图像与视频，还可通过电视机的扬声器播放手机中的音乐。\r\n	</div>\r\n</div>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g15/M06/1D/08/rBEhWVKxT-EIAAAAAALdEus4i7YAAG7BQOhvIUAAt0q265.gif\" class=\"err-product\" />\r\n</p>', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('17', '三星（SAMSUNG） HT-F453K 5.1声道家庭影院 黑色', 'HT-F453K', '123', '3211.00', '2311.00', '<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_titlecenter\" style=\"margin:0px;padding:0px;text-align:center;font-weight:700;\">\r\n		经典畅销再延续 三星科技再升级\r\n	</div>\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		HT-F453K家庭影院，一直以来是畅销的主力机型。现在三星优秀的设计团队再次将经典延续，并注入了新的设计呈现给大家，三星家庭影院系统凭借其独特的外观设计、便捷的功能以及先进的音效提升技术为消费者带来了无缝的连接体验和纯净的音质表现，这也使其成为了今年三星电视产品的最佳音频伴侣。现在请和我们一起尽享1000w5.1声道为您带来的畅爽感官体验。\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品特色</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Selling Point</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g15/M00/04/0F/rBEhWFIJ6fIIAAAAAAOcAz2GvKAAACAdgP2LOYAA5wb121.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		三星HT-F453K家庭娱乐系统的设计是为实现更深层次的低音和更丰富的声音。通过连接共享功能及拓展,我们可以轻松欣赏USB内存驱动器或硬盘中的电影或是您记录幸福点滴的帅气照片。音箱简易设置令使用更加便利.卡拉OK为您带来的乐趣，Anynet+.音频回传.水晶功放自适应.USB自适应.丰富的接口设置等等一切，彰显HT-F453K的实用与时尚。\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g12/M00/0B/17/rBEQYFGl2jQIAAAAAABpLFDqsJ8AACSkwOhOfcAAGlE164.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-weight:700;\">\r\n		兼具便捷性与科技感的扬声器设置\r\n	</div>\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		简单快捷的音响设置模式，让您在家中轻松畅享高品质音效。它拥有直观的图形用户界面，并为您自动提升立体音效，您无需再操心音响的摆放位置。三星家庭影院，带给您极致观影体验。\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g12/M00/0C/1A/rBEQYVGpgfUIAAAAAAH1aBjkyyQAACgLAFTyEgAAfWA773.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-weight:700;\">\r\n		低音炮升级带来超逼真的音效感受\r\n	</div>\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		配备前置设计的重低音喇叭，加强重低音技术，为您带来更丰富层次感的音色体验，无论观赏电视节目、电影或欣赏音乐，都可以给您犹如身临其境的逼真音效。而且，强大影音效能集一身，让您足不出户也可体验电影院般的视听感受。比需要另外配置昂贵设备的同类产品尤其优胜！浩瀚的宇宙.蔚蓝的天空，此刻你的心是否随之翱翔那?\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g12/M00/0B/1F/rBEQYFGm6PsIAAAAAAFsgqJ_VC4AACVyQP93Z0AAWya123.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_titlecenter\" style=\"margin:0px;padding:0px;text-align:center;font-weight:700;\">\r\n		功能完备 娱乐家居生活\r\n	</div>\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		HT-F453K 支持卡拉ok，消声（部分碟盘格式可能不支持）及打分，支持调节回声电平;周末举办一场家庭卡拉ok比赛吧，让紧张的生活节奏放松一下吧，让你的好心情随歌声飞扬吧，生活就应该这样愉快。\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品细节</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Product Details</span>\r\n	</div>\r\n</div>\r\n<table width=\"750\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"6\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;font-size:12px;background-color:#FFFFFF;\" class=\"ke-zeroborder\">\r\n	<tbody>\r\n		<tr>\r\n			<td width=\"20%\">\r\n				<img src=\"http://img20.360buyimg.com/vc/g12/M00/0B/17/rBEQYVGl3TAIAAAAAACxfqDiSGoAACSoAP2DD8AALGW969.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td width=\"30%\">\r\n				<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;\">\r\n					HDMI (ARC)\r\n				</p>\r\n				<p class=\"formwork_titleleft2\" style=\"font-size:14px;\">\r\n					无需使用单独线缆进行连接，只需通过HDMI ARC (音频回传通道)，即可轻松连接兼容设备，处理电视音频信号。通过更少的线缆，只需要2个HDMI，即可连接音频设备，让您体验全新的音频世界。\r\n				</p>\r\n			</td>\r\n			<td width=\"20%\">\r\n				<img src=\"http://img20.360buyimg.com/vc/g12/M00/0B/17/rBEQYFGl3iMIAAAAAAAPnFh0sukAACSpAP7OVcAAA-0946.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td width=\"30%\">\r\n				<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;\">\r\n					多媒体连接\r\n				</p>\r\n				<p class=\"formwork_titleleft2\" style=\"font-size:14px;\">\r\n					通过连接即可分享视频, 您只需将USB内存驱动器或移动驱动器插入家庭影院，即可欣赏您喜爱的节目。\r\n				</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<table width=\"750\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"6\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;font-size:12px;background-color:#FFFFFF;\" class=\"ke-zeroborder\">\r\n	<tbody>\r\n		<tr>\r\n			<td width=\"20%\">\r\n				<img src=\"http://img20.360buyimg.com/vc/g12/M00/0C/02/rBEQYVGnBFgIAAAAAAAT5kFN-XwAACW3wMquKwAABP-443.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td width=\"30%\">\r\n				<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;\">\r\n					专属模式\r\n				</p>\r\n				<p class=\"formwork_titleleft2\" style=\"font-size:14px;\">\r\n					使用FOOTBALL键可以欣赏到犹如足球场上的音乐，你会感觉置身于场内一样。将遥控器按功能键选择FM，收听您喜爱的电台节目，你可以预设1-15个电台，想听就听。\r\n				</p>\r\n			</td>\r\n			<td width=\"20%\">\r\n				<img src=\"http://img20.360buyimg.com/vc/g12/M00/0C/02/rBEQYFGnBF8IAAAAAAAPK7wxCcYAACW3wP_1cYAAA9D151.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td width=\"30%\">\r\n				<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;\">\r\n					安全设置\r\n				</p>\r\n				<p class=\"formwork_titleleft2\" style=\"font-size:14px;\">\r\n					家长锁功能与指定评级DVD配合使用，指定评级可帮您控制家庭成员观看DVD类型，光盘最多分为8个评级，真正做到安全观看。\r\n				</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M03/0A/12/rBEhVVIK-TYIAAAAAAHmrnAnxxQAACEPQCZN5UAAebG208.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">尺寸信息</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Size Information</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M09/05/1A/rBEhUlIK-M0IAAAAAABSvlzDYpIAACCEQMKwVwAAFLW491.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M03/05/1A/rBEhU1IK-kUIAAAAAACSrbnEfnEAACCFwBSLbkAAJLF787.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n	</div>\r\n</div>', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('18', '美的（Midea）  近吸式吸油烟机', 'CXW-200-DJ213', '23', '1699.00', '1499.00', '<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品信息</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Product Information</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M04/14/1C/rBEhVVJYpsAIAAAAAACpJSF_RR4AAEFPwCmORQAAKk9728.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品细节</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Product Details</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g15/M05/0E/1D/rBEhWlJYpwoIAAAAAACAc_IcpT4AAEC3QFxIqEAAICL559.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M04/14/1C/rBEhVVJYpxUIAAAAAAB2d8MxlOsAAEFPwHHJzUAAHaP334.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M04/14/1C/rBEhVlJYpyIIAAAAAABspRXmbnEAAEFPwLXMWcAAGy9163.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M04/14/1C/rBEhVlJYpywIAAAAAACSmHYT0I0AAEFPwO3SLcAAJKw955.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M08/14/1C/rBEhVlJYp0gIAAAAAABufB5Nmh0AAEFQAJg4pgAAG6U783.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M04/10/03/rBEhU1JYp1MIAAAAAABw92REWJcAAECoAPe-XcAAHEP895.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		全不锈钢设计；大进风设计；琴键式设计；多种风速调节；渐明渐暗护眼灯；\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品特色</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Selling Point</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M05/10/03/rBEhUlJYp2YIAAAAAAD7s_d8ARYAAECoQM1_ioAAPvL996.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M08/14/1C/rBEhVlJYp6EIAAAAAADIVxa12-AAAEFQANj3LAAAMhv206.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('19', '海尔（Haier） XQG70-B10866 电商 7公斤 变频滚筒洗衣机', 'XQG70-B10866', '12', '3399.00', '3299.00', '<div class=\"right\" style=\"margin:0px;padding:0px;\">\r\n	<div id=\"product-detail\" class=\"m m1\" style=\"margin:0px 0px 10px;padding:2px 0px 0px;\">\r\n		<div class=\"mc\" id=\"product-detail-1\" style=\"margin:0px;padding:0px;\">\r\n			<div class=\"detail-content\" style=\"margin:0px;padding:0px;\">\r\n				<table align=\"center\" width=\"750\">\r\n					<tbody>\r\n						<tr>\r\n							<td>\r\n								<a target=\"_blank\" href=\"http://sale.jd.com/act/OpjCvlLcN5uo.html\"><img alt=\"\" src=\"http://img30.360buyimg.com/jgsq-productsoa/jfs/t154/129/656904086/101633/5f6cae2d/53952f8bN50c53e38.jpg\" class=\"err-product\" /></a>\r\n							</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n				<table align=\"center\" width=\"750\">\r\n					<tbody>\r\n						<tr>\r\n							<td>\r\n								<a target=\"_blank\" href=\"http://sale.jd.com/act/P6FWJzn5VILf.html\"><img alt=\"\" src=\"http://img30.360buyimg.com/jgsq-productsoa/jfs/t145/37/561203875/116765/194fd8d4/5391245fN7e3d69e6.png\" class=\"err-product\" /></a>\r\n							</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n				<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"750\" class=\"ke-zeroborder\">\r\n					<tbody>\r\n						<tr>\r\n							<td valign=\"top\">\r\n								<a target=\"_blank\" href=\"http://sale.jd.com/act/vfQlPDUkRy8zO3b.html\"><span id=\"_xhe_cursor\"></span><span id=\"_xhe_temp\"></span><img alt=\"\" src=\"http://img30.360buyimg.com/jgsq-productsoa/jfs/t184/49/715984598/64095/140538d4/53969d4bN7bf24700.jpg\" class=\"err-product\" /></a>\r\n							</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n				<div style=\"margin:0px auto;padding:0px;\">\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M08/15/00/rBEhWlNGdoMIAAAAAAJFhIQwiJAAALj9gBQXRsAAkWc704.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M08/15/00/rBEhWVNGdpMIAAAAAAGoualDSyMAALj9gFpa4sAAajR495.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							无碳刷设计，避免普通串激电机碳刷摩擦产生的风啸声及电火花，超级静音，夜晚洗衣也安静。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							360°零缝隙控制信号，平滑调速，精准调控电机运转及洗涤节奏，精准洗涤，节能减碳，带来绿色的低碳体验.\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							外驱动升级为内驱动，直效内驱，转速&nbsp;<br />\r\n高达1000转/分钟，大幅提升滚筒洗净&nbsp;<br />\r\n能力，洗净比最高达1.23*。\r\n							<div style=\"margin:20px 0px 0px;padding:0px;font-size:12px;\">\r\n								* 数据来源：经国家家用电器质量监督检测中心检测得出\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M08/15/00/rBEhWVNGdqAIAAAAAAPBk98FIyYAALj9gLRQW4AA8Gr051.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							洗衣机静止状态下，经过电脑模拟及实机模拟测定，精确选定6个平衡支撑点用以保持滚筒稳定性，在启动洗衣机前排除滚筒自身不平衡因素，保证洗衣机运转平稳。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							洗衣机运转过程中，HPM芯平衡系统主动调整高碳素钢挂簧及空气阻尼器的拉伸强度，即时调整洗涤过程中产生的偏心，始终保持平衡，即使宝宝的毛绒玩具熊也能轻松洗净、甩干。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							薄壳仿生原理设计，受力均匀、耐压，极大提高承受强度的同时避免箱体与各部件之间发生共振，减小洗涤振动与噪声。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							不同的污渍用不同的水温洗涤效果更佳，海尔洗衣机每一个程序可以自动调节水温，充分发挥酶的活性，达到最好的洗涤效果。\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M08/15/00/rBEhWFNGdqsIAAAAAAJWq-x0IZIAALj9gPkfDgAAlbD646.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:14px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:22px;\">\r\n								1.独创弹力筋\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								海尔独创弹力筋内筒，平滑的筒壁上分布有128道弹力筋，弹力筋中间凹槽密布3234个脱水小孔。内筒旋转带动弹力筋不断击荡水流，产生震荡水波，颠簸式洗涤衣物，弹落顽固污渍，同时激发织物纤维活性。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:14px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:22px;\">\r\n								2.活力弹污 三重洗涤更干净\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								独特弹力筋洗涤方式，辅以传统垂直摔打洗涤及立体喷射水流，三重洗涤，快速去除深层污垢；同时，污垢从最低处脱水孔通畅排出，导垢彻底，洁净效果更加显著。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:14px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:22px;\">\r\n								3.完美护衣&nbsp;<br />\r\n焕发衣物纤维活力\r\n							</div>\r\n							<div style=\"margin:10px 0px 0px;padding:0px;\">\r\n								弹力筋犹如支起的“支架”，避免衣物与脱水孔间的磨擦，同时减少洗涤水流对衣物的拉伸力度，柔和洗涤，还原织物纤维弹性，衣物洗后蓬松柔软。\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M0A/1A/12/rBEhWFNfaMQIAAAAAAR0oGyUsFAAAMpRgNjxb4ABHS4526.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								洁净生活迅速拥有\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								洗涤、漂洗、甩干全部完成只需15分钟，夏天衣物及时洗，少量衣物随时洗，满足您经常换洗衣物的洁净需求。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								洗衣机也有洁癖\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								洗时段自动增加摔打揉搓的时间和强度，与顽固污渍奋战到底。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								多一次漂洗才格外干净\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								在原有漂洗次数基础上，增加一次漂洗，衣物漂洗更干净。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								多几种选择 多几分呵护\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								电脑控制，独立水温调节，较大较脏衣物加热到40℃，充分激活活性酶；洗小孩、病人衣物加热到90℃，杀菌消毒。\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g13/M02/04/0D/rBEhUlNGdsYIAAAAAAOtvhbTadUAALk4QG6Iv8AA63W767.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								轻松跟上你想要的速度\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								脱水转速可根据需要进行调整，选择范围从400,600,800至1000转每分钟,呵护您和家人的衣物，省心力，随心意。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								我的时间我做主\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								24小时预约洗涤，时间一到衣服就洗好，特别适合上班族和分时电价地区。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								抑制霉菌滋生，健康呵护倍增\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								经权威机构测定，抗菌率&gt;99％，达到最高等级，有效抑制霉菌滋生。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								方便快捷\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								安全状态下可开启筒门，方便中途添加衣物；洗衣结束立即开门，无需等待\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								人性设计 舒适洗衣\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								45°筒门开启设计，符合人机原理，操作不弯腰，方便又省力 。\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g13/M02/04/0D/rBEhUlNGdtQIAAAAAAJtWA2eTVoAALk4gAZ7osAAm1w237.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								鼠标式程序旋钮\r\n							</div>\r\n弱电工作、安全可靠、操作方便、使用寿命更长。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								LED显示\r\n							</div>\r\n一目了然，轻松洗衣\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								AMT防霉抗菌窗垫\r\n							</div>\r\n抑制霉菌滋生，健康呵护倍增\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								抽屉式洗衣粉盒\r\n							</div>\r\n洗衣粉和洗涤剂分开投放，溶解充分，一体式设计避免藏污纳垢藏污纳垢。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								筒壁上分布128道弹力筋\r\n							</div>\r\n降低磨损，提高洗净比\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M00/1B/10/rBEhVlNGduMIAAAAAAeTlV7qJfEAALs9QAJanQAB5Ot945.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							台面板采用一体式设计，四面封胶，杜绝安全隐患。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：台面板采用装订拼接工艺，易渗水受潮导致台面鼓，台面发霉等，如与电器接触可引起起火等重大安全隐患。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							分配盒使用优质工程塑料，强度高分配器盒内壁镜面抛光，冲洗无残留。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：分配器盒使用回用料，颜色深，性能差，易损坏。内壁粗糙有毛刺，洗衣粉粘结在盒内，造成漂洗不干净。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							窗垫无残留泡沫、不会发生发霉变黑现象。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：窗垫残留泡沫，发霉变黑。\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g12/M00/06/1F/rBEQYFNGdwAIAAAAAAfod5BRH_wAAEL2QJ6K-QAB-iP295.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							内筒内后法兰打孔工艺，可以让洗涤时水流冲刷力更强，对衣服形成多角度冲刷，提高洗净率。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：内筒后法兰工艺简单，无孔。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							铰链厚度厚，表面电镀镜面处理，坚固不生锈。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：观察窗门铰链厚度薄，表面简单镀锌，处理简单，易生锈。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							内筒采用正反冲，弹力筋，微孔脱水工艺，洗涤时弹力筋产生激荡水流，降低磨损，提高洗净比，呵护衣物。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：内筒采用原始的单面冲孔工艺，孔眼大，易产生毛刺且高速甩干时对衣服磨损大（特别在洗涤羊毛，真丝等高档面料。）\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M00/1B/10/rBEhV1NGdxAIAAAAAATquM1eU3UAALs9QKNJSkABOrQ317.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							有电脑板盒保护，安全性高（正如电视机需要后盖一样，既能保护电脑版，又不影响散热）。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：电脑板裸露，存在极大安全隐患（因静电作用，易吸附潮气，灰尘等，带来不安全隐患）。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							内筒焊接工艺，采用第三代激光无缝焊接，可承受超高转速负荷；\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：采用第一代扣缝工艺，不能承受高转速负荷\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M00/1B/10/rBEhV1NGdxwIAAAAAAG-ZqoUWgAAALs9QOpdaEAAb5-761.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M04/1B/10/rBEhVVNGdykIAAAAAACfGVhD7aQAALs9gCEr0AAAJ8x452.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#DDDDDD;\">\r\n							产品型号&nbsp;<br />\r\n电机类型&nbsp;<br />\r\n内桶材质&nbsp;<br />\r\n上市时间&nbsp;<br />\r\n洗涤功率&nbsp;<br />\r\n洗衣机能效等级&nbsp;<br />\r\n箱体材质&nbsp;<br />\r\n显示方式&nbsp;<br />\r\n脱水功率&nbsp;<br />\r\n尺寸（高*宽*深mm）&nbsp;<br />\r\n产品净重\r\n							<div style=\"margin:15px 0px;padding:0px;\">\r\n								洗衣程序\r\n							</div>\r\n产品毛重&nbsp;<br />\r\n洗净比&nbsp;<br />\r\n是否预约&nbsp;<br />\r\n开门方式&nbsp;<br />\r\n排水方式&nbsp;<br />\r\n洗涤公斤量&nbsp;<br />\r\n洗衣/干衣机型&nbsp;<br />\r\n自动化程度\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#DDDDDD;\">\r\n							XQG70-B10866 电商&nbsp;<br />\r\n变频电机&nbsp;<br />\r\n不锈钢&nbsp;<br />\r\n2013年&nbsp;<br />\r\n250&nbsp;<br />\r\n1级&nbsp;<br />\r\n渗锌钢板&nbsp;<br />\r\nLED&nbsp;<br />\r\n450&nbsp;<br />\r\n850*595*600&nbsp;<br />\r\n71&nbsp;<br />\r\n							<div style=\"margin:10px 0px 12px;padding:0px;\">\r\n								内衣、羊毛、化纤、棉麻、预洗、&nbsp;<br />\r\n小件、快洗、单洗、单漂、单甩\r\n							</div>\r\n78&nbsp;<br />\r\n1.03&nbsp;<br />\r\n有&nbsp;<br />\r\n前开式&nbsp;<br />\r\n上排水&nbsp;<br />\r\n7公斤&nbsp;<br />\r\n洗衣机&nbsp;<br />\r\n全自动&nbsp;<br />\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M06/15/00/rBEhWVNGdzMIAAAAAACQYo-RwtoAALj9wE4e3sAAJB6251.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M06/15/00/rBEhWFNGdz4IAAAAAABPj0St3E8AALj9wL6qmsAAE-n852.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#FFFFFF;font-size:20px;\">\r\n							滚筒洗衣机使用一段时间后的保养方法\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:0px 0px 0px 10px;padding:0px;\">\r\n								滚筒洗衣机使用一段时间后的保养方法：\r\n							</div>\r\n【1】不洗衣时，应将机门微开，以便透风，防止筒内出现异味。&nbsp;<br />\r\n【2】带过滤器的滚筒洗衣机要定期清理过滤器，以防堵塞。&nbsp;<br />\r\n【3】不要将洗衣机放在潮湿的环境里，以防电器件受潮，缩短机器寿命。&nbsp;<br />\r\n【4】洗衣机的底部经常保持清洁干燥，以防箱体生锈。&nbsp;<br />\r\n【5】使用几次后，应将分配器盒拉出来清理。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#FFFFFF;font-size:20px;\">\r\n							滚筒洗衣机如何安置才可以减轻震动？\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							减振方法：&nbsp;<br />\r\n滚筒洗衣机安放时，四个底角应在同一平面上，洗衣机底部不能倾斜，不能垫木板等垫块，也不宜放置在底部悬空的木地板上。而且，洗衣机安放时应取出洗衣机运输包装的固定用螺栓、泡沫等材料，这样就可以有效减轻振动。\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M01/15/00/rBEhWlNGd0oIAAAAAABb7xRVdXoAALj-ACGGjwAAFwH038.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#FFFFFF;font-size:20px;\">\r\n							安装条件：\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:3px 0px 0px;padding:0px;\">\r\n								安放位置不能太潮湿，地面不能太光滑或不平，不能安装在台子上，环境温度不能低于0度；\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								如卫生间不适合摆放洗衣机，可以设计到厨房，客厅，阳台等位置；\r\n							</div>\r\n							<div style=\"margin:20px 0px 0px;padding:0px;\">\r\n								电源要求：220V/50HZ交流电，使用单独的三相插座，并有可靠接地，滚筒洗衣机插座最大承载电流不低于15A;\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								安装的位置最好有地漏，以保证排水通畅；\r\n							</div>\r\n							<div style=\"margin:30px 0px 0px;padding:0px;\">\r\n								自来水压力在0.03-1MPA（兆帕）之间。\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M01/15/00/rBEhWFNGd1UIAAAAAACxG3mx-pcAALj-AKc7mkAALEz929.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							收费项目&nbsp;<br />\r\n							<div style=\"margin:25px 0px 0px;padding:0px;\">\r\n								加长进水管\r\n							</div>\r\n							<div style=\"margin:60px 0px 0px;padding:0px;\">\r\n								加长排水管\r\n							</div>\r\n							<div style=\"margin:190px 0px 0px;padding:0px;\">\r\n								水龙头\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:5px 0px 0px;padding:0px;\">\r\n								收费说明\r\n							</div>\r\n							<div style=\"margin:10px 0px 0px;padding:0px;\">\r\n								由于用户的使用环境不同如果安装过程中需要加长进水管，加长的进水管需要另行收费\r\n							</div>\r\n							<div style=\"margin:3px 0px 0px;padding:0px;\">\r\n								由于用户的使用环境不同如果安装过程中需要加长排水管，加长的排水管需要另行收费\r\n							</div>\r\n							<div style=\"margin:70px 0px 0px;padding:0px;\">\r\n								1、如用户需要安装水龙头可以自行选购安装符合标准的水龙头。\r\n							</div>\r\n							<div style=\"margin:110px 0px 0px;padding:0px;\">\r\n								2、用户也可以选购海尔提供的水龙头，海尔可以收费提供专用水龙头，并负责免费安装。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:5px 0px 0px;padding:0px;\">\r\n								收费标准\r\n							</div>\r\n							<div style=\"margin:10px 0px 0px;padding:0px;\">\r\n								加长0.5米（12元/根） 加长1米（15元/根） 加长2米（20元/根）\r\n							</div>\r\n							<div style=\"margin:50px 0px 0px;padding:0px;\">\r\n								加长1.5米（5元/根）\r\n							</div>\r\n							<div style=\"margin:105px 0px 0px;padding:0px;\">\r\n								标准水龙头46元/个\r\n							</div>\r\n							<div style=\"margin:150px 0px 0px;padding:0px;\">\r\n								精品水龙头65元/个\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:5px 0px 0px;padding:0px;\">\r\n								收费标准\r\n							</div>\r\n							<div style=\"margin:70px 0px 0px;padding:0px;\">\r\n								进水管、排水管&nbsp;<br />\r\n为整根加长\r\n							</div>\r\n							<div style=\"margin:80px 0px 0px;padding:0px;\">\r\n								- 专享三年超长保修服务&nbsp;<br />\r\n免除您的后顾之忧&nbsp;<br />\r\n- 采用行业内锻压、冲孔工艺，内壁光滑耐腐蚀，密度高&nbsp;<br />\r\n- 主体采用纯铜材料，防锈，经久耐用，陶瓷阀芯，耐磨性高\r\n							</div>\r\n							<div style=\"margin:20px 0px 0px;padding:0px;\">\r\n								- 专享三年超长保修服务免除您的后顾之忧&nbsp;<br />\r\n- 货真价实的材料，主体采用纯铜制造，密度高，抗氧化，防锈斑，陶瓷阀芯，耐磨性高&nbsp;<br />\r\n- 完全贴合洗衣机进水管的设计，密封效果好，有效防止滴漏\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							说明：&nbsp;<br />\r\n因每位用户的安装环境不同，需求不同，安装过程中需要其它辅加材料或特殊服务项目，具体收费标准参考《海尔维修服务收费标准》。服务人员上门安装时会出示收费标准并讲解，同时请您监督我们的服务，如发现服务人员多收费，可拨打海尔售后统一服务热线投诉并有权拒绝付费，经核实属实的，本次服务“免单”（全额退还收取的安装材料费）。\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M04/1B/10/rBEhVlNGd2MIAAAAAAGjmqPCFhoAALs9gG-XXgAAaOy289.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g13/M02/04/0D/rBEhU1NGd28IAAAAAALQCZn9Ba8AALk4gIMgdAAAtAh713.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g13/M04/04/0D/rBEhUlNGd4sIAAAAAAFQtPmsSlYAALk4wJsJ20AAVDM520.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M04/1B/10/rBEhVlNGd5YIAAAAAAMTkbIuygQAALs9gLoUG4AAxOp692.jpg\" class=\"err-product\" />\r\n					</div>\r\n				</div>\r\n				<table align=\"center\" width=\"750\">\r\n					<tbody>\r\n						<tr>\r\n							<td>\r\n								<img alt=\"\" src=\"http://img30.360buyimg.com/jgsq-productsoa/g13/M09/0F/0B/rBEhU1LCWgoIAAAAAACAkL3yMvEAAHd2wElDz0AAICo828.jpg\" class=\"err-product\" />\r\n							</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</div>\r\n		</div>\r\n		<div id=\"promises\" style=\"margin:0px;padding:10px;\">\r\n			<strong>服务承诺：</strong><br />\r\n京东商城向您保证所售商品均为正品行货，京东自营商品开具机打发票或电子发票。凭质保证书及京东商城发票，可享受全国联保服务（奢侈品、钟表除外；奢侈品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。京东商城还为您提供具有竞争力的商品价格和<a href=\"http://www.jd.com/help/kdexpress.aspx\" target=\"_blank\">运费政策</a>，请您放心购买！&nbsp;<br />\r\n注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！\r\n		</div>\r\n		<div id=\"state\" style=\"margin:0px;padding:10px;\">\r\n			<strong>权利声明：</strong><br />\r\n京东商城上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是京东商城重要的经营资源，未经许可，禁止非法转载使用。\r\n			<p>\r\n				<b>注：</b>本站商品信息均来自于厂商，其真实性、准确性和合法性由信息拥有者（厂商）负责。本站不提供任何保证，并不承担任何法律责任。\r\n			</p>\r\n		</div>\r\n	</div>\r\n	<div id=\"comment\" class=\"m m2\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;font-size:14px;font-family:\'microsoft yahei\';\">\r\n			<h2 style=\"font-size:14px;font-weight:400;\">\r\n				商品评价\r\n			</h2>\r\n		</div>\r\n		<div class=\"mc\" style=\"margin:0px;padding:10px 0px;\">\r\n			<div class=\"iloading\" style=\"margin:0px auto;padding:0px 0px 0px 22px;color:#999999;\">\r\n				正在加载中，请稍候...\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"comments-list\" class=\"m\" style=\"margin:0px 0px 20px;padding:2px 0px 0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;font-size:14px;font-family:\'microsoft yahei\';\">\r\n			<ul class=\"tab\">\r\n				<li class=\"curr\" style=\"text-align:center;color:#E4393C;background-color:#FFFFFF;\">\r\n					<a>全部评价(0)</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>好评(0)</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>中评(0)</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>差评(0)</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>有晒单的评价(0)</a>\r\n				</li>\r\n				<li class=\"tab-last\" style=\"text-align:center;\">\r\n				</li>\r\n			</ul>\r\n		</div>\r\n		<div id=\"comment-0\" class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<div class=\"iloading\" style=\"margin:20px auto;padding:0px 0px 0px 22px;color:#999999;\">\r\n				正在加载中，请稍候...\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"consult\" class=\"m m1\" style=\"margin:0px 0px 20px;padding:2px 0px 0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;font-size:14px;font-family:\'microsoft yahei\';\">\r\n			<ul class=\"tab\">\r\n				<li class=\"curr\" style=\"text-align:center;color:#E4393C;background-color:#FFFFFF;\">\r\n					<a>全部购买咨询</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>商品咨询</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>库存配送</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>支付</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>发票保修</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>支付帮助</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>配送帮助</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>常见问题</a>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n		<div id=\"consult-search\" style=\"margin:0px;padding:10px 16px;\">\r\n			<div class=\"form\" style=\"margin:0px;padding:0px;\">\r\n				咨询前请先搜索，方便又快捷：\r\n			</div>\r\n			<div class=\"prompt\" style=\"margin:0px;padding:9px 0px 9px 16px;color:#9C9A9C;\">\r\n				<strong>温馨提示:</strong>因厂家更改产品包装、产地或者更换随机附件等没有任何提前通知，且每位咨询者购买情况、提问时间等不同，为此以下回复仅对提问者3天内有效，其他网友仅供参考！若由此给您带来不便请多多谅解，谢谢！\r\n			</div>\r\n		</div>\r\n		<div id=\"consult-0\" class=\"mc tabcon\" style=\"margin:0px;padding:0px;\">\r\n			<div class=\"iloading\" style=\"margin:0px auto;padding:0px 0px 0px 22px;color:#999999;\">\r\n				正在加载中，请稍候...\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"discuss\" class=\"m m1\" style=\"margin:0px 0px 10px;padding:2px 0px 0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;font-size:14px;font-family:\'microsoft yahei\';\">\r\n			<ul class=\"tab\">\r\n				<li class=\"curr\" style=\"text-align:center;color:#E4393C;background-color:#FFFFFF;\">\r\n					<a>网友讨论圈</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>晒单贴</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>讨论贴</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>问答贴</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>圈子贴</a>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n		<div id=\"discuss-1\" class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<div class=\"iloading\" style=\"margin:0px auto;padding:0px 0px 0px 22px;color:#999999;\">\r\n				正在加载中，请稍候...\r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>\r\n<div class=\"left\" style=\"margin:0px;padding:0px;\">\r\n	<div id=\"related-sorts\" class=\"m m2\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n			<h2 style=\"font-size:14px;font-weight:400;\">\r\n				相关分类\r\n			</h2>\r\n		</div>\r\n		<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<ul class=\"lh\">\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-798.html\">平板电视</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-870.html\">空调</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-878.html\">冰箱</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-880.html\">洗衣机</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-823.html\">家庭影院</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-965.html\">DVD播放机</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1199.html\">迷你音响</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1300.html\">烟机/灶具</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1706.html\">热水器</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1301.html\">消毒柜/洗碗机</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1707.html\">酒柜/冰吧/冷柜</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-877.html\">家电配件</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1013.html\">家电下乡</a>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</div>\r\n	<div id=\"related-brands\" class=\"m m2\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n			<h2 style=\"font-size:14px;font-weight:400;\">\r\n				同类其他品牌\r\n			</h2>\r\n		</div>\r\n		<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<ul class=\"lh\">\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-18403.html\">小天鹅（Little Swan）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-7817.html\">海尔（Haier）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-2505.html\">TCL</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-16407.html\">松下（Panasonic）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-7408.html\">格兰仕（Galanz）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-22186.html\">统帅（Leader）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-17382.html\">威力（WEILI）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-15133.html\">三洋（SANYO）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-1528.html\">LG</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-12380.html\">美的（Midea）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-18423.html\">小鸭</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-18177.html\">现代（HYUNDAI）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-10317.html\">康佳（KONKA）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-7888.html\">海信（Hisense）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-17887.html\">西门子（SIEMENS）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-14705.html\">日普（RIPU）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-19909.html\">樱花（Sakura）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-9508.html\">金松（JINSONG）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-14734.html\">荣事达（Royalstar）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-15127.html\">三星（SAMSUNG）</a>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		<div id=\"view-buy\" class=\"m m2 related-buy hide\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n			<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n				<h2 style=\"font-size:14px;font-weight:400;\">\r\n					浏览了该商品的用户最终购买了\r\n				</h2>\r\n			</div>\r\n			<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n				<ul>\r\n					<li class=\"fore1\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015650.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG70-1000J 7公斤 1000转滚筒洗衣机（银灰色）\" src=\"http://img10.360buyimg.com/n4/g10/M00/1C/02/rBEQWFNaM-gIAAAAAAHEkmKa3kMAAFgCAPtLXoAAcSq389.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015650.html\">海尔（Haier） XQG70-1000J 7公斤 1000转滚筒洗衣机（银灰色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015650\">￥1999.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore2\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015658.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG70-B1286 电商 7公斤 1200转变频滚筒洗衣机（银灰色）\" src=\"http://img13.360buyimg.com/n4/g14/M01/02/00/rBEhVVNmEGsIAAAAAAIJBBbz8GoAAM-EADL6qcAAgkc040.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015658.html\">海尔（Haier） XQG70-B1286 电商 7公斤 1200转变频滚筒洗衣机（银灰色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015658\">￥3499.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore3\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1069497.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG60-BS1086AM 6公斤 变频滚筒洗衣机\" src=\"http://img12.360buyimg.com/n4/g13/M0A/01/0A/rBEhU1NoeGcIAAAAAAMZpOXaofEAAM-KQKSb-8AAxm8158.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1069497.html\">海尔（Haier） XQG60-BS1086AM 6公斤 变频滚筒洗衣机</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1069497\">￥3099.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore4\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/876668.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-N12435D 6公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img13.360buyimg.com/n4/g13/M03/09/0C/rBEhVFNdyPIIAAAAAAGCGiBpM18AAMjCACQRzoAAYIy355.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/876668.html\">LG WD-N12435D 6公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-876668\">￥2099.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore5\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698301.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img11.360buyimg.com/n4/g10/M00/1C/02/rBEQWFNaOG0IAAAAAAGmsN2QEMYAAFgIgI0FTwAAabI647.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698301.html\">LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-698301\">￥2899.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore6\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698303.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-N12430D 6公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img13.360buyimg.com/n4/g15/M03/1B/17/rBEhWFNnJPUIAAAAAAKH8aVIEMkAAM4PgBCB6UAAogJ874.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698303.html\">LG WD-N12430D 6公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-698303\">￥2349.00</strong>\r\n						</div>\r\n					</li>\r\n				</ul>\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"ranklist\" class=\"m m2\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n			<h2 style=\"font-size:14px;font-weight:400;\">\r\n				洗衣机排行榜\r\n			</h2>\r\n		</div>\r\n		<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<ul class=\"tab\">\r\n				<li class=\"curr\" style=\"text-align:center;color:#E4393C;background-color:#FFFFFF;font-weight:700;\">\r\n					同价位\r\n				</li>\r\n				<li style=\"text-align:center;color:#333333;background-color:#F7F7F7;\">\r\n					同品牌\r\n				</li>\r\n				<li style=\"text-align:center;color:#333333;background-color:#F7F7F7;\">\r\n					同类别\r\n				</li>\r\n			</ul>\r\n			<ul class=\"tabcon\">\r\n				<li class=\"fore1\">\r\n					1\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/609522.html\"><img height=\"50\" width=\"50\" src=\"http://img12.360buyimg.com/n5/g10/M00/1C/02/rBEQWFNaOCQIAAAAAAG9_mtdNmoAAFgHwJBRCcAAb4W939.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/609522.html\">三星(SAMSUNG) WF1702NCW/XSC 7公斤 滚筒洗衣机（白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-609522\">￥2299.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore2\">\r\n					2\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/698301.html\"><img height=\"50\" width=\"50\" src=\"http://img11.360buyimg.com/n5/g10/M00/1C/02/rBEQWFNaOG0IAAAAAAGmsN2QEMYAAFgIgI0FTwAAabI647.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/698301.html\">LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-698301\">￥2899.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore3\">\r\n					3\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/816528.html\"><img height=\"50\" width=\"50\" src=\"http://img13.360buyimg.com/n5/g12/M00/0B/1D/rBEQYVNZ6nUIAAAAAAHTERq_3BcAAFJzgGOpJQAAdMp856.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/816528.html\">西门子（SIEMENS） XQG60-WS10K1C00W 6公斤 3D正负洗系列 滚筒洗衣机（白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-816528\">￥3599.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore4\">\r\n					4\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/782194.html\"><img height=\"50\" width=\"50\" src=\"http://img14.360buyimg.com/n5/g13/M09/08/14/rBEhUlNY2_gIAAAAAAGJkqlbYpYAAMZTQBh29MAAYmq090.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/782194.html\">松下(panasonic) XQG52-M75201 5.2公斤 斜式滚筒洗衣机（白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-782194\">￥2099.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore5\">\r\n					5\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/895588.html\"><img height=\"50\" width=\"50\" src=\"http://img13.360buyimg.com/n5/g13/M06/08/14/rBEhVFNY380IAAAAAAGjGtfbB14AAMZeQHKBr0AAaMy314.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/895588.html\">西门子（SIEMENS） XQG70-WM12E2680W 7公斤 滚筒洗衣机（银色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-895588\">￥4199.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore6\">\r\n					6\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/997834.html\"><img height=\"50\" width=\"50\" src=\"http://img14.360buyimg.com/n5/g10/M00/1C/02/rBEQWFNaP50IAAAAAAGMSIVDV84AAFgPgGfg2gAAYxg172.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/997834.html\">西门子（SIEMENS） WM08E2C00W 7公斤滚筒洗衣机 （白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-997834\">￥3599.00</strong>\r\n					</div>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		<div id=\"buy-buy\" class=\"m m2 related-buy\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n			<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n				<h2 style=\"font-size:14px;font-weight:400;\">\r\n					购买了该商品的用户还购买了\r\n				</h2>\r\n			</div>\r\n			<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n				<ul>\r\n					<li class=\"fore1\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/850692.html\"><img height=\"100\" width=\"100\" alt=\"嘉沛（JIAPEI） WA-305Pro 冰箱洗衣机架/固定底座 (高低可调)\" src=\"http://img12.360buyimg.com/n4/g10/M00/1C/1C/rBEQWFNdu0QIAAAAAAG19nxYnoUAAFqVwKTfaQAAbYO358.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/850692.html\">嘉沛（JIAPEI） WA-305Pro 冰箱洗衣机架/固定底座 (高低可调)</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-850692\">￥128.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore2\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015324.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） KFR-35GW/05GDC23A 1.5匹壁挂式冷暖变频空调\" src=\"http://img14.360buyimg.com/n4/g13/M09/08/15/rBEhVFNY7WAIAAAAAADTuTnnj5kAAMZ9ACc62YAANPR744.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015324.html\">海尔（Haier） KFR-35GW/05GDC23A 1.5匹壁挂式冷暖变频空调</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015324\">￥2799.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore3\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015707.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier）EC6002-D 60升遥控电热水器\" src=\"http://img12.360buyimg.com/n4/g14/M02/02/08/rBEhVVNnWFAIAAAAAAFn30R0R_oAANBRQLB4PcAAWf3690.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015707.html\">海尔（Haier）EC6002-D 60升遥控电热水器</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015707\">￥1498.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore4\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/821655.html\"><img height=\"100\" width=\"100\" alt=\"乐歌(Loctek) PSW842M(26-52寸)旋转拉伸电视功能挂架/支架\" src=\"http://img10.360buyimg.com/n4/g14/M06/1F/18/rBEhVVNaNtUIAAAAAAHc3a1K0ckAAMh3gF_7QUAAdz1420.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/821655.html\">乐歌(Loctek) PSW842M(26-52寸)旋转拉伸电视功能挂架/支架</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-821655\">￥199.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore5\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/717250.html\"><img height=\"100\" width=\"100\" alt=\"美的 (Midea) 电子制冷 饮水机 MYD927S-W\" src=\"http://img10.360buyimg.com/n4/g16/M00/01/1A/rBEbRVNrWg4IAAAAAAEpgMSM8dwAAAWzwGJ1M0AASmY137.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/717250.html\">美的 (Midea) 电子制冷 饮水机 MYD927S-W</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-717250\">￥379.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore6\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/874319.html\"><img height=\"100\" width=\"100\" alt=\"美的（Midea） EM7KCGW3-NR 平板微波炉\" src=\"http://img14.360buyimg.com/n4/g17/M00/00/13/rBEbSFNqFvMIAAAAAAIGkTsnd6EAAAHkQK-QzIAAgap910.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/874319.html\">美的（Midea） EM7KCGW3-NR 平板微波炉</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-874319\">￥438.00</strong>\r\n						</div>\r\n					</li>\r\n				</ul>\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		<div id=\"browse-browse\" class=\"m m2 related-buy\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n			<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n				<h2 style=\"font-size:14px;font-weight:400;\">\r\n					浏览了该商品的用户还浏览了\r\n				</h2>\r\n			</div>\r\n			<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n				<ul>\r\n					<li class=\"fore1\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015662.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG60-B1226AW 6公斤 1200转 水晶系列变频滚筒洗衣机（瓷白色）\" src=\"http://img12.360buyimg.com/n4/g12/M00/0F/03/rBEQYVNmELkIAAAAAAHyQFVoRY4AAFerwHSFi4AAfJY645.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015662.html\">海尔（Haier） XQG60-B1226AW 6公斤 1200转 水晶系列变频滚筒洗衣机（瓷白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015662\">￥3899.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore2\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1069497.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG60-BS1086AM 6公斤 变频滚筒洗衣机\" src=\"http://img12.360buyimg.com/n4/g13/M0A/01/0A/rBEhU1NoeGcIAAAAAAMZpOXaofEAAM-KQKSb-8AAxm8158.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1069497.html\">海尔（Haier） XQG60-BS1086AM 6公斤 变频滚筒洗衣机</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1069497\">￥3099.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore3\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015650.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG70-1000J 7公斤 1000转滚筒洗衣机（银灰色）\" src=\"http://img10.360buyimg.com/n4/g10/M00/1C/02/rBEQWFNaM-gIAAAAAAHEkmKa3kMAAFgCAPtLXoAAcSq389.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015650.html\">海尔（Haier） XQG70-1000J 7公斤 1000转滚筒洗衣机（银灰色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015650\">￥1999.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore4\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698301.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img11.360buyimg.com/n4/g10/M00/1C/02/rBEQWFNaOG0IAAAAAAGmsN2QEMYAAFgIgI0FTwAAabI647.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698301.html\">LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-698301\">￥2899.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore5\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/895588.html\"><img height=\"100\" width=\"100\" alt=\"西门子（SIEMENS） XQG70-WM12E2680W 7公斤 滚筒洗衣机（银色）\" src=\"http://img13.360buyimg.com/n4/g13/M06/08/14/rBEhVFNY380IAAAAAAGjGtfbB14AAMZeQHKBr0AAaMy314.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/895588.html\">西门子（SIEMENS） XQG70-WM12E2680W 7公斤 滚筒洗衣机（银色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-895588\">￥4199.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore6\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/876668.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-N12435D 6公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img13.360buyimg.com/n4/g13/M03/09/0C/rBEhVFNdyPIIAAAAAAGCGiBpM18AAMjCACQRzoAAYIy355.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/876668.html\">LG WD-N12435D 6公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-876668\">￥2099.00</strong>\r\n						</div>\r\n					</li>\r\n				</ul>\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"miaozhen7886\" class=\"m\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<a href=\"http://c.fa.jd.com/adclick?sid=2&amp;cid=163&amp;aid=817&amp;bid=3147&amp;unit=29866&amp;advid=95489&amp;guv=&amp;url=http://e.cn.miaozhen.com/r.gif?k=1012922&amp;p=4+jSA0&amp;rt=2&amp;ns=[M_ADIP]&amp;ni=[M_IESID]&amp;na=[M_MAC]&amp;o=http://sale.jd.com/act/P2oMfuidjRr10wsE.html\" target=\"_blank\"><img width=\"211\" height=\"261\" src=\"http://img11.360buyimg.com/da/jfs/t157/216/441872528/18241/5d272345/538d51fdN29a86e05.jpg\" class=\"loading-style2\" /></a>\r\n	</div>\r\n	<div id=\"miaozhen10767\" class=\"m\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<a href=\"http://c.fa.jd.com/adclick?sid=2&amp;cid=163&amp;aid=818&amp;bid=2947&amp;unit=28576&amp;advid=96247&amp;guv=&amp;url=http://jmall.jd.com/shop/p129940/index.html?erpad_source=erpad\" target=\"_blank\"><img width=\"211\" height=\"261\" alt=\"\" src=\"http://img13.360buyimg.com/da/jfs/t205/61/637500449/23385/6d479db/539524e1Nc8892389.jpg\" class=\"loading-style2\" /></a>\r\n	</div>\r\n	<div id=\"ad_market_1\" class=\"m\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div style=\"margin:0px;padding:0px;\">\r\n			<img id=\"tracker_banner45b34482-ae79-4feb-95c7-28eb79cc2d9b\" width=\"0\" height=\"0\" border=\"0\" src=\"http://x.jd.com/dsp/np?log=VLikGDCsgoBvQrY6FOANYuekrtHPkiO8++O4zBTXUEXMZir0ZwsFPbpSIz0SM3d8IPL9jxA26rE3R+n6klF3wecKlWrR/83eE18PR4AnluGhBvahZAWn6TQRj1Jp0Jyy353Xe1m/GPXrHBo2rddQ5i/7y8ywXRy6evvzcVdpd7ziUdd3I7WuE/NWW9CuQHcndzomCTWla9CyhnP0U78lI1lWEme8MLkVo+Wgz1bxolpvrjz+VWP32fd6/kSDCt6m0/BW6Fn+RAD4ED55xE2ICg==&amp;v=2\" />\r\n			<div id=\"jd_banner45b34482-ae79-4feb-95c7-28eb79cc2d9b\" style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('26', '2014夏装新款韩版修身女装欧根纱短袖连衣裙', 'L00734', '1', '99.80', '57.00', '', '0000-00-00 00:00:00', '1', '0', '0');
INSERT INTO `tour_product` VALUES ('32', '淑女圆领雪纺衫女短裙套装套裤两件套', '123', '10000', '100.00', '0.00', '', '0000-00-00 00:00:00', '1', '0', '0');
INSERT INTO `tour_product` VALUES ('53', '商品名称4343', '4324234', '10000', '100.00', '79.00', '', '0000-00-00 00:00:00', '1', '0', '7');
INSERT INTO `tour_product` VALUES ('54', '商品名称1PHP获取目录和的方法通过魔术变量', '321313', '10000', '100.00', '81.00', '', '0000-00-00 00:00:00', '1', '0', '23');
INSERT INTO `tour_product` VALUES ('55', '商品名称1312321312', '', '10000', '100.00', '82.00', '', '0000-00-00 00:00:00', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('56', '商品名称1231232', '321312321', '10000', '100.00', '83.00', '', '0000-00-00 00:00:00', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('59', '商品名称1PHP获取目录和的方法通过魔术变量11', '123123', '10000', '100.00', '84.00', '', '2016-08-21 11:44:08', '1', '0', '2');
INSERT INTO `tour_product` VALUES ('60', '商品名称34', '21312313123', '10000', '100.00', '85.00', '', '2016-08-22 21:34:45', '1', '0', '2');
INSERT INTO `tour_product` VALUES ('61', '商品名称1213213213', '', '10000', '100.00', '86.00', '', '2016-08-23 21:53:18', '1', '0', '23');

-- ----------------------------
-- Table structure for tour_publish_table
-- ----------------------------
DROP TABLE IF EXISTS `tour_publish_table`;
CREATE TABLE `tour_publish_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `software_name` varchar(128) DEFAULT NULL COMMENT '软件名',
  `software_zh` varchar(128) DEFAULT NULL,
  `version_num` varchar(32) DEFAULT NULL COMMENT '版本号',
  `size` varchar(128) DEFAULT NULL COMMENT '文件大小',
  `download_num` varchar(128) DEFAULT NULL COMMENT '上传文件本身名称',
  `url` text COMMENT 'url',
  `publish_time` varchar(128) DEFAULT NULL COMMENT '发布日期',
  `description` text COMMENT '说明',
  `belongs_stage` varchar(128) DEFAULT NULL COMMENT '平台',
  `sha1` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_publish_table
-- ----------------------------
INSERT INTO `tour_publish_table` VALUES ('173', '', '', '', '51563', null, '/ThinkPhpStudy/Uploads/_v.rar', '1471162517', '', 'Windows', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('174', '', '', '', '51563', null, '/ThinkPhpStudy/Uploads/_v.rar', '1471162910', '', 'Windows', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('175', '', '', '', '51563', null, '/ThinkPhpStudy/Uploads/_v.rar', '1471163886', '', 'Windows', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('176', '', '', '', '51563', null, '/ThinkPhpStudy/Uploads/_v.rar', '1471163901', '', 'Windows', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('177', '', '', '', '51563', null, '/ThinkPhpStudy/Uploads/_v.rar', '1471163970', '', '', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('178', '', '', '', '51563', null, '/ThinkPhpStudy/Uploads/_v.rar', '1471164161', '', '', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('179', '', '', '', '51563', null, '/ThinkPhpStudy/Uploads/_v9629.rar', '1471164217', '', '', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('180', 'HTML', 'RtmpDevice', '1.0', '51563', null, '/ThinkPhpStudy/Uploads/HTML/HTML_v8528.rar', '1471164321', '', '', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('181', 'FDSF', '钻石小鸟2016简洁版单独数据包', '1.0', '51563', null, '/ThinkPhpStudy/Uploads/FDSF/FDSF_v4855.rar', '1471164368', '23123', '', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('182', '', '', '', '3905', null, '/ThinkPhpStudy/Uploads/_v6365.rar', '1471164736', '', '', 'd141976c9dd491b1a51635578276b30e694fffd0');
INSERT INTO `tour_publish_table` VALUES ('183', 'HTML', 'RtmpDevice', '1.0', '12708064', null, '/ThinkPhpStudy/Uploads/HTML/HTML_v6822.zip', '1471164893', '23123', '', 'f3b8b56fbea16a9506bd91c11e5c7cc346011252');
INSERT INTO `tour_publish_table` VALUES ('184', 'FDSF', 'RtmpDevice', '1.0', '51563', null, '/ThinkPhpStudy/Uploads/FDSF/FDSF_v1.0.rar', '1471165052', '23123', '', '49200676cec8081eadbcd0a4357d29264d7e65a5');
INSERT INTO `tour_publish_table` VALUES ('185', 'App1', '钻石小鸟2016简洁版单独数据包', '1.0', '4874947', null, '/ThinkPhpStudy/Uploads/App1/App1_v1.0.zip', '1471165193', '23123', '', 'a276a2578f14e9e799f7da561c9f0ac938dea5a4');
INSERT INTO `tour_publish_table` VALUES ('186', 'HTML', 'RtmpDevice', '1.0', '3905', null, '/ThinkPhpStudy/Uploads/HTML/HTML_v1.0.rar', '1471166318', '23123', 'Linux', 'd141976c9dd491b1a51635578276b30e694fffd0');
INSERT INTO `tour_publish_table` VALUES ('187', 'HTML', 'RtmpDevice', '0.1', '12708064', null, '/ThinkPhpStudy/Uploads/HTML/HTML_v0.1.zip', '1471166415', '23123', 'Mac', 'f3b8b56fbea16a9506bd91c11e5c7cc346011252');
INSERT INTO `tour_publish_table` VALUES ('188', '文件中文名称', '文件中文名称', '1.0', '48632', null, '/ThinkPhpStudy/Uploads/', '1471263617', '文件中文名称文件中文名称', 'Windows', 'd4229ddf9fef242f668daffcbeaef7f673183d17');
INSERT INTO `tour_publish_table` VALUES ('189', 'APP', 'APP', 'APP', '48632', null, '/ThinkPhpStudy/Uploads/APP/APP_vAPP.jpg', '1471263925', '1.0', 'Android', 'd4229ddf9fef242f668daffcbeaef7f673183d17');
INSERT INTO `tour_publish_table` VALUES ('190', '系统设置', '系统设置', '1.0', '43293', null, '/ThinkPhpStudy/Uploads/', '1471264058', '系统设置系统设置', 'Mac', '821c78d657bff1ef9aae4cff2717697cc68d5b1a');
INSERT INTO `tour_publish_table` VALUES ('191', '系统设置1', '系统设置1', '1.0', '91462', null, '/ThinkPhpStudy/Uploads/', '1471264118', '系统设置', 'Windows', '2383ec61464647f3d68c45adbda4f28da5a94ac0');
INSERT INTO `tour_publish_table` VALUES ('192', 'Home', '系统设置', '1.1.1', '60472', null, '/ThinkPhpStudy/Uploads/Home/Home_v1.1.1.jpg', '1471264159', '系统设置系统设置', 'Android', 'bb5bea9896e581db18b2f08fe06755fb009645ec');

-- ----------------------------
-- Table structure for tour_user
-- ----------------------------
DROP TABLE IF EXISTS `tour_user`;
CREATE TABLE `tour_user` (
  `user_id` int(100) NOT NULL AUTO_INCREMENT,
  `parent_id` int(128) DEFAULT '2',
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `apikey_value` varchar(60) DEFAULT NULL,
  `apikey_time` varchar(60) DEFAULT NULL,
  `logintime` varchar(128) DEFAULT NULL,
  `loginip` varchar(128) DEFAULT '127.0.0.1',
  `status` int(2) DEFAULT '0',
  `description` text,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_user
-- ----------------------------
INSERT INTO `tour_user` VALUES ('8', '0', 'Administrator', '21232f297a57a5a743894a0e4a801fc3', '007c91306de15735ad90b7d5633556d5b0633429', '1452649122', null, null, '1', null);
INSERT INTO `tour_user` VALUES ('18', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '99809701ba179cae883a32db741422c20eda4b9d', '1453168690', '1471962846', '127.0.0.1', '1', null);
INSERT INTO `tour_user` VALUES ('26', '2', 'Tinywan', 'e10adc3949ba59abbe56e057f20f883e', 'a8ea378110bdf3d4114de976a27b5a263da26d73', '1453077060', null, '127.0.0.1', '0', null);

-- ----------------------------
-- Table structure for version_app
-- ----------------------------
DROP TABLE IF EXISTS `version_app`;
CREATE TABLE `version_app` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(10) DEFAULT NULL COMMENT 'APP类型名称  如 ： 安卓手机',
  `is_encryption` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加密 1加密 0不加密',
  `key` varchar(20) NOT NULL DEFAULT '0' COMMENT '加密key',
  `image_size` text COMMENT '按json_encode存储',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of version_app
-- ----------------------------
