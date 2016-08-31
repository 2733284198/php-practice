/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : tp5

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-08-31 16:06:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bjyadmin_admin_nav`
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
-- Table structure for `bjyadmin_alipay_order`
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
-- Table structure for `bjyadmin_auth_group`
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
-- Table structure for `bjyadmin_auth_group_access`
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
-- Table structure for `bjyadmin_auth_rule`
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
-- Table structure for `bjyadmin_oauth_user`
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
-- Table structure for `bjyadmin_order`
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
-- Table structure for `bjyadmin_province_city_area`
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
INSERT INTO `bjyadmin_province_city_area` VALUES ('2025', '2023', '江东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2026', '2023', '城南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2027', '2023', '城北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2028', '2023', '郊   区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2029', '2023', '南岳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2030', '2023', '衡阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2031', '2023', '衡南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2032', '2023', '衡山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2033', '2023', '衡东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2034', '2023', '祁东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2035', '2023', '耒阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2036', '2023', '常宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2037', '1993', '邵阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2038', '2037', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2039', '2037', '双清区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2040', '2037', '大祥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2041', '2037', '北塔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2042', '2037', '邵东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2043', '2037', '新邵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2044', '2037', '邵阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2045', '2037', '隆回县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2046', '2037', '洞口县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2047', '2037', '绥宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2048', '2037', '新宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2049', '2037', '城步苗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2050', '2037', '武冈市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2051', '1993', '岳阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2052', '2051', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2053', '2051', '岳阳楼区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2054', '2051', '云溪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2055', '2051', '君山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2056', '2051', '岳阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2057', '2051', '华容县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2058', '2051', '湘阴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2059', '2051', '平江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2060', '2051', '汨罗市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2061', '2051', '临湘市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2062', '1993', '常德');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2063', '2062', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2064', '2062', '武陵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2065', '2062', '鼎城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2066', '2062', '安乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2067', '2062', '汉寿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2068', '2062', '澧  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2069', '2062', '临澧县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2070', '2062', '桃源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2071', '2062', '石门县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2072', '2062', '津市市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2073', '1993', '张家界');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2074', '2073', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2075', '2073', '永定区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2076', '2073', '武陵源区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2077', '2073', '慈利县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2078', '2073', '桑植县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2079', '1993', '益阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2080', '2079', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2081', '2079', '资阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2082', '2079', '赫山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2083', '2079', '南  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2084', '2079', '桃江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2085', '2079', '安化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2086', '2079', '沅江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2087', '1993', '郴州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2088', '2087', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2089', '2087', '北湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2090', '2087', '苏仙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2091', '2087', '桂阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2092', '2087', '宜章县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2093', '2087', '永兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2094', '2087', '嘉禾县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2095', '2087', '临武县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2096', '2087', '汝城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2097', '2087', '桂东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2098', '2087', '安仁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2099', '2087', '资兴市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2100', '1993', '永州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2101', '2100', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2102', '2100', '芝山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2103', '2100', '冷水滩区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2104', '2100', '祁阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2105', '2100', '东安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2106', '2100', '双牌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2107', '2100', '道  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2108', '2100', '江永县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2109', '2100', '宁远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2110', '2100', '蓝山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2111', '2100', '新田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2112', '2100', '江华瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2113', '1993', '怀化');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2114', '2113', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2115', '2113', '鹤城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2116', '2113', '中方县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2117', '2113', '沅陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2118', '2113', '辰溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2119', '2113', '溆浦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2120', '2113', '会同县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2121', '2113', '麻阳苗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2122', '2113', '新晃侗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2123', '2113', '芷江侗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2125', '2113', '通道侗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2126', '2113', '洪江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2127', '1993', '娄底');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2128', '2127', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2129', '2127', '娄星区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2130', '2127', '双峰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2131', '2127', '新化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2132', '2127', '冷水江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2133', '2127', '涟源市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2135', '2134', '吉首市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2136', '2134', '泸溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2137', '2134', '凤凰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2138', '2134', '花垣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2139', '2134', '保靖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2140', '2134', '古丈县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2141', '2134', '永顺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2142', '2134', '龙山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2143', '0', '广东');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2144', '2143', '广州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2145', '2144', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2146', '2144', '东山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2147', '2144', '荔湾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2148', '2144', '越秀区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2149', '2144', '海珠区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2150', '2144', '天河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2151', '2144', '芳村区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2152', '2144', '白云区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2153', '2144', '黄埔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2154', '2144', '番禺区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2155', '2144', '花都区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2156', '2144', '增城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2157', '2144', '从化市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2158', '2143', '韶关');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2159', '2158', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2160', '2158', '北江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2161', '2158', '武江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2162', '2158', '浈江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2163', '2158', '曲江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2164', '2158', '始兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2165', '2158', '仁化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2166', '2158', '翁源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2167', '2158', '乳源瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2168', '2158', '新丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2169', '2158', '乐昌市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2170', '2158', '南雄市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2171', '2143', '深圳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2172', '2171', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2173', '2171', '罗湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2174', '2171', '福田区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2175', '2171', '南山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2176', '2171', '宝安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2177', '2171', '龙岗区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2178', '2171', '盐田区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2179', '2143', '珠海');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2180', '2179', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2181', '2179', '香洲区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2182', '2179', '斗门县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2183', '2143', '汕头');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2184', '2183', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2185', '2183', '达濠区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2186', '2183', '龙湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2187', '2183', '金园区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2188', '2183', '升平区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2189', '2183', '河浦区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2190', '2183', '南澳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2191', '2183', '潮阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2192', '2183', '澄海市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2193', '2143', '佛山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2194', '2193', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2195', '2193', '城  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2196', '2193', '石湾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2197', '2193', '顺德市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2198', '2193', '南海市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2199', '2193', '三水市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2200', '2193', '高明市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2201', '2143', '江门');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2202', '2201', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2203', '2201', '蓬江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2204', '2201', '江海区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2205', '2201', '台山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2206', '2201', '新会市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2207', '2201', '开平市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2208', '2201', '鹤山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2209', '2201', '恩平市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2210', '2143', '湛江');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2211', '2210', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2212', '2210', '赤坎区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2213', '2210', '霞山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2214', '2210', '坡头区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2215', '2210', '麻章区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2216', '2210', '遂溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2217', '2210', '徐闻县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2218', '2210', '廉江市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2219', '2210', '雷州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2220', '2210', '吴川市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2221', '2143', '茂名');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2222', '2221', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2223', '2221', '茂南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2224', '2221', '电白县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2225', '2221', '高州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2226', '2221', '化州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2227', '2221', '信宜市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2228', '2143', '肇庆');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2229', '2228', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2230', '2228', '端州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2231', '2228', '鼎湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2232', '2228', '广宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2233', '2228', '怀集县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2234', '2228', '封开县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2235', '2228', '德庆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2236', '2228', '高要市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2237', '2228', '四会市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2238', '2143', '惠州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2239', '2238', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2240', '2238', '惠城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2241', '2238', '博罗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2242', '2238', '惠东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2243', '2238', '龙门县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2244', '2238', '惠阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2245', '2143', '梅州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2246', '2245', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2247', '2245', '梅江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2248', '2245', '梅  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2249', '2245', '大埔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2250', '2245', '丰顺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2251', '2245', '五华县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2252', '2245', '平远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2253', '2245', '蕉岭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2254', '2245', '兴宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2255', '2143', '汕尾');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2256', '2255', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2257', '2255', '城  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2258', '2255', '海丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2259', '2255', '陆河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2260', '2255', '陆丰市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2261', '2143', '河源');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2262', '2261', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2263', '2261', '源城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2264', '2261', '紫金县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2265', '2261', '龙川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2266', '2261', '连平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2267', '2261', '和平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2268', '2261', '东源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2269', '2143', '阳江');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2270', '2269', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2271', '2269', '江城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2272', '2269', '阳西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2273', '2269', '阳东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2274', '2269', '阳春市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2275', '2143', '清远');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2276', '2275', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2277', '2275', '清城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2278', '2275', '佛冈县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2279', '2275', '阳山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2281', '2275', '连南瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2282', '2275', '清新县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2283', '2275', '英德市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2284', '2275', '连州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2285', '2143', '东莞');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2286', '2285', '莞城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2287', '2285', '东城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2288', '2285', '南城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2289', '2285', '万江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2290', '2143', '中山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2291', '2290', '石岐区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2292', '2290', '东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2293', '2290', '西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2294', '2290', '南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2295', '2290', '五桂山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2296', '2143', '潮州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2297', '2296', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2298', '2296', '湘桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2299', '2296', '潮安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2300', '2296', '饶平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2301', '2143', '揭阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2302', '2301', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2303', '2301', '榕城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2304', '2301', '揭东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2305', '2301', '揭西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2306', '2301', '惠来县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2307', '2301', '普宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2308', '2143', '云浮');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2309', '2308', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2310', '2308', '云城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2311', '2308', '新兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2312', '2308', '郁南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2313', '2308', '云安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2314', '2308', '罗定市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2315', '0', '广西');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2316', '2315', '南宁');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2317', '2316', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2318', '2316', '兴宁区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2319', '2316', '新城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2320', '2316', '城北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2321', '2316', '江南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2322', '2316', '永新区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2323', '2316', '市郊区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2324', '2316', '邕宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2325', '2316', '武鸣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2326', '2315', '柳州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2327', '2326', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2328', '2326', '城中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2329', '2326', '鱼峰区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2330', '2326', '柳南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2331', '2326', '柳北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2332', '2326', '市郊区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2333', '2326', '柳江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2334', '2326', '柳城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2335', '2315', '桂林');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2336', '2335', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2337', '2335', '秀峰区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2338', '2335', '叠彩区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2339', '2335', '象山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2340', '2335', '七星区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2341', '2335', '雁山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2342', '2335', '阳朔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2343', '2335', '临桂县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2344', '2335', '灵川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2345', '2335', '全州县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2346', '2335', '兴安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2347', '2335', '永福县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2348', '2335', '灌阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2349', '2335', '龙胜各县自治区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2350', '2335', '资源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2351', '2335', '平乐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2352', '2335', '荔蒲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2353', '2335', '恭城瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2354', '2315', '梧州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2355', '2354', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2356', '2354', '万秀区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2357', '2354', '蝶山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2358', '2354', '市郊区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2359', '2354', '苍梧县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2360', '2354', '藤  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2361', '2354', '蒙山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2362', '2354', '岑溪市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2363', '2315', '北海');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2364', '2363', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2365', '2363', '海城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2366', '2363', '银海区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2367', '2363', '铁山港区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2368', '2363', '合浦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2369', '2315', '防城港');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2370', '2369', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2371', '2369', '港口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2372', '2369', '防城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2373', '2369', '上思县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2374', '2369', '东兴市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2375', '2315', '钦州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2376', '2375', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2377', '2375', '钦南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2378', '2375', '钦北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2379', '2375', '浦北县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2380', '2375', '灵山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2381', '2315', '贵港');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2382', '2381', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2383', '2381', '港北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2384', '2381', '港南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2385', '2381', '平南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2386', '2381', '桂平市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2387', '2315', '玉林');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2388', '2387', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2389', '2387', '玉州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2390', '2387', '容  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2391', '2387', '陆川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2392', '2387', '博白县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2393', '2387', '兴业县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2394', '2387', '北流市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2395', '2315', '南宁地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2396', '2395', '凭祥市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2397', '2395', '横  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2398', '2395', '宾阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2399', '2395', '上林县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2400', '2395', '隆安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2401', '2395', '马山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2402', '2395', '扶绥县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2403', '2395', '崇左县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2404', '2395', '大新县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2405', '2395', '天等县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2406', '2395', '宁明县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2407', '2395', '龙州县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2408', '2315', '柳州地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2409', '2408', '合山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2410', '2408', '鹿寨县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2411', '2408', '象州县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2412', '2408', '武宣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2413', '2408', '来宾县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2414', '2408', '融安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2415', '2408', '三江侗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2416', '2408', '融水苗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2417', '2408', '金秀瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2418', '2408', '忻城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2419', '2315', '贺州地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2420', '2419', '贺州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2421', '2419', '昭平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2422', '2419', '钟山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2423', '2419', '富川瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2424', '2315', '百色地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2425', '2424', '百色市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2426', '2424', '田阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2427', '2424', '田东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2428', '2424', '平果县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2429', '2424', '德保县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2430', '2424', '靖西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2431', '2424', '那坡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2432', '2424', '凌云县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2433', '2424', '乐业县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2434', '2424', '田林县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2435', '2424', '隆林各族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2436', '2424', '西林县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2437', '2315', '河池地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2438', '2437', '河池市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2439', '2437', '宜州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2440', '2437', '罗城仫佬族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2441', '2437', '环江毛南族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2442', '2437', '南丹县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2443', '2437', '天峨县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2444', '2437', '凤山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2445', '2437', '东兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2446', '2437', '巴马瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2447', '2437', '都安瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2448', '2437', '大化瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2449', '0', '海南');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2450', '2449', '海南');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2451', '2450', '通什市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2452', '2450', '琼海市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2453', '2450', '儋州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2454', '2450', '琼山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2455', '2450', '文昌市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2456', '2450', '万宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2457', '2450', '东方市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2458', '2450', '定安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2459', '2450', '屯昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2460', '2450', '澄迈县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2461', '2450', '临高县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2462', '2450', '白沙黎族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2463', '2450', '昌江黎族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2464', '2450', '乐东黎族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2465', '2450', '陵水黎族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2468', '2450', '西沙群岛');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2469', '2450', '南沙群岛');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2471', '2449', '海口');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2472', '2471', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2473', '2471', '振东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2474', '2471', '新华区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2475', '2471', '秀英区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2476', '2449', '三亚');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2477', '2476', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2478', '0', '重庆');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2479', '2478', '重庆市辖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2480', '2479', '万州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2481', '2479', '涪陵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2482', '2479', '渝中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2483', '2479', '大渡口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2484', '2479', '江北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2485', '2479', '沙坪坝区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2486', '2479', '九龙坡区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2487', '2479', '南岸区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2488', '2479', '北碚区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2489', '2479', '万盛区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2490', '2479', '双桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2491', '2479', '渝北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2492', '2479', '巴南区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2493', '2479', '黔江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2494', '2478', '重庆县辖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2495', '2494', '长寿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2496', '2494', '綦江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2497', '2494', '潼南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2498', '2494', '铜梁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2499', '2494', '大足县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2500', '2494', '荣昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2501', '2494', '璧山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2502', '2494', '梁平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2503', '2494', '城口县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2504', '2494', '丰都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2505', '2494', '垫江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2506', '2494', '武隆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2507', '2494', '忠  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2508', '2494', '开  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2509', '2494', '云阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2510', '2494', '奉节县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2511', '2494', '巫山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2512', '2494', '巫溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2513', '2494', '石柱土家族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2517', '2478', '重庆县级');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2518', '2517', '江津市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2519', '2517', '合川市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2520', '2517', '永川市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2521', '2517', '南川市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2522', '0', '四川');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2523', '2522', '成都');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2524', '2523', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2525', '2523', '高新区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2526', '2523', '锦江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2527', '2523', '青羊区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2528', '2523', '金牛区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2529', '2523', '武侯区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2530', '2523', '成华区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2531', '2523', '龙泉驿区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2532', '2523', '青白江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2533', '2523', '金堂县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2534', '2523', '双流县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2535', '2523', '温江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2536', '2523', '郫  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2537', '2523', '新都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2538', '2523', '大邑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2539', '2523', '蒲江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2540', '2523', '新津县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2541', '2523', '都江堰市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2542', '2523', '彭州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2543', '2523', '邛崃市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2544', '2523', '崇州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2545', '2522', '自贡');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2546', '2545', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2547', '2545', '自流井区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2548', '2545', '贡井区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2549', '2545', '大安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2550', '2545', '沿滩区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2551', '2545', '荣  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2552', '2545', '富顺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2553', '2522', '攀枝花');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2554', '2553', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2555', '2553', '东  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2556', '2553', '西  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2557', '2553', '仁和区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2558', '2553', '米易县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2559', '2553', '盐边县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2560', '2522', '泸州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2561', '2560', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2562', '2560', '江阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2563', '2560', '纳溪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2564', '2560', '龙马潭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2565', '2560', '泸  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2566', '2560', '合江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2567', '2560', '叙永县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2568', '2560', '古蔺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2569', '2522', '德阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2570', '2569', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2571', '2569', '旌阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2572', '2569', '中江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2573', '2569', '罗江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2574', '2569', '广汉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2575', '2569', '什邡市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2576', '2569', '绵竹市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2577', '2522', '绵阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2578', '2577', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2579', '2577', '涪城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2580', '2577', '游仙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2581', '2577', '科学城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2582', '2577', '三台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2583', '2577', '盐亭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2584', '2577', '安  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2585', '2577', '梓潼县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2586', '2577', '北川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2587', '2577', '平武县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2588', '2577', '江油市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2589', '2522', '广元');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2590', '2589', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2591', '2589', '市中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2592', '2589', '元坝区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2593', '2589', '朝天区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2594', '2589', '旺苍县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2595', '2589', '青川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2596', '2589', '剑阁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2597', '2589', '苍溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2598', '2522', '遂宁');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2599', '2598', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2600', '2598', '市中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2601', '2598', '蓬溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2602', '2598', '射洪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2603', '2598', '大英县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2604', '2522', '内江');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2605', '2604', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2606', '2604', '市中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2607', '2604', '东兴区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2608', '2604', '威远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2609', '2604', '资中县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2610', '2604', '隆昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2611', '2522', '乐山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2612', '2611', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2613', '2611', '市中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2614', '2611', '沙湾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2615', '2611', '五通桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2616', '2611', '金口河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2617', '2611', '犍为县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2618', '2611', '井研县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2619', '2611', '夹江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2620', '2611', '沐川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2621', '2611', '峨边彝族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2622', '2611', '马边彝族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2623', '2611', '峨眉山市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2624', '2522', '南充');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2625', '2624', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2626', '2624', '顺庆区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2627', '2624', '高坪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2628', '2624', '嘉陵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2629', '2624', '南部县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2630', '2624', '营山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2631', '2624', '蓬安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2632', '2624', '仪陇县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2633', '2624', '西充县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2634', '2624', '阆中市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2635', '2522', '眉山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2636', '2635', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2637', '2635', '东坡区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2638', '2635', '仁寿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2639', '2635', '彭山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2640', '2635', '洪雅县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2641', '2635', '丹棱县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2642', '2635', '青神县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2643', '2522', '宜宾');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2644', '2643', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2645', '2643', '翠屏区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2646', '2643', '宜宾县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2647', '2643', '南溪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2648', '2643', '江安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2649', '2643', '长宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2650', '2643', '高  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2651', '2643', '珙  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2652', '2643', '筠连县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2653', '2643', '兴文县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2654', '2643', '屏山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2655', '2522', '广安');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2656', '2655', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2657', '2655', '广安区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2658', '2655', '岳池县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2659', '2655', '武胜县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2660', '2655', '邻水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2661', '2655', '华蓥市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2662', '2522', '达州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2663', '2662', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2664', '2662', '通川区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2665', '2662', '达  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2666', '2662', '宣汉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2667', '2662', '开江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2668', '2662', '大竹县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2669', '2662', '渠  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2670', '2662', '万源市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2671', '2522', '雅安');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2672', '2671', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2673', '2671', '雨城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2674', '2671', '名山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2675', '2671', '荥经县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2676', '2671', '汉源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2677', '2671', '石棉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2678', '2671', '天全县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2679', '2671', '芦山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2680', '2671', '宝兴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2681', '2522', '巴中');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2682', '2681', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2683', '2681', '巴州区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2684', '2681', '通江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2685', '2681', '南江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2686', '2681', '平昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2687', '2522', '资阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2688', '2687', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2689', '2687', '雁江区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2690', '2687', '安岳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2691', '2687', '乐至县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2692', '2687', '简阳市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2694', '2693', '汶川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2695', '2693', '理  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2696', '2693', '茂  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2697', '2693', '松潘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2698', '2693', '九寨沟县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2699', '2693', '金川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2700', '2693', '小金县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2701', '2693', '黑水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2702', '2693', '马尔康县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2703', '2693', '壤塘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2704', '2693', '阿坝县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2705', '2693', '若尔盖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2706', '2693', '红原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2707', '2522', '甘孜藏族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2708', '2707', '康定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2709', '2707', '泸定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2710', '2707', '丹巴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2711', '2707', '九龙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2712', '2707', '雅江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2713', '2707', '道孚县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2714', '2707', '炉霍县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2715', '2707', '甘孜县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2716', '2707', '新龙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2717', '2707', '德格县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2718', '2707', '白玉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2719', '2707', '石渠县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2720', '2707', '色达县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2721', '2707', '理塘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2722', '2707', '巴塘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2723', '2707', '乡城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2724', '2707', '稻城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2725', '2707', '得荣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2726', '2522', '凉山彝族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2727', '2726', '西昌市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2728', '2726', '木里藏族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2729', '2726', '盐源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2730', '2726', '德昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2731', '2726', '会理县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2732', '2726', '会东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2733', '2726', '宁南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2734', '2726', '普格县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2735', '2726', '布拖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2736', '2726', '金阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2737', '2726', '昭觉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2738', '2726', '喜德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2739', '2726', '冕宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2740', '2726', '越西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2741', '2726', '甘洛县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2742', '2726', '美姑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2743', '2726', '雷波县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2744', '0', '贵州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2745', '2744', '贵阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2746', '2745', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2747', '2745', '南明区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2748', '2745', '云岩区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2749', '2745', '花溪区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2750', '2745', '乌当区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2751', '2745', '白云区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2752', '2745', '小河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2753', '2745', '开阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2754', '2745', '息烽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2755', '2745', '修文县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2756', '2745', '清镇市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2757', '2744', '六盘水');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2758', '2757', '钟山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2759', '2757', '六枝特区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2760', '2757', '水城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2761', '2757', '盘  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2762', '2744', '遵义');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2763', '2762', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2764', '2762', '红花岗区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2765', '2762', '遵义县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2766', '2762', '桐梓县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2767', '2762', '绥阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2768', '2762', '正安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2771', '2762', '凤冈县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2772', '2762', '湄潭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2773', '2762', '余庆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2774', '2762', '习水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2775', '2762', '赤水市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2776', '2762', '仁怀市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2777', '2744', '安顺');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2778', '2777', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2779', '2777', '西秀区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2780', '2777', '平坝县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2781', '2777', '普定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2785', '2744', '铜仁地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2786', '2785', '铜仁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2787', '2785', '江口县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2788', '2785', '玉屏侗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2789', '2785', '石阡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2790', '2785', '思南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2792', '2785', '德江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2793', '2785', '沿河土家族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2794', '2785', '松桃苗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2795', '2785', '万山特区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2797', '2796', '兴义市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2798', '2796', '兴仁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2799', '2796', '普安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2800', '2796', '晴隆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2801', '2796', '贞丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2802', '2796', '望谟县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2803', '2796', '册亨县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2804', '2796', '安龙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2805', '2744', '毕节地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2806', '2805', '毕节市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2807', '2805', '大方县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2808', '2805', '黔西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2809', '2805', '金沙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2810', '2805', '织金县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2811', '2805', '纳雍县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2813', '2805', '赫章县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2815', '2814', '凯里市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2816', '2814', '黄平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2817', '2814', '施秉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2818', '2814', '三穗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2819', '2814', '镇远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2820', '2814', '岑巩县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2821', '2814', '天柱县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2822', '2814', '锦屏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2823', '2814', '剑河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2824', '2814', '台江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2825', '2814', '黎平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2826', '2814', '榕江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2827', '2814', '从江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2828', '2814', '雷山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2829', '2814', '麻江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2830', '2814', '丹寨县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2832', '2831', '都匀市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2833', '2831', '福泉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2834', '2831', '荔波县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2835', '2831', '贵定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2836', '2831', '瓮安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2837', '2831', '独山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2838', '2831', '平塘县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2839', '2831', '罗甸县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2840', '2831', '长顺县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2841', '2831', '龙里县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2842', '2831', '惠水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2843', '2831', '三都水族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2844', '0', '云南');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2845', '2844', '昆明');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2846', '2845', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2847', '2845', '五华区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2848', '2845', '盘龙区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2849', '2845', '官渡区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2850', '2845', '西山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2851', '2845', '东川区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2852', '2845', '呈贡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2853', '2845', '晋宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2854', '2845', '富民县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2855', '2845', '宜良县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2856', '2845', '石林彝族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2857', '2845', '嵩明县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2860', '2845', '安宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2861', '2844', '曲靖');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2862', '2861', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2863', '2861', '麒麟区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2864', '2861', '马龙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2865', '2861', '陆良县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2866', '2861', '师宗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2867', '2861', '罗平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2868', '2861', '富源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2869', '2861', '会泽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2870', '2861', '沾益县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2871', '2861', '宣威市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2872', '2844', '玉溪');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2873', '2872', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2874', '2872', '红塔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2875', '2872', '江川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2876', '2872', '澄江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2877', '2872', '通海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2878', '2872', '华宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2879', '2872', '易门县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2880', '2872', '峨山彝族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2883', '2844', '保山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2884', '2883', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2885', '2883', '隆阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2886', '2883', '施甸县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2887', '2883', '腾冲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2888', '2883', '龙陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2889', '2883', '昌宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2890', '2844', '昭通地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2891', '2890', '昭通市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2892', '2890', '鲁甸县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2893', '2890', '巧家县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2894', '2890', '盐津县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2895', '2890', '大关县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2896', '2890', '永善县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2897', '2890', '绥江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2898', '2890', '镇雄县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2899', '2890', '彝良县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2900', '2890', '威信县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2901', '2890', '水富县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2902', '2844', '楚雄彝族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2903', '2902', '楚雄市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2904', '2902', '双柏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2905', '2902', '牟定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2906', '2902', '南华县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2907', '2902', '姚安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2908', '2902', '大姚县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2909', '2902', '永仁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2910', '2902', '元谋县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2911', '2902', '武定县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2912', '2902', '禄丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2914', '2913', '个旧市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2915', '2913', '开远市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2916', '2913', '蒙自县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2917', '2913', '屏边苗族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2918', '2913', '建水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2919', '2913', '石屏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2920', '2913', '弥勒县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2921', '2913', '泸西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2922', '2913', '元阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2923', '2913', '红河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2925', '2913', '绿春县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2926', '2913', '河口瑶族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2928', '2927', '文山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2929', '2927', '砚山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2930', '2927', '西畴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2931', '2927', '麻栗坡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2932', '2927', '马关县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2933', '2927', '丘北县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2934', '2927', '广南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2935', '2927', '富宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2936', '2844', '思茅地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2937', '2936', '思茅市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2939', '2936', '墨江哈尼族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2940', '2936', '景东彝族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2945', '2936', '澜沧拉祜族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2946', '2936', '西盟佤族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2948', '2947', '景洪市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2949', '2947', '勐海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2950', '2947', '勐腊县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2951', '2844', '大理白族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2952', '2951', '大理市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2953', '2951', '漾濞彝族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2954', '2951', '祥云县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2955', '2951', '宾川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2956', '2951', '弥渡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2957', '2951', '南涧彝族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2959', '2951', '永平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2960', '2951', '云龙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2961', '2951', '洱源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2962', '2951', '剑川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2963', '2951', '鹤庆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2965', '2964', '瑞丽市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2966', '2964', '潞西市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2967', '2964', '梁河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2968', '2964', '盈江县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2969', '2964', '陇川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2970', '2844', '丽江地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2971', '2970', '丽江纳西族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2972', '2970', '永胜县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2973', '2970', '华坪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2974', '2970', '宁蒗彝族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2975', '2844', '怒江傈僳族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2976', '2975', '泸水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2977', '2975', '福贡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2980', '2844', '迪庆藏族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2981', '2980', '中甸县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2982', '2980', '德钦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2983', '2980', '维西傈僳族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2984', '2844', '临沧地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2985', '2984', '临沧县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2986', '2984', '凤庆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2987', '2984', '云  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2988', '2984', '永德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2989', '2984', '镇康县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2992', '2984', '沧源佤族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2993', '0', '西藏');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2994', '2993', '拉萨');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2995', '2994', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2996', '2994', '城关区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2997', '2994', '林周县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2998', '2994', '当雄县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('2999', '2994', '尼木县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3000', '2994', '曲水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3001', '2994', '堆龙德庆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3002', '2994', '达孜县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3003', '2994', '墨竹工卡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3004', '2993', '昌都地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3005', '3004', '昌都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3006', '3004', '江达县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3007', '3004', '贡觉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3008', '3004', '类乌齐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3009', '3004', '丁青县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3010', '3004', '察雅县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3011', '3004', '八宿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3012', '3004', '左贡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3013', '3004', '芒康县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3014', '3004', '洛隆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3015', '3004', '边坝县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3016', '2993', '山南地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3017', '3016', '乃东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3018', '3016', '扎囊县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3019', '3016', '贡嘎县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3020', '3016', '桑日县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3021', '3016', '琼结县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3022', '3016', '曲松县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3023', '3016', '措美县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3024', '3016', '洛扎县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3025', '3016', '加查县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3026', '3016', '隆子县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3027', '3016', '错那县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3028', '3016', '浪卡子县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3029', '2993', '日喀则地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3030', '3029', '日喀则市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3031', '3029', '南木林县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3032', '3029', '江孜县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3033', '3029', '定日县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3034', '3029', '萨迦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3035', '3029', '拉孜县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3036', '3029', '昂仁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3037', '3029', '谢通门县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3038', '3029', '白朗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3039', '3029', '仁布县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3040', '3029', '康马县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3041', '3029', '定结县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3042', '3029', '仲巴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3043', '3029', '亚东县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3044', '3029', '吉隆县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3045', '3029', '聂拉木县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3046', '3029', '萨嘎县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3047', '3029', '岗巴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3048', '2993', '那曲地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3049', '3048', '那曲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3050', '3048', '嘉黎县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3051', '3048', '比如县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3052', '3048', '聂荣县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3053', '3048', '安多县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3054', '3048', '申扎县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3055', '3048', '索  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3056', '3048', '班戈县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3057', '3048', '巴青县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3058', '3048', '尼玛县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3059', '2993', '阿里地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3060', '3059', '普兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3061', '3059', '札达县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3062', '3059', '噶尔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3063', '3059', '日土县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3064', '3059', '革吉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3065', '3059', '改则县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3066', '3059', '措勤县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3067', '2993', '林芝地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3068', '3067', '林芝县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3069', '3067', '工布江达县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3070', '3067', '米林县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3071', '3067', '墨脱县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3072', '3067', '波密县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3073', '3067', '察隅县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3074', '3067', '朗  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3075', '0', '陕西');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3076', '3075', '西安');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3077', '3076', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3078', '3076', '新城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3079', '3076', '碑林区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3080', '3076', '莲湖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3081', '3076', '灞桥区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3082', '3076', '未央区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3083', '3076', '雁塔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3084', '3076', '阎良区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3085', '3076', '临潼区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3086', '3076', '长安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3087', '3076', '蓝田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3088', '3076', '周至县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3089', '3076', '户  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3090', '3076', '高陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3091', '3075', '铜川');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3092', '3091', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3093', '3091', '王益区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3094', '3091', '印台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3095', '3091', '耀  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3096', '3091', '宜君县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3097', '3075', '宝鸡');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3098', '3097', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3099', '3097', '渭滨区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3100', '3097', '金台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3101', '3097', '宝鸡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3102', '3097', '凤翔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3103', '3097', '岐山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3104', '3097', '扶风县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3105', '3097', '眉  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3106', '3097', '陇  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3107', '3097', '千阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3108', '3097', '麟游县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3109', '3097', '凤  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3110', '3097', '太白县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3111', '3075', '咸阳');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3112', '3111', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3113', '3111', '秦都区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3114', '3111', '杨陵区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3115', '3111', '渭城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3116', '3111', '三原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3117', '3111', '泾阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3118', '3111', '乾  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3119', '3111', '礼泉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3120', '3111', '永寿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3121', '3111', '彬  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3122', '3111', '长武县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3123', '3111', '旬邑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3124', '3111', '淳化县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3125', '3111', '武功县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3126', '3111', '兴平市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3127', '3075', '渭南');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3128', '3127', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3129', '3127', '临渭区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3130', '3127', '华  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3131', '3127', '潼关县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3132', '3127', '大荔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3133', '3127', '合阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3134', '3127', '澄城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3135', '3127', '蒲城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3136', '3127', '白水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3137', '3127', '富平县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3138', '3127', '韩城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3139', '3127', '华阴市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3140', '3075', '延安');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3141', '3140', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3142', '3140', '宝塔区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3143', '3140', '延长县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3144', '3140', '延川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3145', '3140', '子长县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3146', '3140', '安塞县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3147', '3140', '志丹县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3148', '3140', '吴旗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3149', '3140', '甘泉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3150', '3140', '富  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3151', '3140', '洛川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3152', '3140', '宜川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3153', '3140', '黄龙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3154', '3140', '黄陵县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3155', '3075', '汉中');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3156', '3155', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3157', '3155', '汉台区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3158', '3155', '南郑县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3159', '3155', '城固县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3160', '3155', '洋  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3161', '3155', '西乡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3162', '3155', '勉  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3163', '3155', '宁强县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3164', '3155', '略阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3165', '3155', '镇巴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3166', '3155', '留坝县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3167', '3155', '佛坪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3168', '3075', '榆林');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3169', '3168', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3170', '3168', '榆阳区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3171', '3168', '神木县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3172', '3168', '府谷县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3173', '3168', '横山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3174', '3168', '靖边县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3175', '3168', '定边县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3176', '3168', '绥德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3177', '3168', '米脂县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3178', '3168', '佳  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3179', '3168', '吴堡县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3180', '3168', '清涧县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3181', '3168', '子洲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3182', '3075', '安康');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3183', '3182', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3184', '3182', '汉滨区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3185', '3182', '汉阴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3186', '3182', '石泉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3187', '3182', '宁陕县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3188', '3182', '紫阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3189', '3182', '岚皋县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3190', '3182', '平利县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3191', '3182', '镇坪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3192', '3182', '旬阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3193', '3182', '白河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3194', '3075', '商洛地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3195', '3194', '商州市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3196', '3194', '洛南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3197', '3194', '丹凤县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3198', '3194', '商南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3199', '3194', '山阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3200', '3194', '镇安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3201', '3194', '柞水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3202', '0', '甘肃');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3203', '3202', '兰州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3204', '3203', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3205', '3203', '城关区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3206', '3203', '七里河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3207', '3203', '西固区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3208', '3203', '安宁区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3209', '3203', '红古区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3210', '3203', '永登县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3211', '3203', '皋兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3212', '3203', '榆中县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3213', '3202', '嘉峪关');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3214', '3213', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3215', '3202', '金昌');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3216', '3215', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3217', '3215', '金川区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3218', '3215', '永昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3219', '3202', '白银');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3220', '3219', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3221', '3219', '白银区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3222', '3219', '平川区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3223', '3219', '靖远县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3224', '3219', '会宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3225', '3219', '景泰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3226', '3202', '天水');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3227', '3226', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3228', '3226', '秦城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3229', '3226', '北道区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3230', '3226', '清水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3231', '3226', '秦安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3232', '3226', '甘谷县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3233', '3226', '武山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3234', '3226', '张家川回族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3235', '3202', '酒泉地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3236', '3235', '玉门市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3237', '3235', '酒泉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3238', '3235', '敦煌市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3239', '3235', '金塔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3240', '3235', '肃北蒙古族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3242', '3235', '安西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3243', '3202', '张掖地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3244', '3243', '张掖市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3245', '3243', '肃南裕固族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3246', '3243', '民乐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3247', '3243', '临泽县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3248', '3243', '高台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3249', '3243', '山丹县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3250', '3202', '武威地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3251', '3250', '武威市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3252', '3250', '民勤县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3253', '3250', '古浪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3254', '3250', '天祝藏族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3255', '3202', '定西地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3256', '3255', '定西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3257', '3255', '通渭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3258', '3255', '陇西县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3259', '3255', '渭源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3260', '3255', '临洮县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3261', '3255', '漳  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3262', '3255', '岷  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3263', '3202', '陇南地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3264', '3263', '武都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3265', '3263', '宕昌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3266', '3263', '成  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3267', '3263', '康  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3268', '3263', '文  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3269', '3263', '西和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3270', '3263', '礼  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3271', '3263', '两当县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3272', '3263', '徽  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3273', '3202', '平凉地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3274', '3273', '平凉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3275', '3273', '泾川县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3276', '3273', '灵台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3277', '3273', '崇信县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3278', '3273', '华亭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3279', '3273', '庄浪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3280', '3273', '静宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3281', '3202', '庆阳地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3282', '3281', '西峰市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3283', '3281', '庆阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3284', '3281', '环  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3285', '3281', '华池县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3286', '3281', '合水县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3287', '3281', '正宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3288', '3281', '宁  县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3289', '3281', '镇原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3290', '3202', '临夏回族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3291', '3290', '临夏市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3292', '3290', '临夏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3293', '3290', '康乐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3294', '3290', '永靖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3295', '3290', '广河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3296', '3290', '和政县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3297', '3290', '东乡族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3299', '3202', '甘南藏族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3300', '3299', '合作市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3301', '3299', '临潭县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3302', '3299', '卓尼县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3303', '3299', '舟曲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3304', '3299', '迭部县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3305', '3299', '玛曲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3306', '3299', '碌曲县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3307', '3299', '夏河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3308', '0', '青海');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3309', '3308', '西宁');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3310', '3309', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3311', '3309', '城东区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3312', '3309', '城中区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3313', '3309', '城西区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3314', '3309', '城北区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3316', '3309', '湟中县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3317', '3309', '湟源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3318', '3308', '海东地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3319', '3318', '平安县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3321', '3318', '乐都县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3322', '3318', '互助土族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3323', '3318', '化隆回族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3324', '3318', '循化撒拉族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3325', '3308', '海北藏族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3326', '3325', '门源回族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3327', '3325', '祁连县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3328', '3325', '海晏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3329', '3325', '刚察县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3330', '3308', '黄南藏族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3331', '3330', '同仁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3332', '3330', '尖扎县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3333', '3330', '泽库县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3334', '3330', '河南蒙古族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3335', '3308', '海南藏族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3336', '3335', '共和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3337', '3335', '同德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3338', '3335', '贵德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3339', '3335', '兴海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3340', '3335', '贵南县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3341', '3308', '果洛藏族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3342', '3341', '玛沁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3343', '3341', '班玛县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3344', '3341', '甘德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3345', '3341', '达日县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3346', '3341', '久治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3347', '3341', '玛多县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3348', '3308', '玉树藏族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3349', '3348', '玉树县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3350', '3348', '杂多县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3351', '3348', '称多县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3352', '3348', '治多县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3353', '3348', '囊谦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3354', '3348', '曲麻莱县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3356', '3355', '格尔木市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3357', '3355', '德令哈市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3358', '3355', '乌兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3359', '3355', '都兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3360', '3355', '天峻县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3361', '0', '宁夏');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3362', '3361', '银川');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3363', '3362', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3364', '3362', '城  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3365', '3362', '新城区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3366', '3362', '郊  区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3367', '3362', '永宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3368', '3362', '贺兰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3369', '3361', '石嘴山');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3370', '3369', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3371', '3369', '大武口区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3372', '3369', '石嘴山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3373', '3369', '石炭井区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3374', '3369', '平罗县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3375', '3369', '陶乐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3376', '3369', '惠农县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3377', '3361', '吴忠');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3378', '3377', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3379', '3377', '利通区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3380', '3377', '中卫县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3381', '3377', '中宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3382', '3377', '盐池县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3383', '3377', '同心县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3384', '3377', '青铜峡市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3385', '3377', '灵武市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3386', '3361', '固原地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3387', '3386', '固原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3388', '3386', '海原县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3389', '3386', '西吉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3390', '3386', '隆德县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3391', '3386', '泾源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3392', '3386', '彭阳县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3393', '0', '新疆');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3394', '3393', '乌鲁木齐');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3395', '3394', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3396', '3394', '天山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3397', '3394', '沙依巴克区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3398', '3394', '新市区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3399', '3394', '水磨沟区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3400', '3394', '头屯河区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3401', '3394', '南泉区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3402', '3394', '东山区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3403', '3394', '乌鲁木齐县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3404', '3393', '克拉玛依');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3405', '3404', '市辖区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3406', '3404', '独山子区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3407', '3404', '克拉玛依区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3408', '3404', '白碱滩区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3409', '3404', '乌尔禾区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3410', '3393', '吐鲁番地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3411', '3410', '吐鲁番市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3412', '3410', '鄯善县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3413', '3410', '托克逊县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3414', '3393', '哈密地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3415', '3414', '哈密市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3417', '3414', '伊吾县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3418', '3393', '昌吉回族自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3419', '3418', '昌吉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3420', '3418', '阜康市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3421', '3418', '米泉市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3422', '3418', '呼图壁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3423', '3418', '玛纳斯县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3424', '3418', '奇台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3425', '3418', '吉木萨尔县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3426', '3418', '木垒哈萨克自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3428', '3427', '博乐市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3429', '3427', '精河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3430', '3427', '温泉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3432', '3431', '库尔勒市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3433', '3431', '轮台县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3434', '3431', '尉犁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3435', '3431', '若羌县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3436', '3431', '且末县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3437', '3431', '焉耆回族自治县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3438', '3431', '和静县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3439', '3431', '和硕县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3440', '3431', '博湖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3441', '3393', '阿克苏地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3442', '3441', '阿克苏市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3443', '3441', '温宿县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3444', '3441', '库车县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3445', '3441', '沙雅县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3446', '3441', '新和县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3447', '3441', '拜城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3448', '3441', '乌什县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3449', '3441', '阿瓦提县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3450', '3441', '柯坪县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3452', '3451', '阿图什市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3453', '3451', '阿克陶县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3454', '3451', '阿合奇县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3455', '3451', '乌恰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3456', '3393', '喀什地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3457', '3456', '喀什市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3458', '3456', '疏附县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3459', '3456', '疏勒县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3460', '3456', '英吉沙县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3461', '3456', '泽普县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3462', '3456', '莎车县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3463', '3456', '叶城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3464', '3456', '麦盖提县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3465', '3456', '岳普湖县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3466', '3456', '伽师县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3467', '3456', '巴楚县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3469', '3393', '和田地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3470', '3469', '和田市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3471', '3469', '和田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3472', '3469', '墨玉县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3473', '3469', '皮山县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3474', '3469', '洛浦县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3475', '3469', '策勒县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3476', '3469', '于田县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3477', '3469', '民丰县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3478', '3393', '伊犁哈萨克自治州');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3479', '3478', '奎屯市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3480', '3393', '伊犁地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3481', '3480', '伊宁市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3482', '3480', '伊宁县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3484', '3480', '霍城县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3485', '3480', '巩留县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3486', '3480', '新源县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3487', '3480', '昭苏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3488', '3480', '特克斯县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3489', '3480', '尼勒克县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3490', '3393', '塔城地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3491', '3490', '塔城市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3492', '3490', '乌苏市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3493', '3490', '额敏县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3494', '3490', '沙湾县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3495', '3490', '托里县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3496', '3490', '裕民县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3498', '3393', '阿勒泰地区');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3499', '3498', '阿勒泰市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3500', '3498', '布尔津县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3501', '3498', '富蕴县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3502', '3498', '福海县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3503', '3498', '哈巴河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3504', '3498', '青河县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3505', '3498', '吉木乃县');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3506', '3393', '省直辖行政单位');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3507', '3506', '石河子市');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3508', '0', '台湾');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3509', '0', '香港');
INSERT INTO `bjyadmin_province_city_area` VALUES ('3510', '0', '澳门');

-- ----------------------------
-- Table structure for `bjyadmin_users`
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
-- Table structure for `eps_address`
-- ----------------------------
DROP TABLE IF EXISTS `eps_address`;
CREATE TABLE `eps_address` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `account` char(30) NOT NULL,
  `contact` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` char(20) NOT NULL,
  `zipcode` char(6) NOT NULL,
  `lang` char(30) NOT NULL,
  `wechat` varchar(100) NOT NULL,
  `remarks` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE,
  KEY `lang` (`lang`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eps_address
-- ----------------------------
INSERT INTO `eps_address` VALUES ('1', '123', '徐大大', '大大大大', '15157125056', '121535', 'zh-cn', '', '');
INSERT INTO `eps_address` VALUES ('2', 'arthur_xcc', '许存存', '杭州阿麦科技', '18437652181', '310010', 'zh-cn', 'arthur_xcc', '尽快发货');
INSERT INTO `eps_address` VALUES ('3', 'wechat_576cd66fa067c', '许存存', '阿麦科技', '18437652181', '310010', 'zh-cn', 'arthur_xcc', '');
INSERT INTO `eps_address` VALUES ('4', 'wx_57709044a1b79', '许存存', '阿麦', '18437652181', '310010', 'zh-cn', 'arthur_xcc', '');
INSERT INTO `eps_address` VALUES ('5', 'liuhuihui', '刘慧慧', '浙江省杭州市', '13516718179', '310012', 'zh-cn', 'liuhuihui', '');
INSERT INTO `eps_address` VALUES ('6', 'wx_5775f4d48dd84', '许存存', '阿麦', '18437652181', '', 'zh-cn', 'arthur', '');
INSERT INTO `eps_address` VALUES ('7', 'wx_577214c26ea5a', '许存存', '杭州阿麦', '18437652181', '', 'zh-cn', 'arthur', '');
INSERT INTO `eps_address` VALUES ('8', 'wx_576baeec2adb4', '刘慧慧', '浙江杭州', '13516718179', '310022', 'zh-cn', 'mmmm', '');
INSERT INTO `eps_address` VALUES ('9', 'wx_5775263fbd7c8', '万少波', '123', '13165895461', '', 'zh-cn', 'wan', '');
INSERT INTO `eps_address` VALUES ('10', 'wx_5775123be6277', '淡淡的', '吃才吃饭吃', '15157125056', '', 'zh-cn', 'ccf', '');
INSERT INTO `eps_address` VALUES ('11', 'wx_5775123be6277', '淡淡的', '犯过错', '15157125056', '', 'zh-cn', 'dds', '');

-- ----------------------------
-- Table structure for `eps_cart`
-- ----------------------------
DROP TABLE IF EXISTS `eps_cart`;
CREATE TABLE `eps_cart` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `account` char(30) NOT NULL,
  `product` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `count` smallint(5) unsigned NOT NULL DEFAULT '0',
  `lang` char(30) NOT NULL,
  `extra` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE,
  KEY `lang` (`lang`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eps_cart
-- ----------------------------
INSERT INTO `eps_cart` VALUES ('1', '123', '6', '1', 'zh-cn', '');
INSERT INTO `eps_cart` VALUES ('2', '', '6', '1', 'zh-cn', '{}');
INSERT INTO `eps_cart` VALUES ('3', '', '6', '1', 'zh-cn', '');
INSERT INTO `eps_cart` VALUES ('9', 'wx_5775123be6277', '5', '5', 'zh-cn', '{}');
INSERT INTO `eps_cart` VALUES ('8', 'wx_5775123be6277', '6', '1', 'zh-cn', '{}');
INSERT INTO `eps_cart` VALUES ('10', 'wx_5775123be6277', '10', '1', 'zh-cn', '{\"23\":\"红色\",\"24\":\"M\"}');
INSERT INTO `eps_cart` VALUES ('11', 'wx_577214c26ea5a', '6', '1', 'zh-cn', '{}');

-- ----------------------------
-- Table structure for `eps_gift`
-- ----------------------------
DROP TABLE IF EXISTS `eps_gift`;
CREATE TABLE `eps_gift` (
  `lang` char(30) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(12) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double(11,2) NOT NULL,
  `imgPath` varchar(255) NOT NULL DEFAULT 'default/default_gift.png',
  `createTime` datetime NOT NULL,
  `updateTime` datetime DEFAULT NULL,
  `fileId` int(32) DEFAULT NULL,
  `state` smallint(3) NOT NULL DEFAULT '0' COMMENT '100:使用中；200:已禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eps_gift
-- ----------------------------
INSERT INTO `eps_gift` VALUES ('zh-cn', '4', '', '宝宝', '100.00', '201607/f_8f15c2078839af235f9307a5c068757b.gif', '2016-05-18 17:09:36', '2016-07-18 16:34:18', '43', '200');
INSERT INTO `eps_gift` VALUES ('zh-cn', '7', '', '牛牛', '0.02', '201607/f_01dec1c5bb771a8f110c47262482d0ec.gif', '2016-05-18 17:10:49', '2016-07-18 16:36:41', '45', '200');
INSERT INTO `eps_gift` VALUES ('zh-cn', '8', '', '二娃', '0.01', '201607/f_0ad157c74b7cb3f8b1296ef75537efbe.gif', '2016-05-18 17:11:09', '2016-07-18 16:39:42', '46', '200');
INSERT INTO `eps_gift` VALUES ('zh-cn', '9', '', '棒棒糖', '0.01', '201607/f_fce4cb7f136c794dd8756099fa4ec287.png', '2016-05-30 14:15:03', '2016-07-19 09:54:16', '52', '100');
INSERT INTO `eps_gift` VALUES ('zh-cn', '10', '', '戒指', '0.01', '201607/f_958320c91bfaf13c20d3207bfc7f063b.png', '2016-05-30 14:15:33', '2016-07-19 11:20:06', '54', '100');
INSERT INTO `eps_gift` VALUES ('zh-cn', '23', 'admin', '美女赠送', '0.88', '201607/f_1a30d70b5c536c3e8f032a021d7cca9f.gif', '2016-07-18 11:26:52', '2016-07-18 16:46:50', '48', '1');
INSERT INTO `eps_gift` VALUES ('zh-cn', '24', 'admin', '航空母舰', '1000.00', '201607/f_d33d356067d5fbeef6a679c926ab8235.gif', '2016-07-18 11:27:35', '2016-07-19 17:21:10', '60', '1');
INSERT INTO `eps_gift` VALUES ('zh-cn', '30', 'admin', '测试礼物', '0.01', '201607/f_37f07532409c04ed4e0487e7ce8d209b.gif', '2016-07-19 11:22:57', '2016-07-19 11:22:57', '57', '1');
INSERT INTO `eps_gift` VALUES ('zh-cn', '31', 'admin', '啤酒111111', '123.00', '201607/f_204499e0aebb6bbf68a62ea6d79d461d.gif', '2016-07-21 13:46:46', '2016-07-21 13:47:00', '61', '1');

-- ----------------------------
-- Table structure for `imooc_admin`
-- ----------------------------
DROP TABLE IF EXISTS `imooc_admin`;
CREATE TABLE `imooc_admin` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` char(32) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of imooc_admin
-- ----------------------------
INSERT INTO `imooc_admin` VALUES ('1', 'king', 'b2086154f101464aab3328ba7e060deb', '382771946@qq.com');
INSERT INTO `imooc_admin` VALUES ('2', 'admin', 'b2086154f101464aab3328ba7e060deb', '382771946@qq.com');
INSERT INTO `imooc_admin` VALUES ('3', 'imooc123', 'cab98d9ca998b351854f959064ca4935', 'imooc123@qq.com');
INSERT INTO `imooc_admin` VALUES ('4', 'imooc1', '00e19d92ed3f2be707e94051b92986d1', 'imooc1@qq.com');
INSERT INTO `imooc_admin` VALUES ('5', 'imoocCCTV', '914f21eb84c6fdb2b663dd6f453f65ca', 'imoocCCTV@qq.com');
INSERT INTO `imooc_admin` VALUES ('6', 'test', '098f6bcd4621d373cade4e832627b4f6', 'test@qq.com');

-- ----------------------------
-- Table structure for `imooc_cate`
-- ----------------------------
DROP TABLE IF EXISTS `imooc_cate`;
CREATE TABLE `imooc_cate` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `cName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cName` (`cName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of imooc_cate
-- ----------------------------
INSERT INTO `imooc_cate` VALUES ('1', '家用电器');
INSERT INTO `imooc_cate` VALUES ('4', '服装专区');

-- ----------------------------
-- Table structure for `imooc_user`
-- ----------------------------
DROP TABLE IF EXISTS `imooc_user`;
CREATE TABLE `imooc_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` char(32) NOT NULL,
  `sex` enum('男','女','保密') NOT NULL DEFAULT '保密',
  `email` varchar(50) NOT NULL,
  `face` varchar(50) NOT NULL,
  `regTime` int(10) unsigned NOT NULL,
  `activeFlag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of imooc_user
-- ----------------------------
INSERT INTO `imooc_user` VALUES ('2', 'king', 'b2086154f101464aab3328ba7e060deb', '男', 'king@qq.com', 'af423aeab90796e3c1cd994b6c464e09.jpg', '1402583678', '0');
INSERT INTO `imooc_user` VALUES ('3', 'queen', '72545f3f86fad045a26ed54abd2bbb9f', '保密', 'queen@sina.com', '45306f3e9e4674362731545a86b2261e.jpg', '1402584566', '0');
INSERT INTO `imooc_user` VALUES ('4', 'test123', 'cc03e747a6afbbcbf8be7668acfebee5', '保密', 'test123@qq.com', 'c794aed26d04790517233c1d2c99c4d5.jpg', '1402585325', '0');
INSERT INTO `imooc_user` VALUES ('5', 'test', 'c20ad4d76fe97759aa27a0c99bff6710', '男', 'test@qq.com', 'ce92c236763184aa42abf575df39b9d1.jpg', '1403009244', '0');

-- ----------------------------
-- Table structure for `tour_admin_access`
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
INSERT INTO `tour_admin_access` VALUES ('1', '181', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '179', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '178', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '177', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '176', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '175', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '174', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '173', '2', null);
INSERT INTO `tour_admin_access` VALUES ('1', '172', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '171', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '170', '3', null);
INSERT INTO `tour_admin_access` VALUES ('1', '169', '2', null);
INSERT INTO `tour_admin_access` VALUES ('1', '168', '1', null);

-- ----------------------------
-- Table structure for `tour_admin_node`
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
  PRIMARY KEY (`id`),
  KEY `level` (`level`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=182 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_admin_node
-- ----------------------------
INSERT INTO `tour_admin_node` VALUES ('168', 'ADMIN', '后台管理', '1', null, null, '0', '1');
INSERT INTO `tour_admin_node` VALUES ('169', 'INDEX', '首页', '1', null, null, '168', '2');
INSERT INTO `tour_admin_node` VALUES ('170', 'index', '列表', '1', null, null, '169', '3');
INSERT INTO `tour_admin_node` VALUES ('171', 'userAgent', '判断用户', '1', null, null, '169', '3');
INSERT INTO `tour_admin_node` VALUES ('172', 'notice', '通知信息', '1', null, null, '169', '3');
INSERT INTO `tour_admin_node` VALUES ('173', 'FILE', '文件管理', '1', null, null, '168', '2');
INSERT INTO `tour_admin_node` VALUES ('174', 'index', '列表', '1', null, null, '173', '3');
INSERT INTO `tour_admin_node` VALUES ('175', 'uploadFile', '文件上传', '1', null, null, '173', '3');
INSERT INTO `tour_admin_node` VALUES ('176', 'imageUpload', '图片上传', '1', null, null, '173', '3');
INSERT INTO `tour_admin_node` VALUES ('177', 'waterImage', '水印图片', '1', null, null, '173', '3');
INSERT INTO `tour_admin_node` VALUES ('178', 'uploadImage', '异步上传', '1', null, null, '173', '3');
INSERT INTO `tour_admin_node` VALUES ('179', 'uploadifyUploadImage', '异步上传2', '1', null, null, '173', '3');
INSERT INTO `tour_admin_node` VALUES ('181', 'editFace', '修改头像', '1', null, null, '173', '3');

-- ----------------------------
-- Table structure for `tour_admin_role`
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
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_admin_role
-- ----------------------------
INSERT INTO `tour_admin_role` VALUES ('1', '超级管理员', '0', '1', '超级管理员超级管理员');
INSERT INTO `tour_admin_role` VALUES ('2', '管理员', '0', '1', '管理员描述');
INSERT INTO `tour_admin_role` VALUES ('3', '会员', '0', '1', '描述');
INSERT INTO `tour_admin_role` VALUES ('17', '体育分类', '0', '1', '旅游资源统计');

-- ----------------------------
-- Table structure for `tour_admin_role_user`
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
INSERT INTO `tour_admin_role_user` VALUES ('1', '87');
INSERT INTO `tour_admin_role_user` VALUES ('1', '86');
INSERT INTO `tour_admin_role_user` VALUES ('2', '142');
INSERT INTO `tour_admin_role_user` VALUES ('2', '143');
INSERT INTO `tour_admin_role_user` VALUES ('3', '144');
INSERT INTO `tour_admin_role_user` VALUES ('1', '145');
INSERT INTO `tour_admin_role_user` VALUES ('2', '146');
INSERT INTO `tour_admin_role_user` VALUES ('3', '147');
INSERT INTO `tour_admin_role_user` VALUES ('2', '148');
INSERT INTO `tour_admin_role_user` VALUES ('1', '149');
INSERT INTO `tour_admin_role_user` VALUES ('2', '150');
INSERT INTO `tour_admin_role_user` VALUES ('2', '151');
INSERT INTO `tour_admin_role_user` VALUES ('2', '152');
INSERT INTO `tour_admin_role_user` VALUES ('2', '154');
INSERT INTO `tour_admin_role_user` VALUES ('1', '158');

-- ----------------------------
-- Table structure for `tour_admin_user`
-- ----------------------------
DROP TABLE IF EXISTS `tour_admin_user`;
CREATE TABLE `tour_admin_user` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `logintime` varchar(128) DEFAULT NULL,
  `loginip` text,
  `status` int(2) DEFAULT '0',
  `expire` int(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_admin_user
-- ----------------------------
INSERT INTO `tour_admin_user` VALUES ('86', 'admin', '4297f44b13955235245b2497399d7a93', '1470363340', '127.0.0.1', '1', '0');
INSERT INTO `tour_admin_user` VALUES ('87', '管理员测试', '4297f44b13955235245b2497399d7a93', '1456294831', '127.0.0.1', '1', '0');
INSERT INTO `tour_admin_user` VALUES ('142', 'admin4', 'e10adc3949ba59abbe56e057f20f883e', '1472630490', '127.0.0.1', '1', '90');
INSERT INTO `tour_admin_user` VALUES ('143', 'admin123', 'e10adc3949ba59abbe56e057f20f883e', '1472171735', '127.0.0.1', '1', '20');
INSERT INTO `tour_admin_user` VALUES ('144', 'admin456', 'e10adc3949ba59abbe56e057f20f883e', '1472620398', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('145', 'admin110', 'e10adc3949ba59abbe56e057f20f883e', '1472624375', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('146', 'admin678', 'e10adc3949ba59abbe56e057f20f883e', '1472624889', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('147', 'admin123789', 'e10adc3949ba59abbe56e057f20f883e', '1472625735', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('148', 'admin123ewqewq', 'e10adc3949ba59abbe56e057f20f883e', '1472625791', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('149', 'admin123324', 'e10adc3949ba59abbe56e057f20f883e', '1472625915', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('150', '弍萬先生', 'e10adc3949ba59abbe56e057f20f883e', '1472626324', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('151', '侯爱爱', 'f2410e0aecd441f3b22f32a5031d4726', '1472626489', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('152', '王思聪', '691a30721843649e0dbbb2ac825b92d1', '1472626762', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('154', 'admin12321321', 'e10adc3949ba59abbe56e057f20f883e', '1472627116', '127.0.0.1', '1', '10');
INSERT INTO `tour_admin_user` VALUES ('158', '王琳', '34940acf80f96f1433a82d1734f73c36', '1472630515', '127.0.0.1', '1', '10');

-- ----------------------------
-- Table structure for `tour_category`
-- ----------------------------
DROP TABLE IF EXISTS `tour_category`;
CREATE TABLE `tour_category` (
  `url` char(50) DEFAULT NULL,
  `imgPath` char(100) DEFAULT NULL,
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `abbr` varchar(60) NOT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `desc` text,
  `keywords` varchar(150) DEFAULT NULL,
  `parent` smallint(5) unsigned DEFAULT '0',
  `path` char(255) DEFAULT '',
  `grade` tinyint(3) unsigned DEFAULT '0',
  `level` int(10) DEFAULT '0',
  `order` smallint(5) unsigned DEFAULT '0',
  `type` char(30) DEFAULT NULL,
  `readonly` enum('0','1') DEFAULT '0',
  `moderators` varchar(255) DEFAULT NULL,
  `threads` smallint(5) DEFAULT NULL,
  `posts` smallint(5) DEFAULT NULL,
  `postedBy` varchar(30) DEFAULT NULL,
  `postedDate` datetime DEFAULT NULL,
  `postID` mediumint(9) DEFAULT NULL,
  `replyID` mediumint(8) unsigned DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `unsaleable` enum('0','1') DEFAULT '0',
  `lang` char(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`) USING BTREE,
  KEY `tree` (`type`) USING BTREE,
  KEY `order` (`order`) USING BTREE,
  KEY `parent` (`parent`) USING BTREE,
  KEY `path` (`path`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_category
-- ----------------------------
INSERT INTO `tour_category` VALUES ('', '201607/f_8aa25e7b5aa24b0e766db7c5ea9f4d46.jpg', '1', '婚纱', '', '', '', '', '0', '0,1', '1', '1', '10', 'product', '0', '', '0', '0', '', '2016-05-25 16:13:26', '0', '0', '', '0', 'zh-cn');
INSERT INTO `tour_category` VALUES ('', '201607/f_c0323c1eb9db5f75ae40a7106bc23ad0.jpg', '2', '晚礼服', '', '', '', '', '0', '0,2', '1', '1', '20', 'product', '0', '', '0', '0', '', '2016-05-25 16:13:26', '0', '0', '', '0', 'zh-cn');
INSERT INTO `tour_category` VALUES ('', '201607/f_c2fc43023cb6b1433642e7a9f7fa939f.jpg', '3', '鞋子', '', '', '', '', '0', '0,3', '1', '1', '30', 'product', '0', '', '0', '0', '', '2016-05-25 16:13:26', '0', '0', '', '0', 'zh-cn');
INSERT INTO `tour_category` VALUES ('', '', '7', '二级婚纱1', '', '', '', '', '1', '0,1,7', '2', '2', '0', 'product', '0', '', '0', '0', '', '0000-00-00 00:00:00', '0', '0', '', '0', '');
INSERT INTO `tour_category` VALUES ('', '', '8', '二级婚纱2', '', '', '', '', '1', '0,1,8', '2', '2', '0', 'product', '0', '', '0', '0', '', '0000-00-00 00:00:00', '0', '0', '', '0', '');
INSERT INTO `tour_category` VALUES ('', '', '9', '皮鞋', '', '', '', '', '3', '0,3,9', '2', '2', '0', 'product', '0', '', '0', '0', '', '0000-00-00 00:00:00', '0', '0', '', '0', '');
INSERT INTO `tour_category` VALUES ('', '', '10', '凉鞋', '', '', '', '', '3', '0,3,10', '2', '2', '0', 'product', '0', '', '0', '0', '', '0000-00-00 00:00:00', '0', '0', '', '0', '');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '69', '惠普', 'alias', '惠普', null, '惠普', '66', '0,64,66,69', '3', '3', '69', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '62', '运动鞋', 'alias', '运动鞋', null, '运动鞋', '3', '0,3,62', '2', '2', '62', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES (null, null, '84', '根分类', '', null, null, null, '0', '0', '0', '0', '0', null, '0', null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '64', '电脑', 'alias', '电脑', null, '电脑', '0', '0,64', '1', '1', '64', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '65', '笔记本', 'alias', '笔记本', null, '笔记本', '64', '0,64,65', '2', '2', '65', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '66', '台式', 'alias', '台式', null, '台式', '64', '0,64,66', '2', '2', '66', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '67', '华硕笔记本', 'alias', '华硕笔记本', null, '华硕笔记本', '65', '0,64,65,67', '3', '3', '67', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '68', '联想', 'alias', '联想', null, '联想', '65', '0,64,65,68', '3', '3', '68', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '70', '晚礼服二级分类', 'alias', '晚礼服二级分类', null, '晚礼服二级分类', '2', '0,2,70', '2', '2', '70', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '71', '晚礼服二级', 'alias', '晚礼服二级', null, '晚礼服二级', '2', '0,2,71', '2', '2', '71', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '72', '新人婚纱', 'alias', '新人婚纱', null, '新人婚纱', '7', '0,1,7,72', '3', '3', '72', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '73', '最后以及啊', 'alias', '最后以及啊', null, '最后以及啊', '72', '0,1,7,72,73', '4', '4', '73', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '74', '书籍', 'alias', '书籍', null, '书籍', '0', '0,74', '1', '1', '74', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '75', '计算机', 'alias', '计算机', null, '计算机', '74', '0,74,75', '2', '2', '75', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '76', '英语', 'alias', '英语', null, '英语', '74', '0,74,76', '2', '2', '76', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '77', '软件工程', 'alias', '软件工程', null, '软件工程', '75', '0,74,75,77', '3', '3', '77', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '78', '网络', 'alias', '网络', null, '网络', '75', '0,74,75,78', '3', '3', '78', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '79', '系统', 'alias', '系统', null, '系统', '75', '0,74,75,79', '3', '3', '79', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '80', 'Linux操作系统', 'alias', 'Linux操作系统', null, 'Linux操作系统', '79', '0,74,75,79,80', '4', '4', '80', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '81', 'Windows操作系统', 'alias', 'Windows操作系统', null, 'Windows操作系统', '79', '0,74,75,79,81', '4', '4', '81', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '82', '软件测试', 'alias', '软件测试', null, '软件测试', '77', '0,74,75,77,82', '4', '4', '82', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES ('url', 'imgPath', '83', '工程测试', 'alias', '工程测试', null, '工程测试', '77', '0,74,75,77,83', '4', '4', '83', 'product', '', null, '1', '1', '1', '0000-00-00 00:00:00', null, '1', '1', '', 'lang');
INSERT INTO `tour_category` VALUES (null, null, '85', '汽车', '', null, null, null, '0', '0,85', '0', '1', '0', null, '0', null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `tour_category` VALUES (null, null, '86', '网络安全', '', null, null, null, '0', '0,74,75,78,86', '0', '4', '0', null, '0', null, null, null, null, null, null, null, null, '0', null);

-- ----------------------------
-- Table structure for `tour_download_log`
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
-- Table structure for `tour_file`
-- ----------------------------
DROP TABLE IF EXISTS `tour_file`;
CREATE TABLE `tour_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL,
  `path` varchar(50) DEFAULT NULL,
  `min_path` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_file
-- ----------------------------
INSERT INTO `tour_file` VALUES ('1', '1', '5e7852468c96b4cb0763e5f47991f351.jpg', null);
INSERT INTO `tour_file` VALUES ('2', '1', 'ed50987c9544d26772f56b36de636acf.jpg', null);
INSERT INTO `tour_file` VALUES ('3', '2', '40c194c5adf567527071d675b48baeb9.jpg', null);
INSERT INTO `tour_file` VALUES ('4', '2', '7148d9fb2125ae1d117bc48e917b6d13.jpg', null);
INSERT INTO `tour_file` VALUES ('5', '2', 'd70ad5fc301a19c0ddf8d6e82d3e24e7.jpg', null);
INSERT INTO `tour_file` VALUES ('6', '3', 'f2b60ce8bb961e5f171e23d03ba8dd87.jpg', null);
INSERT INTO `tour_file` VALUES ('7', '3', 'ee5d87a7d6a3bd0eb4febd39485d5987.jpg', null);
INSERT INTO `tour_file` VALUES ('10', '5', '0c685612472ff1add958ba3048633025.jpg', null);
INSERT INTO `tour_file` VALUES ('11', '5', '407865ba90f0df80822f6a1900f4c7d1.jpg', null);
INSERT INTO `tour_file` VALUES ('14', '7', 'd8b335e57c1a754c92e0d971cb6016c7.jpg', null);
INSERT INTO `tour_file` VALUES ('15', '7', 'bf4dddfbbd8fe3c5b87c2453a983ce5e.jpg', null);
INSERT INTO `tour_file` VALUES ('17', '1', '7ec55f75f39e03ee8546a3ec1ab43f83.jpg', null);
INSERT INTO `tour_file` VALUES ('18', '2', '5677a769720af6854e18e3c6d91f5bf3.jpg', null);
INSERT INTO `tour_file` VALUES ('19', '9', '511736465de28bc9d6fc730238d53c34.jpg', null);
INSERT INTO `tour_file` VALUES ('20', '9', 'ad643c1df5effa36c559c8548d55f3ee.jpg', null);
INSERT INTO `tour_file` VALUES ('21', '10', 'f6339c7b3eec18dd2526ff26008bd56b.jpg', null);
INSERT INTO `tour_file` VALUES ('22', '10', '49e5fbfbfbb74fe237988c18f8c37585.jpg', null);
INSERT INTO `tour_file` VALUES ('23', '11', '0c14ca6ed080e92402c23d35af96556d.jpg', null);
INSERT INTO `tour_file` VALUES ('24', '11', '6fe87551772f79fb88ed1ca16b77d2c3.jpg', null);
INSERT INTO `tour_file` VALUES ('25', '12', 'f8d506bb6488955e77ad661caf049374.jpg', null);
INSERT INTO `tour_file` VALUES ('26', '12', 'c1c9c2607fbc4b9ccf3a73d07f953680.jpg', null);
INSERT INTO `tour_file` VALUES ('27', '13', '5b7930a28c1bbf9fca0463bcea1f1b56.jpg', null);
INSERT INTO `tour_file` VALUES ('28', '14', '78e21378d2a43de2cf4a0dacfb0de6a1.jpg', null);
INSERT INTO `tour_file` VALUES ('29', '15', '75a9f473e7b087dcc25770d8f58d0370.jpg', null);
INSERT INTO `tour_file` VALUES ('30', '16', '9a77eb963b97a8c20163f656f6e52c7b.jpg', null);
INSERT INTO `tour_file` VALUES ('31', '17', '1881bb9f44bd1bbad25a9085b1aaa3d5.jpg', null);
INSERT INTO `tour_file` VALUES ('32', '18', '49659aecbb2aa7e99cd59cac8ea2a8a5.jpg', null);
INSERT INTO `tour_file` VALUES ('33', '19', 'c32cd29977b460f8bcbb45b8286de347.jpg', null);
INSERT INTO `tour_file` VALUES ('34', '84', 'Product/2016-08-24/mini_57bd220fe331f.jpg', 'Product/2016-08-24/mini_57bd220f');
INSERT INTO `tour_file` VALUES ('35', '24', 'Product/2016-08-24/mini_57bd2220d5070.jpg', 'Product/2016-08-24/mini_57bd2220');

-- ----------------------------
-- Table structure for `tour_logs`
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_logs
-- ----------------------------
INSERT INTO `tour_logs` VALUES ('10', '145', '2016-08-31 14:45:15', 'admin110', 'admin110', 'Home', 'AdminUser', 'createadminuser', 'admin123324--123456--1', '0', '', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('11', '145', '2016-08-31 14:52:04', 'admin110', 'admin110', 'Home', 'AdminUser', 'createadminuser', '弍萬先生--123456--2', '1', '为角色Id为：2添加一个新用户:弍萬先生密码为:123456', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('12', '145', '2016-08-31 14:54:49', 'admin110', 'admin110', 'Home', 'AdminUser', 'createadminuser', '侯爱爱--klwdws1988--2', '1', '给ID为:[2]角色,新增用户:[侯爱爱],密码为:[klwdws1988]', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('13', '145', '2016-08-31 15:24:52', 'admin110', 'admin110', 'Home', 'Index', 'test', '', '0', '', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('14', '145', '2016-08-31 15:25:11', 'admin110', 'admin110', 'Home', 'AdminUser', 'createadminuser', 'admin78787--123456--2', '1', '给ID为:[2]的角色,新增用户:[admin78787],密码为:[123456]', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('15', '145', '2016-08-31 15:32:50', 'admin110', 'admin110', 'Home', 'AdminUser', 'createadminuser', '王琳--klwdws2016--1', '1', '给ID为:[1]的角色,新增用户:[王琳],密码为:[klwdws2016]', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('16', '158', '2016-08-31 15:36:09', '王琳', '王琳', 'Home', 'AdminUser', 'createadminuser', 'admin王琳--123456--2', '1', '给ID为:[2]的角色,新增用户:[admin王琳],密码为:[123456]其他参数Array', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('17', '142', '2016-08-31 15:40:34', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆操作用户admin4其他参数Array', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('18', '142', '2016-08-31 15:40:54', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆操作用户admin4其他参数1', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('19', '142', '2016-08-31 15:43:26', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆操作用户admin4其他参数', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('20', '142', '2016-08-31 15:46:00', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('21', '142', '2016-08-31 16:01:30', 'admin4', 'admin4', 'Home', 'Login', 'checkLogin', 'admin4--123456--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('22', '158', '2016-08-31 16:01:55', '王琳', '王琳', 'Home', 'Login', 'checkLogin', '王琳--klwdws2016--on', '1', '登陆成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('23', '158', '2016-08-31 16:04:28', '王琳', '王琳', 'Home', 'AdminUser', 'delUser', '157', '1', '删除用户ID:157成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('24', '158', '2016-08-31 16:04:50', '王琳', '王琳', 'Home', 'AdminUser', 'delUser', '156', '1', '删除用户ID:156成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('25', '158', '2016-08-31 16:04:53', '王琳', '王琳', 'Home', 'AdminUser', 'delUser', '155', '1', '删除用户ID:155成功', '127.0.0.1', 'system');
INSERT INTO `tour_logs` VALUES ('26', '158', '2016-08-31 16:04:58', '王琳', '王琳', 'Home', 'AdminUser', 'delUser', '153', '1', '删除用户ID:153成功', '127.0.0.1', 'system');

-- ----------------------------
-- Table structure for `tour_node`
-- ----------------------------
DROP TABLE IF EXISTS `tour_node`;
CREATE TABLE `tour_node` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `remark` varchar(255) DEFAULT NULL,
  `sort` smallint(6) unsigned DEFAULT NULL,
  `pid` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `level` (`level`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_node
-- ----------------------------
INSERT INTO `tour_node` VALUES ('100', 'HOME', '吉林旅游云数据', '1', null, null, '0', '1');
INSERT INTO `tour_node` VALUES ('141', 'SystemControl', '系统运行监控', '1', null, null, '100', '2');
INSERT INTO `tour_node` VALUES ('142', 'StageInfo', '平台统计', '1', null, null, '100', '2');
INSERT INTO `tour_node` VALUES ('143', 'tourSource', '旅游资源统计', '1', null, null, '142', '3');
INSERT INTO `tour_node` VALUES ('144', 'tourProduct', '旅游产品统计', '1', null, null, '142', '3');
INSERT INTO `tour_node` VALUES ('145', 'DataManage', '数据管理', '1', null, null, '100', '2');
INSERT INTO `tour_node` VALUES ('146', 'dataProduct', '数据产品管理', '1', null, null, '145', '3');
INSERT INTO `tour_node` VALUES ('147', 'dataDb', '数据库管理', '1', null, null, '145', '3');
INSERT INTO `tour_node` VALUES ('148', 'Share', '数据共享', '1', null, null, '100', '2');
INSERT INTO `tour_node` VALUES ('149', 'dataUser', '数据用户管理', '1', null, null, '148', '3');
INSERT INTO `tour_node` VALUES ('150', 'dataInterface', '接口管理', '1', null, null, '148', '3');
INSERT INTO `tour_node` VALUES ('151', 'System', '系统设置', '1', null, null, '100', '2');
INSERT INTO `tour_node` VALUES ('152', 'userControl', '平台用户管理', '1', null, null, '151', '3');
INSERT INTO `tour_node` VALUES ('153', 'roleControl', '角色定义', '1', null, null, '151', '3');
INSERT INTO `tour_node` VALUES ('154', 'nodeControl', '权限管理', '1', null, null, '151', '3');
INSERT INTO `tour_node` VALUES ('155', 'Login', '安全退出', '0', null, null, '100', '2');
INSERT INTO `tour_node` VALUES ('156', 'logout', '安全退出', '1', null, null, '155', '3');
INSERT INTO `tour_node` VALUES ('157', 'controlIndex', '系统运行监控', '1', null, null, '141', '3');
INSERT INTO `tour_node` VALUES ('161', 'Member', '个人中心', '1', null, null, '100', '2');
INSERT INTO `tour_node` VALUES ('162', 'memberInfo', '个人信息', '1', null, null, '161', '3');

-- ----------------------------
-- Table structure for `tour_product`
-- ----------------------------
DROP TABLE IF EXISTS `tour_product`;
CREATE TABLE `tour_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pName` varchar(255) NOT NULL,
  `pSn` varchar(50) NOT NULL,
  `pNum` int(10) unsigned DEFAULT '1',
  `mPrice` decimal(10,2) NOT NULL,
  `iPrice` decimal(10,2) NOT NULL,
  `pDesc` text,
  `pubTime` int(10) unsigned NOT NULL,
  `isShow` tinyint(1) DEFAULT '1',
  `isHot` tinyint(1) DEFAULT '0',
  `cId` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pName` (`pName`),
  UNIQUE KEY `pName_2` (`pName`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_product
-- ----------------------------
INSERT INTO `tour_product` VALUES ('1', 'IMOOC苹果（APPLE）iPhone 4S 8G版 3G手机', '98122', '9999', '2000.00', '1999.00', '<p>\r\n	<span style=\"color:#666666;font-family:微软雅黑;font-size:14px;line-height:21px;background-color:#FFFFFF;\">双核，让 A5 芯片双倍强大，图形处理快达 7 倍1。你会感觉到它所带来的效果 — 飞快。iPhone 4S 快速，反应灵敏，当你启动应用软件、浏览网页，以及做各种操作时，就会体验到它所成就的与众不同。而且无论你正在做什么，都可以持续进行。A5 芯片具有极高的效能，赋予 iPhone 4S 超长的电池使用时间。</span> \r\n</p>\r\n<p>\r\n	<span style=\"color:#666666;font-family:微软雅黑;font-size:14px;line-height:21px;background-color:#FFFFFF;\"><span style=\"color:#666666;font-family:微软雅黑;font-size:14px;line-height:21px;background-color:#FFFFFF;\">双核，让 A5 芯片双倍强大，图形处理快达 7 倍1。你会感觉到它所带来的效果 — 飞快。iPhone 4S 快速，反应灵敏，当你启动应用软件、浏览网页，以及做各种操作时，就会体验到它所成就的与众不同。而且无论你正在做什么，都可以持续进行。A5 芯片具有极高的效能，赋予 iPhone 4S 超长的电池使用时间。</span><br />\r\n</span> \r\n</p>', '1402245020', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('2', 'IMOOC华为 荣耀3C （白色）3G手机 TD-SCDMA/GSM 2G RAM ', '1056969', '9999', '1099.00', '659.00', '<div style=\"margin:0px;padding:0px;background-color:#FFFFFF;color:#717071;font-family:微软雅黑;font-size:24px;\">\r\n	5英寸黑瀑布屏，全贴合工艺，LTPS技术\r\n</div>\r\n<p>\r\n	全贴合工艺，宛如黑瀑布，显示跃然屏上，清晰度更高，画质更细腻逼真 <br />\r\nLTPS低温多晶硅技术屏幕，响应速度快，更鲜艳\r\n</p>\r\n<p>\r\n	1280*720高清分辨率，1600万色，极佳的色彩表现，全视角\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<div style=\"margin:0px;padding:0px;background-color:#FFFFFF;color:#717071;font-family:微软雅黑;font-size:24px;\">\r\n	<br />\r\n</div>', '1402306881', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('3', '三星（SAMSUNG）I9158P 3G手机（白色）TD-SCDMA/GSM', '1072545', '9999', '1699.00', '1299.00', '<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-size:14px;font-weight:700;color:#666666;font-family:Arial, Helvetica, sans-serif;background-color:#FFFFFF;\">\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-weight:700;\">\r\n			5.8英寸清晰大屏，精彩“大”有不同\r\n		</div>\r\n		<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n			智能手机上也能畅享平板体验？GALAXY MEGA I9158P让平板和智能手机完美结合。它纤薄轻巧，让您轻松随身携带。极窄边框设计，让您单手亦可舒适掌握。更让您惊喜的是，它拥有5.8英寸的清晰大屏，提供更大的文字和图片显示，带来无比震撼的视觉冲击。\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n			<img alt=\"\" src=\"http://img20.360buyimg.com/vc/g14/M00/03/00/rBEhVVHL_jcIAAAAAAHZgUsur7oAAAl3ALoDUQAAdmZ750.jpg\" class=\"err-product\" />\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n			主屏支持竖屏、横屏两种显示模式，为您呈现更丰富的内容，提供最开阔的视野。无论您玩游戏、播放视频还是浏览网页，都可获得最大化的视觉体验。\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n			<img alt=\"\" src=\"http://img20.360buyimg.com/vc/g15/M09/03/00/rBEhWlHL_oMIAAAAAADnHDxBzd4AAAl3AE0jZQAAOc0328.jpg\" class=\"err-product\" />\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-weight:700;\">\r\n			多窗口多任务，一览无余，高效自如\r\n		</div>\r\n		<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n			需要处理多个任务时不想手忙脚乱、频繁切换窗口？GALAXY MEGA I9158P可在超大屏幕上同时运行两个程序窗口，让您体验真正便捷高效的多任务处理。\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n			<img alt=\"\" src=\"http://img20.360buyimg.com/vc/g15/M00/03/00/rBEhWFHL_u8IAAAAAACxViCPakQAAAl3QIhLpUAALFu557.jpg\" class=\"err-product\" />\r\n		</div>\r\n	</div>\r\n	<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n		<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n			您可以在访问网页或与好友聊天的同时，发送邮件或观看视频，一举多得。您还可通过Pop Up play画中画功能，一边发短信、电子邮件或处理其它应用，一边欣赏大片，绝不错失任何精彩。并可根据需要，将视频窗口拖曳到任何位置，让娱乐更自由。\r\n		</div>\r\n	</div>\r\n</div>\r\n<div class=\"formwork_text\" style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Helvetica, sans-serif;font-size:14px;background-color:#FFFFFF;\">\r\n</div>', '1402307174', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('5', '胜伟 高支棉斜纹四件套裸婚时代100%棉1.5/1.8米床', '10569691', '99999', '149.00', '119.00', '<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	产品资料\r\n</p>\r\n<p class=\"formwork_titleleft2\" style=\"font-size:14px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	胜伟高支棉斜纹四<span class=\"wiki-words\" id=\"wiki-keyword-1\">件套</span>裸婚时代<br />\r\n<span class=\"wiki-words\" id=\"wiki-keyword-2\">面料</span>：40S全棉<br />\r\n适合床：1.5/1.8米床<br />\r\n规格：被套230*200&nbsp;<span class=\"wiki-words\" id=\"wiki-keyword-0\">床单</span>250*230 枕套48*74*2只<br />\r\n毛重：2.1kg\r\n</p>', '1402308299', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('7', 'XP 热 阿迪达斯adidas2014新款生活男鞋网面低帮场下篮球文化板鞋', '2342123', '9999', '555.00', '333.00', '<h1 style=\"font-size:16px;font-family:arial, \'microsoft yahei\';color:#666666;background-color:#FFFFFF;\">\r\n	XP 热 阿迪达斯adidas2014新款生活男鞋网面低帮场下篮球文化板鞋Q33480 尊贵蓝+亮黄荧光+白 43\r\n</h1>', '1402309073', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('9', '韩都衣舍 韩版2014夏装新款女装两件套圆领短袖T恤NW3201肆 白色 M', '1056333', '55', '134.00', '90.00', '<p>\r\n	<span style=\"color:#5C5C5C;font-family:微软雅黑;background-color:#FFFFFF;\">外衣大身：95%粘纤 5%氨纶&nbsp;外衣袖子：70%棉 25%锦纶 5%粘纤 内搭：95%粘纤 5%氨纶</span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#5C5C5C;font-family:微软雅黑;background-color:#FFFFFF;\">\r\n	<div class=\"content ke-post\" align=\"center\" style=\"margin:0px;padding:10px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img id=\"desc-module-3\" class=\"desc_anchor err-product\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t184/155/168032383/43/9acceab1/5382ee5eN2be51f49.gif\" />\r\n	</div>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t178/287/178335129/2820/609e02e3/5382ee60N2b1ddab5.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t148/50/186325206/7981/1e0aaf04/5382ee60N5e88de2b.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div class=\"content ke-post\" align=\"center\" style=\"margin:0px;padding:10px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img width=\"750\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t181/258/177275435/97121/d1daeccd/5382ee60N6a3f30e6.jpg\" class=\"err-product\" />\r\n	</div>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t205/334/168709737/134760/b4fbaff4/5382ee61N65bda1a9.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t190/165/182664900/141536/9c71d740/5382ee61N9e78a437.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t148/55/172181392/151420/bdf9cc8a/5382ee62Ne1afea73.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t196/125/192440496/118964/372173ca/5382ee62N7f1915a8.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<p class=\"content ke-post\" align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t148/54/168991084/155385/fe5ee665/5382ee63N9832bd69.jpg\" class=\"err-product\" />\r\n	</p>\r\n<br />\r\n</span>\r\n</p>', '1402320900', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('10', '洛诗琳2014夏装新款女装欧根纱盘花荷叶边修身雪纺连衣裙', '102228144', '78', '786.00', '249.00', '<div style=\"margin:0px auto;padding:0px;color:#666666;background-color:#FFFFFF;border:1px dashed #AAAAAA;font-family:微软雅黑;\">\r\n	<p>\r\n		<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g13/M00/01/18/rBEhU1NwdFUIAAAAAAAm5FOXIIcAANDzwPv_p8AACb8961.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"748\" class=\"ke-zeroborder\">\r\n		<tbody>\r\n			<tr>\r\n				<td align=\"middle\" rowspan=\"2\" valign=\"top\" width=\"218\">\r\n					<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g17/M00/00/06/rBEbSlNwdFkIAAAAAACS82hCKUUAAAPeQOPPtsAAJML149.jpg\" class=\"err-product\" />\r\n				</td>\r\n				<td rowspan=\"2\" width=\"10\">\r\n				</td>\r\n				<td valign=\"top\" width=\"250\">\r\n					<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"250\" style=\"text-align:center;color:#FFFFFF;font-size:12px;\" class=\"ke-zeroborder\">\r\n						<tbody>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"25\" style=\"text-align:left;background-color:#555555;font-size:15px;\">\r\n									<strong>基本参数</strong>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"20\" style=\"text-align:left;color:#000000;font-size:13px;\">\r\n									<strong>款号：</strong>XDR114340\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"20\" style=\"text-align:left;color:#000000;font-size:13px;\">\r\n									<strong>品名：</strong>欧根纱盘花荷叶边修身雪纺连衣裙\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"20\" style=\"text-align:left;color:#000000;font-size:13px;\">\r\n									<strong>市场价：</strong>786RMB\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"30\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"25\" style=\"text-align:left;background-color:#555555;font-size:15px;\">\r\n									<strong>基本参数</strong>\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" width=\"65\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>面料指数：</strong>\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									宽松\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									略松\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									合身\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									紧身\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>衣长指数：</strong>\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									超短\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									短\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									常规\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									中长\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>弹力指数：</strong>\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									无弹\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									微弹\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									弹力\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									超弹\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>面料质感：</strong>\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									顺滑\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									滑\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									适中\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									粒感\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>拉链位置：</strong>\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									无\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#DBA64A;\">\r\n									背后\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									左侧\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td style=\"background-color:#999999;\">\r\n									右侧\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td colspan=\"8\" height=\"10\">\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"20\" style=\"color:#000000;font-size:13px;\">\r\n									<strong>有无里衬：</strong>\r\n								</td>\r\n								<td colspan=\"3\" style=\"background-color:#DBA64A;\">\r\n									有\r\n								</td>\r\n								<td width=\"1\">\r\n								</td>\r\n								<td colspan=\"3\" style=\"background-color:#999999;\">\r\n									无\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</td>\r\n				<td width=\"10\">\r\n				</td>\r\n				<td valign=\"top\">\r\n					<div style=\"margin:0px;padding:0px 20px;font-family:微软雅黑;background-color:#E6E6E6;font-size:13px;\">\r\n						<div style=\"margin:10px 0px 0px;padding:0px;font-size:15px;\">\r\n							<strong>面料信息</strong>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							&nbsp;\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							面料：乔其&nbsp;<br />\r\n里料：配色弹力双绉\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							&nbsp;\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							&nbsp;\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							面布成分:聚酯纤维100%&nbsp;<br />\r\n里布成分:聚酯纤维100%\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							&nbsp;\r\n						</div>\r\n						<div style=\"margin:10px 0px 0px;padding:0px;font-size:15px;\">\r\n							<strong>洗涤说明：</strong>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;\">\r\n							<span style=\"color:#FF0000;\">手洗不可漂白</span>，冷水单独洗涤；\r\n						</div>\r\n					</div>\r\n				</td>\r\n				<td width=\"10\">\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"3\" valign=\"top\">\r\n					<div style=\"margin:15px auto;padding:0px;text-align:center;font-family:微软雅黑;background-color:#E6E6E6;font-size:15px;font-weight:bold;\">\r\n						身体尺寸参照表\r\n					</div>\r\n					<table cellpadding=\"0\" cellspacing=\"0\" height=\"170\" width=\"100%\" style=\"border:1px double #CCCCCC;text-align:center;font-family:微软雅黑;font-size:13px;\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#000\" height=\"25\" style=\"color:#FFFFFF;\">\r\n									尺码\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									S\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									M\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									L\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									XL\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									2XL\r\n								</td>\r\n								<td style=\"color:#FFFFFF;\">\r\n									3XL\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									胸围(cm)\r\n								</td>\r\n								<td valign=\"center\">\r\n									83\r\n								</td>\r\n								<td valign=\"center\">\r\n									86\r\n								</td>\r\n								<td valign=\"center\">\r\n									90\r\n								</td>\r\n								<td valign=\"center\">\r\n									94\r\n								</td>\r\n								<td valign=\"center\">\r\n									98\r\n								</td>\r\n								<td valign=\"center\">\r\n									102\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									腰围(cm)\r\n								</td>\r\n								<td valign=\"center\">\r\n									67(2.01尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									70(2.1尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									74(2.22尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									78(2.34尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									82(2.46尺)\r\n								</td>\r\n								<td valign=\"center\">\r\n									84(2.52尺)\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									臀围(cm)\r\n								</td>\r\n								<td valign=\"center\">\r\n									89\r\n								</td>\r\n								<td valign=\"center\">\r\n									92\r\n								</td>\r\n								<td valign=\"center\">\r\n									96\r\n								</td>\r\n								<td valign=\"center\">\r\n									100\r\n								</td>\r\n								<td valign=\"center\">\r\n									104\r\n								</td>\r\n								<td valign=\"center\">\r\n									108\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									适合体重(kg)\r\n								</td>\r\n								<td valign=\"center\">\r\n									50kg以内\r\n								</td>\r\n								<td valign=\"center\">\r\n									55kg左右\r\n								</td>\r\n								<td valign=\"center\">\r\n									60kg左右\r\n								</td>\r\n								<td valign=\"center\">\r\n									65kg左右\r\n								</td>\r\n								<td valign=\"center\">\r\n									70kg左右\r\n								</td>\r\n								<td valign=\"center\">\r\n									75kg左右\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n					<div style=\"margin:0px;padding:0px;font-family:微软雅黑;color:#666666;font-size:11px;\">\r\n						注：以上均为身体尺寸（身体尺寸是人体裸身尺寸，即未穿着衣物时身体三围尺寸。)\r\n					</div>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td colspan=\"6\">\r\n					<div style=\"margin:10px 0px 0px 10px;padding:0px;\">\r\n						&nbsp;\r\n					</div>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td align=\"middle\" valign=\"top\">\r\n					<img width=\"210\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/02/1F/rBEhVVNwdKAIAAAAAABQNfYAS4oAANKaAGzIeQAAFBN916.jpg\" class=\"err-product\" />\r\n				</td>\r\n				<td>\r\n				</td>\r\n				<td colspan=\"3\">\r\n					<div style=\"margin:15px auto;padding:0px;text-align:center;font-family:微软雅黑;background-color:#E6E6E6;font-size:15px;font-weight:bold;\">\r\n						衣服平铺尺寸参照表\r\n					</div>\r\n					<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border:1px double #CCCCCC;text-align:center;font-family:微软雅黑;font-size:13px;\">\r\n						<tbody>\r\n							<tr>\r\n								<td bgcolor=\"#000\" height=\"25\" width=\"11%\" style=\"color:#FFFFFF;\">\r\n									尺码\r\n								</td>\r\n								<td width=\"11%\">\r\n									衣长\r\n								</td>\r\n								<td width=\"11%\">\r\n									肩宽\r\n								</td>\r\n								<td width=\"11%\">\r\n									胸围\r\n								</td>\r\n								<td width=\"11%\">\r\n									腰围\r\n								</td>\r\n								<td width=\"11%\">\r\n									臀围\r\n								</td>\r\n								<td width=\"12%\">\r\n									下摆围\r\n								</td>\r\n								<td width=\"11%\">\r\n									前领围\r\n								</td>\r\n								<td width=\"11%\">\r\n									后领围\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									S\r\n								</td>\r\n								<td valign=\"center\">\r\n									82.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									10.73\r\n								</td>\r\n								<td valign=\"center\">\r\n									88\r\n								</td>\r\n								<td valign=\"center\">\r\n									70.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									93\r\n								</td>\r\n								<td valign=\"center\">\r\n									114\r\n								</td>\r\n								<td valign=\"center\">\r\n									32.9\r\n								</td>\r\n								<td valign=\"center\">\r\n									26.1\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									M\r\n								</td>\r\n								<td valign=\"center\">\r\n									84\r\n								</td>\r\n								<td valign=\"center\">\r\n									11\r\n								</td>\r\n								<td valign=\"center\">\r\n									91\r\n								</td>\r\n								<td valign=\"center\">\r\n									73.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									96\r\n								</td>\r\n								<td valign=\"center\">\r\n									117\r\n								</td>\r\n								<td valign=\"center\">\r\n									33.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									26.5\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									L\r\n								</td>\r\n								<td valign=\"center\">\r\n									85.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									11.27\r\n								</td>\r\n								<td valign=\"center\">\r\n									95\r\n								</td>\r\n								<td valign=\"center\">\r\n									77.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									100\r\n								</td>\r\n								<td valign=\"center\">\r\n									121\r\n								</td>\r\n								<td valign=\"center\">\r\n									34.1\r\n								</td>\r\n								<td valign=\"center\">\r\n									26.9\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									XL\r\n								</td>\r\n								<td valign=\"center\">\r\n									87\r\n								</td>\r\n								<td valign=\"center\">\r\n									11.54\r\n								</td>\r\n								<td valign=\"center\">\r\n									99\r\n								</td>\r\n								<td valign=\"center\">\r\n									81.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									104\r\n								</td>\r\n								<td valign=\"center\">\r\n									125\r\n								</td>\r\n								<td valign=\"center\">\r\n									34.7\r\n								</td>\r\n								<td valign=\"center\">\r\n									27.3\r\n								</td>\r\n							</tr>\r\n							<tr>\r\n								<td height=\"30\" valign=\"center\">\r\n									XXL\r\n								</td>\r\n								<td valign=\"center\">\r\n									88.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									11.81\r\n								</td>\r\n								<td valign=\"center\">\r\n									103\r\n								</td>\r\n								<td valign=\"center\">\r\n									85.5\r\n								</td>\r\n								<td valign=\"center\">\r\n									108\r\n								</td>\r\n								<td valign=\"center\">\r\n									129\r\n								</td>\r\n								<td valign=\"center\">\r\n									35.3\r\n								</td>\r\n								<td valign=\"center\">\r\n									27.7\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n					<div style=\"margin:0px;padding:0px;font-family:微软雅黑;color:#666666;font-size:11px;\">\r\n						注：因手工测量方式不同，存在2~4cm误差皆属合理范围(尺寸单位：cm)。\r\n					</div>\r\n				</td>\r\n				<td>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	&nbsp;\r\n</p>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	&nbsp;<img align=\"absmiddle\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g1/M04/00/06/rBEGD1NwdKAIAAAAAALvlgVmWdUAABa2APzcpQAAu-u912.jpg\" class=\"err-product\" />\r\n</p>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	<img align=\"absMiddle\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M01/02/1F/rBEhVVNwdFoIAAAAAAAiT7IZyYoAANKZwNHUUIAACJn018.jpg\" class=\"err-product\" />\r\n</p>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	<img align=\"absMiddle\" alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g3/M05/00/06/rBEGFFNwdFoIAAAAAAD1X7RYjwEAABa3AEKcHEAAPV3940.jpg\" class=\"err-product\" />\r\n</p>', '1402408755', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('11', '韩衣丽舍 CY2014夏新款韩版女装牛仔拼接雪纺连衣裙牛仔裙长裙', '8866LYQ', '45', '169.00', '199.00', '<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"07fa5f8b0f644c76a62797fe4f0223fd \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t160/219/133431860/416493/1f76f4da/5381b727Ncc768598.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"33b92c2981f64ed284db15bfcf8ec883 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t157/9/166904638/396606/e139ba1b/5381b728Nf85cf14e.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"24af0f32f1564c6b9561b37ae76564c2 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t169/236/141384077/453903/ecd40fcd/5381b729Naa51a872.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"9e11efaccd814d2591cd289cfdc30151 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t199/201/156259466/298191/c67a93b2/5381b729Nae8b4b38.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<a href=\"http://item.jd.com/1024261341.html\" target=\"_blank\"><img alt=\"\" id=\"1b0b1f8de179444693cd910e750d6478 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t151/27/138670676/358548/17c3a50f/5381b72aN69f0c395.jpg\" class=\"err-product\" /></a>\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"097734a9f5574c6891bb0f9e9916590d \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t199/203/141943017/319697/36542a9e/5381b72bNd8ad94aa.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"6315ea92fe624a59803f0ffa4b186651 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t172/26/143204448/477155/923b5a9b/5381b72cN62693c95.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"0bfcabc7649c4c7d81354988ab8feec4 \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t208/355/136154145/377474/1cc3487e/5381b72cN65bcfb73.jpg\" class=\"err-product\" />\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;text-align:center;\">\r\n	<img alt=\"\" id=\"f6d36b1cfed141728277798329a57e1d \" src=\"http://img30.360buyimg.com/popWaterMark/jfs/t196/175/139809136/367694/57154e3a/5381b72dN28879b33.jpg\" class=\"err-product\" />\r\n</div>', '1402408977', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('12', '艾致倩 2014夏装新款韩版修身女装欧根纱短袖连衣裙', 'OXN6805', '12', '599.00', '168.00', '<img id=\"3615ebb4221f4797afef81df134a9b8a\" alt=\"\" src=\"http://img30.360buyimg.com/popWareDetail/g14/M02/1F/04/rBEhVVNWAwIIAAAAAAeVJL9aHNIAAMZ9wBR6tMAB5U8412.jpg\" class=\"err-product\" /><span style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">&nbsp;</span><br />\r\n<img id=\"bad72c8c72d448bab8963da4699f7534\" alt=\"\" src=\"http://img30.360buyimg.com/popWareDetail/g14/M05/1F/03/rBEhVVNWAvcIAAAAAAdlMWR8PEkAAMZ9QGb3jkAB2VJ750.jpg\" class=\"err-product\" />', '1402409224', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('13', '韩版修身女装欧根纱短袖短裤淑女套装两件套AZQHYYF887', '1056912', '5000', '168.00', '112.00', '<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g10/M00/1E/04/rBEQWFNknEUIAAAAAAsP7Wb7szsAAF51gFbMekACxAF429.jpg\" class=\"err-product\" />', '1402410194', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('14', '韩版修身女装雪纺短袖短裤淑女气质套装 ', 'AZQHYYF889', '12', '388.00', '188.00', '<img alt=\"\" id=\"ac037fb766d54957a20c15671cc07e58 \" src=\"http://img30.360buyimg.com/popWaterMark/g13/M00/00/0B/rBEhU1Nkk10IAAAAAAYkTiWQM-YAAMxZwM1CJ4ABiRm591.jpg\" class=\"err-product\" /><span style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">&nbsp;</span><br />\r\n<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M06/01/18/rBEhVlNkk4IIAAAAAAS2Qxpw2j0AAM66ALdnUYABLZb573.jpg\" class=\"err-product\" /><span style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">&nbsp;</span><br />\r\n<br />\r\n<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M06/01/18/rBEhV1Nkk4QIAAAAAA3vRomcFbcAAM66APTC2UADe9e973.jpg\" class=\"err-product\" /><span style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">&nbsp;</span>', '1402410284', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('15', '韩版修身无袖淑女圆领雪纺衫女短裙套装套裤两件套', '7546435', '34', '399.00', '148.00', '<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhV1NFProIAAAAAABCG8xwEJ0AALoUgMMgjQAAEIz736.jpg\" class=\"err-product\" />\r\n</p>\r\n<table height=\"298\" align=\"center\" border=\"1\" bordercolor=\"#000000\" width=\"730\" style=\"background-color:#FFFFFF;font-size:14px;font-family:tahoma, arial, 宋体, sans-serif;color:#333333;\">\r\n	<tbody>\r\n		<tr>\r\n			<td height=\"33\" width=\"162\">\r\n				<div align=\"center\" style=\"margin:0px;padding:0px;\">\r\n					<strong>测量方法</strong>\r\n				</div>\r\n			</td>\r\n			<td width=\"60\">\r\n				<div align=\"center\" style=\"margin:0px;padding:0px;\">\r\n					<strong>尺码</strong>\r\n				</div>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong>&nbsp;&nbsp;&nbsp;腰围&nbsp;&nbsp;&nbsp;</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong>&nbsp;&nbsp;&nbsp; 肩宽&nbsp;&nbsp;</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong>&nbsp;&nbsp;&nbsp; 胸围 &nbsp;&nbsp;&nbsp;</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong>&nbsp;&nbsp;&nbsp;衣长&nbsp;/裤长&nbsp;&nbsp;&nbsp;</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<strong></strong><br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td rowspan=\"6\">\r\n				<strong></strong><br />\r\n<img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhVlNFPrsIAAAAAACJkb4NtKQAALoUgMczN0AAImp921.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td height=\"36\" style=\"text-align:center;\">\r\n				<strong>M</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				72\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				33\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				88\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				60/30\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td height=\"36\">\r\n				<div align=\"center\" style=\"margin:0px;padding:0px;\">\r\n					<strong>L</strong>\r\n				</div>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				76\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				34\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				92\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				61/31\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td height=\"36\" style=\"text-align:center;\">\r\n				<strong>XL</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				80\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				35\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				96\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				62/32\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td height=\"36\" style=\"text-align:center;\">\r\n				<strong>XXL</strong>\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				84\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				36\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				100\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				62/33\r\n			</td>\r\n			<td style=\"text-align:center;\">\r\n				<br />\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td colspan=\"6\" height=\"36\" style=\"text-align:center;\">\r\n				<div align=\"center\" style=\"margin:0px;padding:0px;\">\r\n					注意：以上数据为平铺测量所得，没有拉伸，不考虑弹性范围内的数据。误差范围在1-3CM范围之内\r\n				</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td colspan=\"6\" height=\"36\" style=\"text-align:center;\">\r\n				模特资料：身高：166CM&nbsp;体重47KG&nbsp;三围：85/65/89&nbsp;&nbsp;试穿尺码：M码\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p align=\"center\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n	<font ??=\"\" style=\"margin: 0px; padding: 0px;\"><img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhVlNFPrsIAAAAAAHgq5TGtdQAALoUgMpNVQAAeDD587.jpg\" class=\"err-product\" /><img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhV1NFPrsIAAAAAABHcavPyIkAALoUgMvFt0AAEeJ853.jpg\" class=\"err-product\" /></span>\r\n</p>\r\n<font ??=\"\" style=\"margin: 0px; padding: 0px;\"><font ??=\"\" style=\"margin: 0px; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Verdana, 宋体; white-space: normal; background-color: rgb(255, 255, 255);\"><img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhVlNFPr0IAAAAAAe5mj9H7m8AALoUgNdJlgAB7my558.jpg\" class=\"err-product\" /><img alt=\"\" src=\"http://img30.360buyimg.com/popWaterMark/g14/M05/1F/0E/rBEhV1NFPr4IAAAAAAkjMBqbLScAALoUgOqf1UACSNI791.jpg\" class=\"err-product\" /></span></span>', '1402410421', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('16', '夏普（SHARP） 46英寸日本原装面板', 'LCD-46DS20A', '34', '3599.00', '3299.00', '<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M08/0C/0C/rBEhV1LP23gIAAAAAAKrQhwc71wAAH6PAG0qlgAAqta883.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div style=\"margin:0px;padding:0px;font-size:14px;\">\r\n		采用FullHD液晶屏，以1920x1080分辨力迎接数字时代\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		以1920×1080分辨力迎接数字电视新时代，呈现非凡出色的超精细画面。\r\n	</div>\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<div style=\"margin:0px;padding:0px;font-size:14px;\">\r\n		新1080/24P技术，以每秒24帧数的电影般播放模式\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		电影是由24帧数来拍摄的，新1080/24P技术，以每秒24帧数的电影般播放模式（在HDMI下支持1080P/24Hz）为您带来真正的影院效果，从未有过的视觉盛宴由AQUOS液晶电视带给您。\r\n	</div>\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M09/0C/0C/rBEhVVLP3FQIAAAAAAAzIX57aKYAAH6PQNxDKEAADM5955.jpg\" class=\"err-product\" />\r\n	</p>\r\n</div>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g15/M00/01/15/rBEhWFLP3MEIAAAAAAGzHsv9egUAAHx-gEQcIQAAbM2697.jpg\" class=\"err-product\" />\r\n</p>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<div style=\"margin:0px;padding:0px;font-size:14px;\">\r\n		倍速FullHD液晶驱动技术，高速动作处理更佳\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		夏普倍速液晶驱动技术。在通常50帧/秒的动画影像中，在两帧画像之间插入一帧画像，使信号提升2倍，即100帧/秒进行播放。使画面更流畅，全方位改善画面残留，大大减少画面拖尾现象，清晰再现高速运动的画面，带来更具震撼力的视觉体验。\r\n	</div>\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M0A/0C/0C/rBEhVlLP3SwIAAAAAAJH2h94X20AAH6PwB_qykAAkfy060.jpg\" class=\"err-product\" />\r\n	</p>\r\n</div>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M0A/0C/0C/rBEhVlLP3VgIAAAAAAHsx7Wj3xMAAH6PwNaDmUAAezf214.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		采用可以精确亮度控制并能告诉应答的LED背光源系统。结合新一代X超晶面板的使用，实现画面高对比度，在黑暗环境里也能再现纯正黑色和绚丽红色。\r\n	</div>\r\n</div>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g13/M03/0F/0E/rBEhU1LCir4IAAAAAAHPn-F09dQAAHevQI9mdUAAc-3112.jpg\" class=\"err-product\" />\r\n</p>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g14/M03/0A/16/rBEhVVLCi3MIAAAAAAMPUHuec08AAHlSwCCk4QAAw9o903.jpg\" class=\"err-product\" />\r\n</p>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g13/M09/0F/0E/rBEhU1LCi4wIAAAAAAKJJy-A0GcAAHewADfnfgAAok_965.jpg\" class=\"err-product\" />\r\n</p>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g14/M03/0A/16/rBEhVlLCi58IAAAAAAH146RVN9kAAHlSwMK9ogAAfX7360.jpg\" class=\"err-product\" />\r\n</p>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g15/M09/1F/1F/rBEhWVLCi7MIAAAAAALNsLPK9lkAAHdGAAHZZMAAs3I673.jpg\" class=\"err-product\" />\r\n</p>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M02/11/03/rBEhVFLP4CwIAAAAAAIrnR5jwgQAAHzuQAUq3YAAiu1444.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		采用数码环绕声技术，身临其境的感受，为您带来家庭影院级的享受，&nbsp;<br />\r\n再现电影或体育节目等扣人心弦的声音。\r\n	</div>\r\n</div>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g13/M02/11/03/rBEhVFLP4EoIAAAAAAGLXSBSAuQAAHzuQMw-80AAYt1128.jpg\" class=\"err-product\" />\r\n</p>\r\n<div style=\"margin:0px;padding:0px;color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<p>\r\n		<img src=\"http://img20.360buyimg.com/vc/g15/M06/01/15/rBEhWFLP4G8IAAAAAAA16DDFBoMAAHyAAP4qTcAADYA742.jpg\" class=\"err-product\" />\r\n	</p>\r\n	<div style=\"margin:0px;padding:0px;font-size:14px;\">\r\n		您可以通过MHL线（市面有售），将支持MHL的智能手机与电视机连接，可以实现在电视&nbsp;<br />\r\n机的大画面上观看手机中的图像与视频，还可通过电视机的扬声器播放手机中的音乐。\r\n	</div>\r\n</div>\r\n<p style=\"color:#666666;font-family:微软雅黑;background-color:#F0F0F0;\">\r\n	<img src=\"http://img20.360buyimg.com/vc/g15/M06/1D/08/rBEhWVKxT-EIAAAAAALdEus4i7YAAG7BQOhvIUAAt0q265.gif\" class=\"err-product\" />\r\n</p>', '1402410567', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('17', '三星（SAMSUNG） HT-F453K 5.1声道家庭影院 黑色', 'HT-F453K', '123', '3211.00', '2311.00', '<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_titlecenter\" style=\"margin:0px;padding:0px;text-align:center;font-weight:700;\">\r\n		经典畅销再延续 三星科技再升级\r\n	</div>\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		HT-F453K家庭影院，一直以来是畅销的主力机型。现在三星优秀的设计团队再次将经典延续，并注入了新的设计呈现给大家，三星家庭影院系统凭借其独特的外观设计、便捷的功能以及先进的音效提升技术为消费者带来了无缝的连接体验和纯净的音质表现，这也使其成为了今年三星电视产品的最佳音频伴侣。现在请和我们一起尽享1000w5.1声道为您带来的畅爽感官体验。\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品特色</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Selling Point</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g15/M00/04/0F/rBEhWFIJ6fIIAAAAAAOcAz2GvKAAACAdgP2LOYAA5wb121.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		三星HT-F453K家庭娱乐系统的设计是为实现更深层次的低音和更丰富的声音。通过连接共享功能及拓展,我们可以轻松欣赏USB内存驱动器或硬盘中的电影或是您记录幸福点滴的帅气照片。音箱简易设置令使用更加便利.卡拉OK为您带来的乐趣，Anynet+.音频回传.水晶功放自适应.USB自适应.丰富的接口设置等等一切，彰显HT-F453K的实用与时尚。\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g12/M00/0B/17/rBEQYFGl2jQIAAAAAABpLFDqsJ8AACSkwOhOfcAAGlE164.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-weight:700;\">\r\n		兼具便捷性与科技感的扬声器设置\r\n	</div>\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		简单快捷的音响设置模式，让您在家中轻松畅享高品质音效。它拥有直观的图形用户界面，并为您自动提升立体音效，您无需再操心音响的摆放位置。三星家庭影院，带给您极致观影体验。\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g12/M00/0C/1A/rBEQYVGpgfUIAAAAAAH1aBjkyyQAACgLAFTyEgAAfWA773.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_titleleft\" style=\"margin:0px;padding:0px;font-weight:700;\">\r\n		低音炮升级带来超逼真的音效感受\r\n	</div>\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		配备前置设计的重低音喇叭，加强重低音技术，为您带来更丰富层次感的音色体验，无论观赏电视节目、电影或欣赏音乐，都可以给您犹如身临其境的逼真音效。而且，强大影音效能集一身，让您足不出户也可体验电影院般的视听感受。比需要另外配置昂贵设备的同类产品尤其优胜！浩瀚的宇宙.蔚蓝的天空，此刻你的心是否随之翱翔那?\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g12/M00/0B/1F/rBEQYFGm6PsIAAAAAAFsgqJ_VC4AACVyQP93Z0AAWya123.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_titlecenter\" style=\"margin:0px;padding:0px;text-align:center;font-weight:700;\">\r\n		功能完备 娱乐家居生活\r\n	</div>\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		HT-F453K 支持卡拉ok，消声（部分碟盘格式可能不支持）及打分，支持调节回声电平;周末举办一场家庭卡拉ok比赛吧，让紧张的生活节奏放松一下吧，让你的好心情随歌声飞扬吧，生活就应该这样愉快。\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品细节</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Product Details</span>\r\n	</div>\r\n</div>\r\n<table width=\"750\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"6\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;font-size:12px;background-color:#FFFFFF;\" class=\"ke-zeroborder\">\r\n	<tbody>\r\n		<tr>\r\n			<td width=\"20%\">\r\n				<img src=\"http://img20.360buyimg.com/vc/g12/M00/0B/17/rBEQYVGl3TAIAAAAAACxfqDiSGoAACSoAP2DD8AALGW969.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td width=\"30%\">\r\n				<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;\">\r\n					HDMI (ARC)\r\n				</p>\r\n				<p class=\"formwork_titleleft2\" style=\"font-size:14px;\">\r\n					无需使用单独线缆进行连接，只需通过HDMI ARC (音频回传通道)，即可轻松连接兼容设备，处理电视音频信号。通过更少的线缆，只需要2个HDMI，即可连接音频设备，让您体验全新的音频世界。\r\n				</p>\r\n			</td>\r\n			<td width=\"20%\">\r\n				<img src=\"http://img20.360buyimg.com/vc/g12/M00/0B/17/rBEQYFGl3iMIAAAAAAAPnFh0sukAACSpAP7OVcAAA-0946.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td width=\"30%\">\r\n				<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;\">\r\n					多媒体连接\r\n				</p>\r\n				<p class=\"formwork_titleleft2\" style=\"font-size:14px;\">\r\n					通过连接即可分享视频, 您只需将USB内存驱动器或移动驱动器插入家庭影院，即可欣赏您喜爱的节目。\r\n				</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<table width=\"750\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"6\" style=\"color:#666666;font-family:Arial, Verdana, 宋体;font-size:12px;background-color:#FFFFFF;\" class=\"ke-zeroborder\">\r\n	<tbody>\r\n		<tr>\r\n			<td width=\"20%\">\r\n				<img src=\"http://img20.360buyimg.com/vc/g12/M00/0C/02/rBEQYVGnBFgIAAAAAAAT5kFN-XwAACW3wMquKwAABP-443.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td width=\"30%\">\r\n				<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;\">\r\n					专属模式\r\n				</p>\r\n				<p class=\"formwork_titleleft2\" style=\"font-size:14px;\">\r\n					使用FOOTBALL键可以欣赏到犹如足球场上的音乐，你会感觉置身于场内一样。将遥控器按功能键选择FM，收听您喜爱的电台节目，你可以预设1-15个电台，想听就听。\r\n				</p>\r\n			</td>\r\n			<td width=\"20%\">\r\n				<img src=\"http://img20.360buyimg.com/vc/g12/M00/0C/02/rBEQYFGnBF8IAAAAAAAPK7wxCcYAACW3wP_1cYAAA9D151.jpg\" class=\"err-product\" />\r\n			</td>\r\n			<td width=\"30%\">\r\n				<p class=\"formwork_titleleft\" style=\"font-size:14px;font-weight:700;\">\r\n					安全设置\r\n				</p>\r\n				<p class=\"formwork_titleleft2\" style=\"font-size:14px;\">\r\n					家长锁功能与指定评级DVD配合使用，指定评级可帮您控制家庭成员观看DVD类型，光盘最多分为8个评级，真正做到安全观看。\r\n				</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M03/0A/12/rBEhVVIK-TYIAAAAAAHmrnAnxxQAACEPQCZN5UAAebG208.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">尺寸信息</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Size Information</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M09/05/1A/rBEhUlIK-M0IAAAAAABSvlzDYpIAACCEQMKwVwAAFLW491.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M03/05/1A/rBEhU1IK-kUIAAAAAACSrbnEfnEAACCFwBSLbkAAJLF787.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n	</div>\r\n</div>', '1402410698', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('18', '美的（Midea）  近吸式吸油烟机', 'CXW-200-DJ213', '23', '1699.00', '1499.00', '<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品信息</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Product Information</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M04/14/1C/rBEhVVJYpsAIAAAAAACpJSF_RR4AAEFPwCmORQAAKk9728.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品细节</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Product Details</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g15/M05/0E/1D/rBEhWlJYpwoIAAAAAACAc_IcpT4AAEC3QFxIqEAAICL559.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M04/14/1C/rBEhVVJYpxUIAAAAAAB2d8MxlOsAAEFPwHHJzUAAHaP334.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M04/14/1C/rBEhVlJYpyIIAAAAAABspRXmbnEAAEFPwLXMWcAAGy9163.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M04/14/1C/rBEhVlJYpywIAAAAAACSmHYT0I0AAEFPwO3SLcAAJKw955.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M08/14/1C/rBEhVlJYp0gIAAAAAABufB5Nmh0AAEFQAJg4pgAAG6U783.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M04/10/03/rBEhU1JYp1MIAAAAAABw92REWJcAAECoAPe-XcAAHEP895.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_text\" style=\"margin:0px;padding:0px;\">\r\n		全不锈钢设计；大进风设计；琴键式设计；多种风速调节；渐明渐暗护眼灯；\r\n	</div>\r\n</div>\r\n<div class=\"formwork_bt\" style=\"margin:0px;padding:10px 0px;font-size:14px;font-family:Arial, Helvetica, sans-serif;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_bt_dz\" style=\"margin:0px;padding:0px;\">\r\n		<span style=\"line-height:25px;font-family:微软雅黑;color:#FFFFFF;\">产品特色</span><span class=\"s2\" style=\"line-height:20px;font-family:微软雅黑;font-size:12px;color:#FFFFFF;\">Selling Point</span>\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g13/M05/10/03/rBEhUlJYp2YIAAAAAAD7s_d8ARYAAECoQM1_ioAAPvL996.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>\r\n<div class=\"formwork\" style=\"margin:0px;padding:10px 0px;font-family:Arial, Helvetica, sans-serif;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<div class=\"formwork_img\" style=\"margin:0px auto;padding:0px;text-align:center;\">\r\n		<img src=\"http://img20.360buyimg.com/vc/g14/M08/14/1C/rBEhVlJYp6EIAAAAAADIVxa12-AAAEFQANj3LAAAMhv206.jpg\" class=\"err-product\" />\r\n	</div>\r\n</div>', '1402410808', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('19', '海尔（Haier） XQG70-B10866 电商 7公斤 变频滚筒洗衣机', 'XQG70-B10866', '12', '3399.00', '3299.00', '<div class=\"right\" style=\"margin:0px;padding:0px;\">\r\n	<div id=\"product-detail\" class=\"m m1\" style=\"margin:0px 0px 10px;padding:2px 0px 0px;\">\r\n		<div class=\"mc\" id=\"product-detail-1\" style=\"margin:0px;padding:0px;\">\r\n			<div class=\"detail-content\" style=\"margin:0px;padding:0px;\">\r\n				<table align=\"center\" width=\"750\">\r\n					<tbody>\r\n						<tr>\r\n							<td>\r\n								<a target=\"_blank\" href=\"http://sale.jd.com/act/OpjCvlLcN5uo.html\"><img alt=\"\" src=\"http://img30.360buyimg.com/jgsq-productsoa/jfs/t154/129/656904086/101633/5f6cae2d/53952f8bN50c53e38.jpg\" class=\"err-product\" /></a>\r\n							</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n				<table align=\"center\" width=\"750\">\r\n					<tbody>\r\n						<tr>\r\n							<td>\r\n								<a target=\"_blank\" href=\"http://sale.jd.com/act/P6FWJzn5VILf.html\"><img alt=\"\" src=\"http://img30.360buyimg.com/jgsq-productsoa/jfs/t145/37/561203875/116765/194fd8d4/5391245fN7e3d69e6.png\" class=\"err-product\" /></a>\r\n							</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n				<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"750\" class=\"ke-zeroborder\">\r\n					<tbody>\r\n						<tr>\r\n							<td valign=\"top\">\r\n								<a target=\"_blank\" href=\"http://sale.jd.com/act/vfQlPDUkRy8zO3b.html\"><span id=\"_xhe_cursor\"></span><span id=\"_xhe_temp\"></span><img alt=\"\" src=\"http://img30.360buyimg.com/jgsq-productsoa/jfs/t184/49/715984598/64095/140538d4/53969d4bN7bf24700.jpg\" class=\"err-product\" /></a>\r\n							</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n				<div style=\"margin:0px auto;padding:0px;\">\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M08/15/00/rBEhWlNGdoMIAAAAAAJFhIQwiJAAALj9gBQXRsAAkWc704.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M08/15/00/rBEhWVNGdpMIAAAAAAGoualDSyMAALj9gFpa4sAAajR495.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							无碳刷设计，避免普通串激电机碳刷摩擦产生的风啸声及电火花，超级静音，夜晚洗衣也安静。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							360°零缝隙控制信号，平滑调速，精准调控电机运转及洗涤节奏，精准洗涤，节能减碳，带来绿色的低碳体验.\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							外驱动升级为内驱动，直效内驱，转速&nbsp;<br />\r\n高达1000转/分钟，大幅提升滚筒洗净&nbsp;<br />\r\n能力，洗净比最高达1.23*。\r\n							<div style=\"margin:20px 0px 0px;padding:0px;font-size:12px;\">\r\n								* 数据来源：经国家家用电器质量监督检测中心检测得出\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M08/15/00/rBEhWVNGdqAIAAAAAAPBk98FIyYAALj9gLRQW4AA8Gr051.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							洗衣机静止状态下，经过电脑模拟及实机模拟测定，精确选定6个平衡支撑点用以保持滚筒稳定性，在启动洗衣机前排除滚筒自身不平衡因素，保证洗衣机运转平稳。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							洗衣机运转过程中，HPM芯平衡系统主动调整高碳素钢挂簧及空气阻尼器的拉伸强度，即时调整洗涤过程中产生的偏心，始终保持平衡，即使宝宝的毛绒玩具熊也能轻松洗净、甩干。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							薄壳仿生原理设计，受力均匀、耐压，极大提高承受强度的同时避免箱体与各部件之间发生共振，减小洗涤振动与噪声。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							不同的污渍用不同的水温洗涤效果更佳，海尔洗衣机每一个程序可以自动调节水温，充分发挥酶的活性，达到最好的洗涤效果。\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M08/15/00/rBEhWFNGdqsIAAAAAAJWq-x0IZIAALj9gPkfDgAAlbD646.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:14px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:22px;\">\r\n								1.独创弹力筋\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								海尔独创弹力筋内筒，平滑的筒壁上分布有128道弹力筋，弹力筋中间凹槽密布3234个脱水小孔。内筒旋转带动弹力筋不断击荡水流，产生震荡水波，颠簸式洗涤衣物，弹落顽固污渍，同时激发织物纤维活性。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:14px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:22px;\">\r\n								2.活力弹污 三重洗涤更干净\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								独特弹力筋洗涤方式，辅以传统垂直摔打洗涤及立体喷射水流，三重洗涤，快速去除深层污垢；同时，污垢从最低处脱水孔通畅排出，导垢彻底，洁净效果更加显著。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:14px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:22px;\">\r\n								3.完美护衣&nbsp;<br />\r\n焕发衣物纤维活力\r\n							</div>\r\n							<div style=\"margin:10px 0px 0px;padding:0px;\">\r\n								弹力筋犹如支起的“支架”，避免衣物与脱水孔间的磨擦，同时减少洗涤水流对衣物的拉伸力度，柔和洗涤，还原织物纤维弹性，衣物洗后蓬松柔软。\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M0A/1A/12/rBEhWFNfaMQIAAAAAAR0oGyUsFAAAMpRgNjxb4ABHS4526.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								洁净生活迅速拥有\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								洗涤、漂洗、甩干全部完成只需15分钟，夏天衣物及时洗，少量衣物随时洗，满足您经常换洗衣物的洁净需求。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								洗衣机也有洁癖\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								洗时段自动增加摔打揉搓的时间和强度，与顽固污渍奋战到底。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								多一次漂洗才格外干净\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								在原有漂洗次数基础上，增加一次漂洗，衣物漂洗更干净。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								多几种选择 多几分呵护\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								电脑控制，独立水温调节，较大较脏衣物加热到40℃，充分激活活性酶；洗小孩、病人衣物加热到90℃，杀菌消毒。\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g13/M02/04/0D/rBEhUlNGdsYIAAAAAAOtvhbTadUAALk4QG6Iv8AA63W767.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								轻松跟上你想要的速度\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								脱水转速可根据需要进行调整，选择范围从400,600,800至1000转每分钟,呵护您和家人的衣物，省心力，随心意。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								我的时间我做主\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								24小时预约洗涤，时间一到衣服就洗好，特别适合上班族和分时电价地区。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								抑制霉菌滋生，健康呵护倍增\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								经权威机构测定，抗菌率&gt;99％，达到最高等级，有效抑制霉菌滋生。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								方便快捷\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								安全状态下可开启筒门，方便中途添加衣物；洗衣结束立即开门，无需等待\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							<div style=\"margin:0px;padding:0px;font-size:20px;\">\r\n								人性设计 舒适洗衣\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								45°筒门开启设计，符合人机原理，操作不弯腰，方便又省力 。\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g13/M02/04/0D/rBEhUlNGdtQIAAAAAAJtWA2eTVoAALk4gAZ7osAAm1w237.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								鼠标式程序旋钮\r\n							</div>\r\n弱电工作、安全可靠、操作方便、使用寿命更长。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								LED显示\r\n							</div>\r\n一目了然，轻松洗衣\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								AMT防霉抗菌窗垫\r\n							</div>\r\n抑制霉菌滋生，健康呵护倍增\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								抽屉式洗衣粉盒\r\n							</div>\r\n洗衣粉和洗涤剂分开投放，溶解充分，一体式设计避免藏污纳垢藏污纳垢。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;\">\r\n							<div style=\"margin:0px 0px 5px;padding:0px;font-size:16px;\">\r\n								筒壁上分布128道弹力筋\r\n							</div>\r\n降低磨损，提高洗净比\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M00/1B/10/rBEhVlNGduMIAAAAAAeTlV7qJfEAALs9QAJanQAB5Ot945.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							台面板采用一体式设计，四面封胶，杜绝安全隐患。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：台面板采用装订拼接工艺，易渗水受潮导致台面鼓，台面发霉等，如与电器接触可引起起火等重大安全隐患。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							分配盒使用优质工程塑料，强度高分配器盒内壁镜面抛光，冲洗无残留。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：分配器盒使用回用料，颜色深，性能差，易损坏。内壁粗糙有毛刺，洗衣粉粘结在盒内，造成漂洗不干净。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							窗垫无残留泡沫、不会发生发霉变黑现象。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：窗垫残留泡沫，发霉变黑。\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g12/M00/06/1F/rBEQYFNGdwAIAAAAAAfod5BRH_wAAEL2QJ6K-QAB-iP295.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							内筒内后法兰打孔工艺，可以让洗涤时水流冲刷力更强，对衣服形成多角度冲刷，提高洗净率。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：内筒后法兰工艺简单，无孔。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							铰链厚度厚，表面电镀镜面处理，坚固不生锈。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：观察窗门铰链厚度薄，表面简单镀锌，处理简单，易生锈。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							内筒采用正反冲，弹力筋，微孔脱水工艺，洗涤时弹力筋产生激荡水流，降低磨损，提高洗净比，呵护衣物。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：内筒采用原始的单面冲孔工艺，孔眼大，易产生毛刺且高速甩干时对衣服磨损大（特别在洗涤羊毛，真丝等高档面料。）\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M00/1B/10/rBEhV1NGdxAIAAAAAATquM1eU3UAALs9QKNJSkABOrQ317.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							有电脑板盒保护，安全性高（正如电视机需要后盖一样，既能保护电脑版，又不影响散热）。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：电脑板裸露，存在极大安全隐患（因静电作用，易吸附潮气，灰尘等，带来不安全隐患）。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							内筒焊接工艺，采用第三代激光无缝焊接，可承受超高转速负荷；\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#DDDDDD;font-size:15px;\">\r\n							其他品牌高端滚筒洗衣机：采用第一代扣缝工艺，不能承受高转速负荷\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M00/1B/10/rBEhV1NGdxwIAAAAAAG-ZqoUWgAAALs9QOpdaEAAb5-761.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M04/1B/10/rBEhVVNGdykIAAAAAACfGVhD7aQAALs9gCEr0AAAJ8x452.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#DDDDDD;\">\r\n							产品型号&nbsp;<br />\r\n电机类型&nbsp;<br />\r\n内桶材质&nbsp;<br />\r\n上市时间&nbsp;<br />\r\n洗涤功率&nbsp;<br />\r\n洗衣机能效等级&nbsp;<br />\r\n箱体材质&nbsp;<br />\r\n显示方式&nbsp;<br />\r\n脱水功率&nbsp;<br />\r\n尺寸（高*宽*深mm）&nbsp;<br />\r\n产品净重\r\n							<div style=\"margin:15px 0px;padding:0px;\">\r\n								洗衣程序\r\n							</div>\r\n产品毛重&nbsp;<br />\r\n洗净比&nbsp;<br />\r\n是否预约&nbsp;<br />\r\n开门方式&nbsp;<br />\r\n排水方式&nbsp;<br />\r\n洗涤公斤量&nbsp;<br />\r\n洗衣/干衣机型&nbsp;<br />\r\n自动化程度\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#DDDDDD;\">\r\n							XQG70-B10866 电商&nbsp;<br />\r\n变频电机&nbsp;<br />\r\n不锈钢&nbsp;<br />\r\n2013年&nbsp;<br />\r\n250&nbsp;<br />\r\n1级&nbsp;<br />\r\n渗锌钢板&nbsp;<br />\r\nLED&nbsp;<br />\r\n450&nbsp;<br />\r\n850*595*600&nbsp;<br />\r\n71&nbsp;<br />\r\n							<div style=\"margin:10px 0px 12px;padding:0px;\">\r\n								内衣、羊毛、化纤、棉麻、预洗、&nbsp;<br />\r\n小件、快洗、单洗、单漂、单甩\r\n							</div>\r\n78&nbsp;<br />\r\n1.03&nbsp;<br />\r\n有&nbsp;<br />\r\n前开式&nbsp;<br />\r\n上排水&nbsp;<br />\r\n7公斤&nbsp;<br />\r\n洗衣机&nbsp;<br />\r\n全自动&nbsp;<br />\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M06/15/00/rBEhWVNGdzMIAAAAAACQYo-RwtoAALj9wE4e3sAAJB6251.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M06/15/00/rBEhWFNGdz4IAAAAAABPj0St3E8AALj9wL6qmsAAE-n852.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#FFFFFF;font-size:20px;\">\r\n							滚筒洗衣机使用一段时间后的保养方法\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:0px 0px 0px 10px;padding:0px;\">\r\n								滚筒洗衣机使用一段时间后的保养方法：\r\n							</div>\r\n【1】不洗衣时，应将机门微开，以便透风，防止筒内出现异味。&nbsp;<br />\r\n【2】带过滤器的滚筒洗衣机要定期清理过滤器，以防堵塞。&nbsp;<br />\r\n【3】不要将洗衣机放在潮湿的环境里，以防电器件受潮，缩短机器寿命。&nbsp;<br />\r\n【4】洗衣机的底部经常保持清洁干燥，以防箱体生锈。&nbsp;<br />\r\n【5】使用几次后，应将分配器盒拉出来清理。\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;color:#FFFFFF;font-size:20px;\">\r\n							滚筒洗衣机如何安置才可以减轻震动？\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							减振方法：&nbsp;<br />\r\n滚筒洗衣机安放时，四个底角应在同一平面上，洗衣机底部不能倾斜，不能垫木板等垫块，也不宜放置在底部悬空的木地板上。而且，洗衣机安放时应取出洗衣机运输包装的固定用螺栓、泡沫等材料，这样就可以有效减轻振动。\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M01/15/00/rBEhWlNGd0oIAAAAAABb7xRVdXoAALj-ACGGjwAAFwH038.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;color:#FFFFFF;font-size:20px;\">\r\n							安装条件：\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:3px 0px 0px;padding:0px;\">\r\n								安放位置不能太潮湿，地面不能太光滑或不平，不能安装在台子上，环境温度不能低于0度；\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								如卫生间不适合摆放洗衣机，可以设计到厨房，客厅，阳台等位置；\r\n							</div>\r\n							<div style=\"margin:20px 0px 0px;padding:0px;\">\r\n								电源要求：220V/50HZ交流电，使用单独的三相插座，并有可靠接地，滚筒洗衣机插座最大承载电流不低于15A;\r\n							</div>\r\n							<div style=\"margin:15px 0px 0px;padding:0px;\">\r\n								安装的位置最好有地漏，以保证排水通畅；\r\n							</div>\r\n							<div style=\"margin:30px 0px 0px;padding:0px;\">\r\n								自来水压力在0.03-1MPA（兆帕）之间。\r\n							</div>\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g15/M01/15/00/rBEhWFNGd1UIAAAAAACxG3mx-pcAALj-AKc7mkAALEz929.jpg\" class=\"err-product\" />\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							收费项目&nbsp;<br />\r\n							<div style=\"margin:25px 0px 0px;padding:0px;\">\r\n								加长进水管\r\n							</div>\r\n							<div style=\"margin:60px 0px 0px;padding:0px;\">\r\n								加长排水管\r\n							</div>\r\n							<div style=\"margin:190px 0px 0px;padding:0px;\">\r\n								水龙头\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:5px 0px 0px;padding:0px;\">\r\n								收费说明\r\n							</div>\r\n							<div style=\"margin:10px 0px 0px;padding:0px;\">\r\n								由于用户的使用环境不同如果安装过程中需要加长进水管，加长的进水管需要另行收费\r\n							</div>\r\n							<div style=\"margin:3px 0px 0px;padding:0px;\">\r\n								由于用户的使用环境不同如果安装过程中需要加长排水管，加长的排水管需要另行收费\r\n							</div>\r\n							<div style=\"margin:70px 0px 0px;padding:0px;\">\r\n								1、如用户需要安装水龙头可以自行选购安装符合标准的水龙头。\r\n							</div>\r\n							<div style=\"margin:110px 0px 0px;padding:0px;\">\r\n								2、用户也可以选购海尔提供的水龙头，海尔可以收费提供专用水龙头，并负责免费安装。\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:5px 0px 0px;padding:0px;\">\r\n								收费标准\r\n							</div>\r\n							<div style=\"margin:10px 0px 0px;padding:0px;\">\r\n								加长0.5米（12元/根） 加长1米（15元/根） 加长2米（20元/根）\r\n							</div>\r\n							<div style=\"margin:50px 0px 0px;padding:0px;\">\r\n								加长1.5米（5元/根）\r\n							</div>\r\n							<div style=\"margin:105px 0px 0px;padding:0px;\">\r\n								标准水龙头46元/个\r\n							</div>\r\n							<div style=\"margin:150px 0px 0px;padding:0px;\">\r\n								精品水龙头65元/个\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							<div style=\"margin:5px 0px 0px;padding:0px;\">\r\n								收费标准\r\n							</div>\r\n							<div style=\"margin:70px 0px 0px;padding:0px;\">\r\n								进水管、排水管&nbsp;<br />\r\n为整根加长\r\n							</div>\r\n							<div style=\"margin:80px 0px 0px;padding:0px;\">\r\n								- 专享三年超长保修服务&nbsp;<br />\r\n免除您的后顾之忧&nbsp;<br />\r\n- 采用行业内锻压、冲孔工艺，内壁光滑耐腐蚀，密度高&nbsp;<br />\r\n- 主体采用纯铜材料，防锈，经久耐用，陶瓷阀芯，耐磨性高\r\n							</div>\r\n							<div style=\"margin:20px 0px 0px;padding:0px;\">\r\n								- 专享三年超长保修服务免除您的后顾之忧&nbsp;<br />\r\n- 货真价实的材料，主体采用纯铜制造，密度高，抗氧化，防锈斑，陶瓷阀芯，耐磨性高&nbsp;<br />\r\n- 完全贴合洗衣机进水管的设计，密封效果好，有效防止滴漏\r\n							</div>\r\n						</div>\r\n						<div style=\"margin:0px;padding:0px;font-size:14px;color:#FFFFFF;\">\r\n							说明：&nbsp;<br />\r\n因每位用户的安装环境不同，需求不同，安装过程中需要其它辅加材料或特殊服务项目，具体收费标准参考《海尔维修服务收费标准》。服务人员上门安装时会出示收费标准并讲解，同时请您监督我们的服务，如发现服务人员多收费，可拨打海尔售后统一服务热线投诉并有权拒绝付费，经核实属实的，本次服务“免单”（全额退还收取的安装材料费）。\r\n						</div>\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M04/1B/10/rBEhVlNGd2MIAAAAAAGjmqPCFhoAALs9gG-XXgAAaOy289.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g13/M02/04/0D/rBEhU1NGd28IAAAAAALQCZn9Ba8AALk4gIMgdAAAtAh713.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g13/M04/04/0D/rBEhUlNGd4sIAAAAAAFQtPmsSlYAALk4wJsJ20AAVDM520.jpg\" class=\"err-product\" />\r\n					</div>\r\n					<div style=\"margin:0px;padding:0px;\">\r\n						<img src=\"http://img20.360buyimg.com/vc/g14/M04/1B/10/rBEhVlNGd5YIAAAAAAMTkbIuygQAALs9gLoUG4AAxOp692.jpg\" class=\"err-product\" />\r\n					</div>\r\n				</div>\r\n				<table align=\"center\" width=\"750\">\r\n					<tbody>\r\n						<tr>\r\n							<td>\r\n								<img alt=\"\" src=\"http://img30.360buyimg.com/jgsq-productsoa/g13/M09/0F/0B/rBEhU1LCWgoIAAAAAACAkL3yMvEAAHd2wElDz0AAICo828.jpg\" class=\"err-product\" />\r\n							</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</div>\r\n		</div>\r\n		<div id=\"promises\" style=\"margin:0px;padding:10px;\">\r\n			<strong>服务承诺：</strong><br />\r\n京东商城向您保证所售商品均为正品行货，京东自营商品开具机打发票或电子发票。凭质保证书及京东商城发票，可享受全国联保服务（奢侈品、钟表除外；奢侈品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。京东商城还为您提供具有竞争力的商品价格和<a href=\"http://www.jd.com/help/kdexpress.aspx\" target=\"_blank\">运费政策</a>，请您放心购买！&nbsp;<br />\r\n注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！\r\n		</div>\r\n		<div id=\"state\" style=\"margin:0px;padding:10px;\">\r\n			<strong>权利声明：</strong><br />\r\n京东商城上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是京东商城重要的经营资源，未经许可，禁止非法转载使用。\r\n			<p>\r\n				<b>注：</b>本站商品信息均来自于厂商，其真实性、准确性和合法性由信息拥有者（厂商）负责。本站不提供任何保证，并不承担任何法律责任。\r\n			</p>\r\n		</div>\r\n	</div>\r\n	<div id=\"comment\" class=\"m m2\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;font-size:14px;font-family:\'microsoft yahei\';\">\r\n			<h2 style=\"font-size:14px;font-weight:400;\">\r\n				商品评价\r\n			</h2>\r\n		</div>\r\n		<div class=\"mc\" style=\"margin:0px;padding:10px 0px;\">\r\n			<div class=\"iloading\" style=\"margin:0px auto;padding:0px 0px 0px 22px;color:#999999;\">\r\n				正在加载中，请稍候...\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"comments-list\" class=\"m\" style=\"margin:0px 0px 20px;padding:2px 0px 0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;font-size:14px;font-family:\'microsoft yahei\';\">\r\n			<ul class=\"tab\">\r\n				<li class=\"curr\" style=\"text-align:center;color:#E4393C;background-color:#FFFFFF;\">\r\n					<a>全部评价(0)</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>好评(0)</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>中评(0)</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>差评(0)</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>有晒单的评价(0)</a>\r\n				</li>\r\n				<li class=\"tab-last\" style=\"text-align:center;\">\r\n				</li>\r\n			</ul>\r\n		</div>\r\n		<div id=\"comment-0\" class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<div class=\"iloading\" style=\"margin:20px auto;padding:0px 0px 0px 22px;color:#999999;\">\r\n				正在加载中，请稍候...\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"consult\" class=\"m m1\" style=\"margin:0px 0px 20px;padding:2px 0px 0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;font-size:14px;font-family:\'microsoft yahei\';\">\r\n			<ul class=\"tab\">\r\n				<li class=\"curr\" style=\"text-align:center;color:#E4393C;background-color:#FFFFFF;\">\r\n					<a>全部购买咨询</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>商品咨询</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>库存配送</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>支付</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>发票保修</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>支付帮助</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>配送帮助</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>常见问题</a>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n		<div id=\"consult-search\" style=\"margin:0px;padding:10px 16px;\">\r\n			<div class=\"form\" style=\"margin:0px;padding:0px;\">\r\n				咨询前请先搜索，方便又快捷：\r\n			</div>\r\n			<div class=\"prompt\" style=\"margin:0px;padding:9px 0px 9px 16px;color:#9C9A9C;\">\r\n				<strong>温馨提示:</strong>因厂家更改产品包装、产地或者更换随机附件等没有任何提前通知，且每位咨询者购买情况、提问时间等不同，为此以下回复仅对提问者3天内有效，其他网友仅供参考！若由此给您带来不便请多多谅解，谢谢！\r\n			</div>\r\n		</div>\r\n		<div id=\"consult-0\" class=\"mc tabcon\" style=\"margin:0px;padding:0px;\">\r\n			<div class=\"iloading\" style=\"margin:0px auto;padding:0px 0px 0px 22px;color:#999999;\">\r\n				正在加载中，请稍候...\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"discuss\" class=\"m m1\" style=\"margin:0px 0px 10px;padding:2px 0px 0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;font-size:14px;font-family:\'microsoft yahei\';\">\r\n			<ul class=\"tab\">\r\n				<li class=\"curr\" style=\"text-align:center;color:#E4393C;background-color:#FFFFFF;\">\r\n					<a>网友讨论圈</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>晒单贴</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>讨论贴</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>问答贴</a>\r\n				</li>\r\n				<li style=\"text-align:center;\">\r\n					<a>圈子贴</a>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n		<div id=\"discuss-1\" class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<div class=\"iloading\" style=\"margin:0px auto;padding:0px 0px 0px 22px;color:#999999;\">\r\n				正在加载中，请稍候...\r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>\r\n<div class=\"left\" style=\"margin:0px;padding:0px;\">\r\n	<div id=\"related-sorts\" class=\"m m2\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n			<h2 style=\"font-size:14px;font-weight:400;\">\r\n				相关分类\r\n			</h2>\r\n		</div>\r\n		<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<ul class=\"lh\">\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-798.html\">平板电视</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-870.html\">空调</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-878.html\">冰箱</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-880.html\">洗衣机</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-823.html\">家庭影院</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-965.html\">DVD播放机</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1199.html\">迷你音响</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1300.html\">烟机/灶具</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1706.html\">热水器</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1301.html\">消毒柜/洗碗机</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1707.html\">酒柜/冰吧/冷柜</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-877.html\">家电配件</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://list.jd.com/737-794-1013.html\">家电下乡</a>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</div>\r\n	<div id=\"related-brands\" class=\"m m2\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n			<h2 style=\"font-size:14px;font-weight:400;\">\r\n				同类其他品牌\r\n			</h2>\r\n		</div>\r\n		<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<ul class=\"lh\">\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-18403.html\">小天鹅（Little Swan）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-7817.html\">海尔（Haier）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-2505.html\">TCL</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-16407.html\">松下（Panasonic）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-7408.html\">格兰仕（Galanz）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-22186.html\">统帅（Leader）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-17382.html\">威力（WEILI）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-15133.html\">三洋（SANYO）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-1528.html\">LG</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-12380.html\">美的（Midea）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-18423.html\">小鸭</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-18177.html\">现代（HYUNDAI）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-10317.html\">康佳（KONKA）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-7888.html\">海信（Hisense）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-17887.html\">西门子（SIEMENS）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-14705.html\">日普（RIPU）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-19909.html\">樱花（Sakura）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-9508.html\">金松（JINSONG）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-14734.html\">荣事达（Royalstar）</a>\r\n				</li>\r\n				<li>\r\n					<a href=\"http://www.jd.com/pinpai/880-15127.html\">三星（SAMSUNG）</a>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		<div id=\"view-buy\" class=\"m m2 related-buy hide\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n			<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n				<h2 style=\"font-size:14px;font-weight:400;\">\r\n					浏览了该商品的用户最终购买了\r\n				</h2>\r\n			</div>\r\n			<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n				<ul>\r\n					<li class=\"fore1\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015650.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG70-1000J 7公斤 1000转滚筒洗衣机（银灰色）\" src=\"http://img10.360buyimg.com/n4/g10/M00/1C/02/rBEQWFNaM-gIAAAAAAHEkmKa3kMAAFgCAPtLXoAAcSq389.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015650.html\">海尔（Haier） XQG70-1000J 7公斤 1000转滚筒洗衣机（银灰色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015650\">￥1999.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore2\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015658.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG70-B1286 电商 7公斤 1200转变频滚筒洗衣机（银灰色）\" src=\"http://img13.360buyimg.com/n4/g14/M01/02/00/rBEhVVNmEGsIAAAAAAIJBBbz8GoAAM-EADL6qcAAgkc040.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015658.html\">海尔（Haier） XQG70-B1286 电商 7公斤 1200转变频滚筒洗衣机（银灰色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015658\">￥3499.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore3\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1069497.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG60-BS1086AM 6公斤 变频滚筒洗衣机\" src=\"http://img12.360buyimg.com/n4/g13/M0A/01/0A/rBEhU1NoeGcIAAAAAAMZpOXaofEAAM-KQKSb-8AAxm8158.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1069497.html\">海尔（Haier） XQG60-BS1086AM 6公斤 变频滚筒洗衣机</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1069497\">￥3099.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore4\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/876668.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-N12435D 6公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img13.360buyimg.com/n4/g13/M03/09/0C/rBEhVFNdyPIIAAAAAAGCGiBpM18AAMjCACQRzoAAYIy355.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/876668.html\">LG WD-N12435D 6公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-876668\">￥2099.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore5\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698301.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img11.360buyimg.com/n4/g10/M00/1C/02/rBEQWFNaOG0IAAAAAAGmsN2QEMYAAFgIgI0FTwAAabI647.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698301.html\">LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-698301\">￥2899.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore6\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698303.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-N12430D 6公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img13.360buyimg.com/n4/g15/M03/1B/17/rBEhWFNnJPUIAAAAAAKH8aVIEMkAAM4PgBCB6UAAogJ874.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698303.html\">LG WD-N12430D 6公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-698303\">￥2349.00</strong>\r\n						</div>\r\n					</li>\r\n				</ul>\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"ranklist\" class=\"m m2\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n			<h2 style=\"font-size:14px;font-weight:400;\">\r\n				洗衣机排行榜\r\n			</h2>\r\n		</div>\r\n		<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n			<ul class=\"tab\">\r\n				<li class=\"curr\" style=\"text-align:center;color:#E4393C;background-color:#FFFFFF;font-weight:700;\">\r\n					同价位\r\n				</li>\r\n				<li style=\"text-align:center;color:#333333;background-color:#F7F7F7;\">\r\n					同品牌\r\n				</li>\r\n				<li style=\"text-align:center;color:#333333;background-color:#F7F7F7;\">\r\n					同类别\r\n				</li>\r\n			</ul>\r\n			<ul class=\"tabcon\">\r\n				<li class=\"fore1\">\r\n					1\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/609522.html\"><img height=\"50\" width=\"50\" src=\"http://img12.360buyimg.com/n5/g10/M00/1C/02/rBEQWFNaOCQIAAAAAAG9_mtdNmoAAFgHwJBRCcAAb4W939.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/609522.html\">三星(SAMSUNG) WF1702NCW/XSC 7公斤 滚筒洗衣机（白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-609522\">￥2299.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore2\">\r\n					2\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/698301.html\"><img height=\"50\" width=\"50\" src=\"http://img11.360buyimg.com/n5/g10/M00/1C/02/rBEQWFNaOG0IAAAAAAGmsN2QEMYAAFgIgI0FTwAAabI647.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/698301.html\">LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-698301\">￥2899.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore3\">\r\n					3\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/816528.html\"><img height=\"50\" width=\"50\" src=\"http://img13.360buyimg.com/n5/g12/M00/0B/1D/rBEQYVNZ6nUIAAAAAAHTERq_3BcAAFJzgGOpJQAAdMp856.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/816528.html\">西门子（SIEMENS） XQG60-WS10K1C00W 6公斤 3D正负洗系列 滚筒洗衣机（白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-816528\">￥3599.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore4\">\r\n					4\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/782194.html\"><img height=\"50\" width=\"50\" src=\"http://img14.360buyimg.com/n5/g13/M09/08/14/rBEhUlNY2_gIAAAAAAGJkqlbYpYAAMZTQBh29MAAYmq090.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/782194.html\">松下(panasonic) XQG52-M75201 5.2公斤 斜式滚筒洗衣机（白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-782194\">￥2099.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore5\">\r\n					5\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/895588.html\"><img height=\"50\" width=\"50\" src=\"http://img13.360buyimg.com/n5/g13/M06/08/14/rBEhVFNY380IAAAAAAGjGtfbB14AAMZeQHKBr0AAaMy314.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/895588.html\">西门子（SIEMENS） XQG70-WM12E2680W 7公斤 滚筒洗衣机（银色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-895588\">￥4199.00</strong>\r\n					</div>\r\n				</li>\r\n				<li class=\"fore6\">\r\n					6\r\n					<div class=\"p-img\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/997834.html\"><img height=\"50\" width=\"50\" src=\"http://img14.360buyimg.com/n5/g10/M00/1C/02/rBEQWFNaP50IAAAAAAGMSIVDV84AAFgPgGfg2gAAYxg172.jpg\" class=\"err-product\" /></a>\r\n					</div>\r\n					<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n						<a href=\"http://item.jd.com/997834.html\">西门子（SIEMENS） WM08E2C00W 7公斤滚筒洗衣机 （白色）</a>\r\n					</div>\r\n					<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;\">\r\n						<strong class=\"J-p-997834\">￥3599.00</strong>\r\n					</div>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		<div id=\"buy-buy\" class=\"m m2 related-buy\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n			<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n				<h2 style=\"font-size:14px;font-weight:400;\">\r\n					购买了该商品的用户还购买了\r\n				</h2>\r\n			</div>\r\n			<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n				<ul>\r\n					<li class=\"fore1\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/850692.html\"><img height=\"100\" width=\"100\" alt=\"嘉沛（JIAPEI） WA-305Pro 冰箱洗衣机架/固定底座 (高低可调)\" src=\"http://img12.360buyimg.com/n4/g10/M00/1C/1C/rBEQWFNdu0QIAAAAAAG19nxYnoUAAFqVwKTfaQAAbYO358.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/850692.html\">嘉沛（JIAPEI） WA-305Pro 冰箱洗衣机架/固定底座 (高低可调)</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-850692\">￥128.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore2\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015324.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） KFR-35GW/05GDC23A 1.5匹壁挂式冷暖变频空调\" src=\"http://img14.360buyimg.com/n4/g13/M09/08/15/rBEhVFNY7WAIAAAAAADTuTnnj5kAAMZ9ACc62YAANPR744.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015324.html\">海尔（Haier） KFR-35GW/05GDC23A 1.5匹壁挂式冷暖变频空调</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015324\">￥2799.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore3\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015707.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier）EC6002-D 60升遥控电热水器\" src=\"http://img12.360buyimg.com/n4/g14/M02/02/08/rBEhVVNnWFAIAAAAAAFn30R0R_oAANBRQLB4PcAAWf3690.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015707.html\">海尔（Haier）EC6002-D 60升遥控电热水器</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015707\">￥1498.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore4\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/821655.html\"><img height=\"100\" width=\"100\" alt=\"乐歌(Loctek) PSW842M(26-52寸)旋转拉伸电视功能挂架/支架\" src=\"http://img10.360buyimg.com/n4/g14/M06/1F/18/rBEhVVNaNtUIAAAAAAHc3a1K0ckAAMh3gF_7QUAAdz1420.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/821655.html\">乐歌(Loctek) PSW842M(26-52寸)旋转拉伸电视功能挂架/支架</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-821655\">￥199.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore5\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/717250.html\"><img height=\"100\" width=\"100\" alt=\"美的 (Midea) 电子制冷 饮水机 MYD927S-W\" src=\"http://img10.360buyimg.com/n4/g16/M00/01/1A/rBEbRVNrWg4IAAAAAAEpgMSM8dwAAAWzwGJ1M0AASmY137.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/717250.html\">美的 (Midea) 电子制冷 饮水机 MYD927S-W</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-717250\">￥379.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore6\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/874319.html\"><img height=\"100\" width=\"100\" alt=\"美的（Midea） EM7KCGW3-NR 平板微波炉\" src=\"http://img14.360buyimg.com/n4/g17/M00/00/13/rBEbSFNqFvMIAAAAAAIGkTsnd6EAAAHkQK-QzIAAgap910.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/874319.html\">美的（Midea） EM7KCGW3-NR 平板微波炉</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-874319\">￥438.00</strong>\r\n						</div>\r\n					</li>\r\n				</ul>\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div style=\"margin:0px;padding:0px;\">\r\n		<div id=\"browse-browse\" class=\"m m2 related-buy\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n			<div class=\"mt\" style=\"margin:0px;padding:0px;background-color:#F7F7F7;font-size:14px;font-family:\'microsoft yahei\';border:1px solid #DDDDDD;\">\r\n				<h2 style=\"font-size:14px;font-weight:400;\">\r\n					浏览了该商品的用户还浏览了\r\n				</h2>\r\n			</div>\r\n			<div class=\"mc\" style=\"margin:0px;padding:0px;\">\r\n				<ul>\r\n					<li class=\"fore1\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015662.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG60-B1226AW 6公斤 1200转 水晶系列变频滚筒洗衣机（瓷白色）\" src=\"http://img12.360buyimg.com/n4/g12/M00/0F/03/rBEQYVNmELkIAAAAAAHyQFVoRY4AAFerwHSFi4AAfJY645.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015662.html\">海尔（Haier） XQG60-B1226AW 6公斤 1200转 水晶系列变频滚筒洗衣机（瓷白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015662\">￥3899.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore2\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1069497.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG60-BS1086AM 6公斤 变频滚筒洗衣机\" src=\"http://img12.360buyimg.com/n4/g13/M0A/01/0A/rBEhU1NoeGcIAAAAAAMZpOXaofEAAM-KQKSb-8AAxm8158.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1069497.html\">海尔（Haier） XQG60-BS1086AM 6公斤 变频滚筒洗衣机</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1069497\">￥3099.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore3\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015650.html\"><img height=\"100\" width=\"100\" alt=\"海尔（Haier） XQG70-1000J 7公斤 1000转滚筒洗衣机（银灰色）\" src=\"http://img10.360buyimg.com/n4/g10/M00/1C/02/rBEQWFNaM-gIAAAAAAHEkmKa3kMAAFgCAPtLXoAAcSq389.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/1015650.html\">海尔（Haier） XQG70-1000J 7公斤 1000转滚筒洗衣机（银灰色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-1015650\">￥1999.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore4\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698301.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img11.360buyimg.com/n4/g10/M00/1C/02/rBEQWFNaOG0IAAAAAAGmsN2QEMYAAFgIgI0FTwAAabI647.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/698301.html\">LG WD-T12410D 8公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-698301\">￥2899.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore5\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/895588.html\"><img height=\"100\" width=\"100\" alt=\"西门子（SIEMENS） XQG70-WM12E2680W 7公斤 滚筒洗衣机（银色）\" src=\"http://img13.360buyimg.com/n4/g13/M06/08/14/rBEhVFNY380IAAAAAAGjGtfbB14AAMZeQHKBr0AAaMy314.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/895588.html\">西门子（SIEMENS） XQG70-WM12E2680W 7公斤 滚筒洗衣机（银色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-895588\">￥4199.00</strong>\r\n						</div>\r\n					</li>\r\n					<li class=\"fore6\">\r\n						<div class=\"p-img\" style=\"margin:0px;padding:5px 0px;text-align:center;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/876668.html\"><img height=\"100\" width=\"100\" alt=\"LG WD-N12435D 6公斤 静音系列滚筒洗衣机（白色）\" src=\"http://img13.360buyimg.com/n4/g13/M03/09/0C/rBEhVFNdyPIIAAAAAAGCGiBpM18AAMjCACQRzoAAYIy355.jpg\" class=\"loading-style2\" /></a>\r\n						</div>\r\n						<div class=\"p-name\" style=\"margin:0px;padding:0px;\">\r\n							<a target=\"_blank\" href=\"http://item.jd.com/876668.html\">LG WD-N12435D 6公斤 静音系列滚筒洗衣机（白色）</a>\r\n						</div>\r\n						<div class=\"p-price\" style=\"margin:0px;padding:0px;color:#999999;text-align:center;\">\r\n							<strong class=\"J-p-876668\">￥2099.00</strong>\r\n						</div>\r\n					</li>\r\n				</ul>\r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div id=\"miaozhen7886\" class=\"m\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<a href=\"http://c.fa.jd.com/adclick?sid=2&amp;cid=163&amp;aid=817&amp;bid=3147&amp;unit=29866&amp;advid=95489&amp;guv=&amp;url=http://e.cn.miaozhen.com/r.gif?k=1012922&amp;p=4+jSA0&amp;rt=2&amp;ns=[M_ADIP]&amp;ni=[M_IESID]&amp;na=[M_MAC]&amp;o=http://sale.jd.com/act/P2oMfuidjRr10wsE.html\" target=\"_blank\"><img width=\"211\" height=\"261\" src=\"http://img11.360buyimg.com/da/jfs/t157/216/441872528/18241/5d272345/538d51fdN29a86e05.jpg\" class=\"loading-style2\" /></a>\r\n	</div>\r\n	<div id=\"miaozhen10767\" class=\"m\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<a href=\"http://c.fa.jd.com/adclick?sid=2&amp;cid=163&amp;aid=818&amp;bid=2947&amp;unit=28576&amp;advid=96247&amp;guv=&amp;url=http://jmall.jd.com/shop/p129940/index.html?erpad_source=erpad\" target=\"_blank\"><img width=\"211\" height=\"261\" alt=\"\" src=\"http://img13.360buyimg.com/da/jfs/t205/61/637500449/23385/6d479db/539524e1Nc8892389.jpg\" class=\"loading-style2\" /></a>\r\n	</div>\r\n	<div id=\"ad_market_1\" class=\"m\" style=\"margin:0px 0px 10px;padding:0px;\">\r\n		<div style=\"margin:0px;padding:0px;\">\r\n			<img id=\"tracker_banner45b34482-ae79-4feb-95c7-28eb79cc2d9b\" width=\"0\" height=\"0\" border=\"0\" src=\"http://x.jd.com/dsp/np?log=VLikGDCsgoBvQrY6FOANYuekrtHPkiO8++O4zBTXUEXMZir0ZwsFPbpSIz0SM3d8IPL9jxA26rE3R+n6klF3wecKlWrR/83eE18PR4AnluGhBvahZAWn6TQRj1Jp0Jyy353Xe1m/GPXrHBo2rddQ5i/7y8ywXRy6evvzcVdpd7ziUdd3I7WuE/NWW9CuQHcndzomCTWla9CyhnP0U78lI1lWEme8MLkVo+Wgz1bxolpvrjz+VWP32fd6/kSDCt6m0/BW6Fn+RAD4ED55xE2ICg==&amp;v=2\" />\r\n			<div id=\"jd_banner45b34482-ae79-4feb-95c7-28eb79cc2d9b\" style=\"margin:0px;padding:0px;color:#666666;font-family:Arial, Verdana, 宋体;background-color:#FFFFFF;\">\r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>', '1402410923', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('20', '商品名称1', '', '10000', '100.00', '0.00', null, '2016', '1', '0', '73');
INSERT INTO `tour_product` VALUES ('22', '商品名称1rewrwe', '21312321321', '10000', '100.00', '0.00', null, '2016', '1', '0', '62');
INSERT INTO `tour_product` VALUES ('24', '在模板中输出变量的方法很简单，例如，在控制器中我们给模板变量赋值', '213213', '10000', '100.00', '35.00', null, '2016', '1', '0', '74');
INSERT INTO `tour_product` VALUES ('26', '2014夏装新款韩版修身女装欧根纱短袖连衣裙', 'L00734', '1', '99.80', '57.00', '', '0', '1', '0', '0');
INSERT INTO `tour_product` VALUES ('32', '淑女圆领雪纺衫女短裙套装套裤两件套', '123', '10000', '100.00', '0.00', '', '0', '1', '0', '0');
INSERT INTO `tour_product` VALUES ('53', '商品名称4343', '4324234', '10000', '100.00', '79.00', '', '0', '1', '0', '7');
INSERT INTO `tour_product` VALUES ('54', '商品名称1PHP获取目录和的方法通过魔术变量', '321313', '10000', '100.00', '81.00', '', '0', '1', '0', '23');
INSERT INTO `tour_product` VALUES ('55', '商品名称1312321312', '', '10000', '100.00', '82.00', '', '0', '1', '0', '4');
INSERT INTO `tour_product` VALUES ('56', '商品名称1231232', '321312321', '10000', '100.00', '83.00', '', '0', '1', '0', '1');
INSERT INTO `tour_product` VALUES ('59', '商品名称1PHP获取目录和的方法通过魔术变量11', '123123', '10000', '100.00', '84.00', '', '2016', '1', '0', '2');
INSERT INTO `tour_product` VALUES ('60', '商品名称34', '21312313123', '10000', '100.00', '85.00', '', '2016', '1', '0', '2');
INSERT INTO `tour_product` VALUES ('61', '商品名称1213213213', '', '10000', '100.00', '86.00', '', '2016', '1', '0', '23');

-- ----------------------------
-- Table structure for `tour_publish_table`
-- ----------------------------
DROP TABLE IF EXISTS `tour_publish_table`;
CREATE TABLE `tour_publish_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `software_name` varchar(128) DEFAULT NULL COMMENT '软件名',
  `software_zh` varchar(128) DEFAULT NULL,
  `version_num` varchar(32) DEFAULT NULL COMMENT '版本号',
  `size` varchar(128) DEFAULT NULL COMMENT '文件大小',
  `upload_name` varchar(128) DEFAULT NULL COMMENT '上传文件本身名称',
  `url` varchar(128) DEFAULT NULL COMMENT 'url',
  `publish_time` varchar(128) DEFAULT NULL COMMENT '发布日期',
  `description` text COMMENT '说明',
  `belongs_stage` varchar(128) DEFAULT NULL COMMENT '平台',
  `sha1` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_publish_table
-- ----------------------------
INSERT INTO `tour_publish_table` VALUES ('165', 'app', '谷歌APP', '1.0', '628.17KB', null, '/version/uploads/app/app_v1.0.rar', '1455612577', '谷歌APP谷歌APP谷歌APP谷歌APP', 'Linux', '82bfceaf1a11df53db6b8486a8024e3cce05e84f');
INSERT INTO `tour_publish_table` VALUES ('166', 'app', '谷歌APP', '2.0', '628.17KB', null, '/version/uploads/app/app_v2.0.rar', '1455612607', '谷歌APP', 'Linux', '82bfceaf1a11df53db6b8486a8024e3cce05e84f');
INSERT INTO `tour_publish_table` VALUES ('167', 'RtmpDevice', 'RtmpDevice', '0.1', '1.45MB', null, '/version/uploads/RtmpDevice/RtmpDevice_v0.1.zip', '1455619658', 'rtmpdevcie的设备端程序', 'Windows', 'ef38d072560ab663b803001362a4bd31c1c92457');
INSERT INTO `tour_publish_table` VALUES ('168', 'APP', '谷歌APP222', '3.0', '37.91MB', null, '/version/uploads/APP/APP_v3.0.zip', '1455635702', '谷歌APP', 'Windows', 'c4ba0b3eb7abd4b60a3d3dfb657e1aa107d027f7');
INSERT INTO `tour_publish_table` VALUES ('169', 'amai', 'amai', '1.0.0.1', '628.17KB', null, '/version/uploads/amai/amai_v1.0.0.1.rar', '1455669351', 'amaiamaiamaiamaiamaiamai', 'Android', '82bfceaf1a11df53db6b8486a8024e3cce05e84f');
INSERT INTO `tour_publish_table` VALUES ('170', 'RtmpDevice', 'RtmpDevice', '1.0', '628.17KB', null, '/version/uploads/RtmpDevice/RtmpDevice_v1.0.rar', '1455755720', '	RtmpDevice	RtmpDevice	RtmpDevice', 'Linux', '82bfceaf1a11df53db6b8486a8024e3cce05e84f');
INSERT INTO `tour_publish_table` VALUES ('171', 'ecshop', 'html模板', '1.1.3', '21.74MB', null, '/version/uploads/ecshop/ecshop_v1.1.3.rar', '1455764304', '这是一个织梦的html模板', 'Windows', '7caec566248537cdecc1772160a3ca6a14c44aa7');
INSERT INTO `tour_publish_table` VALUES ('172', 'wampserver', 'wampserver', '1.0', '37.91MB', null, '/version/uploads/wampserver/wampserver_v1.0.zip', '1455801067', 'wampserverwampserver', 'Windows', 'c4ba0b3eb7abd4b60a3d3dfb657e1aa107d027f7');
INSERT INTO `tour_publish_table` VALUES ('173', 'BaiduApp', '微信', '1.0', '1.45MB', null, '/version/uploads/BaiduApp/BaiduApp_v1.0.zip', '1459135221', '微信微信微信微信微信微信微信微信', 'Windows', 'ef38d072560ab663b803001362a4bd31c1c92457');
INSERT INTO `tour_publish_table` VALUES ('174', 'BaiduApp', '谷歌APP', '1.0', '45.65MB', null, '/version/uploads/BaiduApp/BaiduApp_v1.0.zip', '1459135304', '谷歌APP谷歌APP谷歌APP谷歌APP谷歌APP谷歌APP', 'Linux', 'dc7d012044e7b0992d3a66ab780d82d92b8d3e2f');
INSERT INTO `tour_publish_table` VALUES ('175', 'testdata', '微信111', '1.0', '45.65MB', null, '/version/uploads/testdata/testdata_v1.0.zip', '1459136039', '的撒打算', 'Linux', 'dc7d012044e7b0992d3a66ab780d82d92b8d3e2f');
INSERT INTO `tour_publish_table` VALUES ('176', 'Tinywan', '万少波', '1.0.213.31', '45.65MB', null, '/version/uploads/Tinywan/Tinywan_v1.0.213.31.zip', '1459136250', 'root', 'Windows', 'dc7d012044e7b0992d3a66ab780d82d92b8d3e2f');
INSERT INTO `tour_publish_table` VALUES ('177', 'BaiduApp', '谷歌APP', '2.0', '64.12KB', null, '/version/uploads/BaiduApp/BaiduApp_v2.0.rar', '1459995785', 'ewqewq', 'Mac', '5a29cb7949cde0d7a35db8bc543b3b9f648b6c1a');
INSERT INTO `tour_publish_table` VALUES ('178', '文件测试1', '文件测试1', '1.0', '1281107', null, '/ThinkPhpStudy/Uploads/文件测试1/文件测试1_v1.0.zip', '1471225191', '文件测试1文件测试1文件测试1文件测试1', 'Mac', '46be8fda616d1cf67ac45f07f3a10215c38b9e8d');
INSERT INTO `tour_publish_table` VALUES ('179', '文件中文', '文件中文', '1', '5681943', null, '/ThinkPhpStudy/Uploads/', '1471225325', '文件中文文件中文文件中文', 'Windows', '8b4db01f8561cdd3e58c98ff1dcc91f20f742fb2');
INSERT INTO `tour_publish_table` VALUES ('180', 'Linux测试', 'Linux测试', '10.0', '5681943', null, '/ThinkPhpStudy/Uploads/Linux', '1471225449', 'Linux测试Linux测试Linux测试', 'Android', '8b4db01f8561cdd3e58c98ff1dcc91f20f742fb2');
INSERT INTO `tour_publish_table` VALUES ('181', '', '', '', '100', null, '/ThinkPhpStudy/Uploads/_v.rar', '1471226273', '', '', '11fce6a6ab4161b27dc2d1c16982fce9dc899f01');
INSERT INTO `tour_publish_table` VALUES ('182', 'BaiduApp', '图片测试怕', '1.0', '143028', 'BaiduApp/mini_BaiduApp_v1.0.jpg', '/ThinkPhpStudy/Uploads/BaiduApp/BaiduApp_v1.0.jpg', '1471239088', '', 'Linux', 'ba4da58d455eae781326a50b9357897948917eeb');
INSERT INTO `tour_publish_table` VALUES ('183', 'BaiduApp', '图片测试怕', '1.0', '174909', 'BaiduApp/mini_BaiduApp_v1.0.jpg', '/ThinkPhpStudy/Uploads/BaiduApp/BaiduApp_v1.0.jpg', '1471241272', '324234', 'Linux', '4366fb597870ffa64bb5a6cec4a3c7a9931bf420');
INSERT INTO `tour_publish_table` VALUES ('184', 'BaiduApp', '图片测试怕', '1.0', '334216', 'BaiduApp/mini_BaiduApp_v1.0.jpg', '/ThinkPhpStudy/Uploads/BaiduApp/BaiduApp_v1.0.jpg', '1471241306', '324234', 'Windows', '61e6790683338390a22d9ec05b9623c457777e96');
INSERT INTO `tour_publish_table` VALUES ('185', 'BaiduApp', '图片测试怕', '1.1', '174909', 'BaiduApp/mini_BaiduApp_v1.1.jpg', '/ThinkPhpStudy/Uploads/BaiduApp/BaiduApp_v1.1.jpg', '1471241354', '', 'Windows', '4366fb597870ffa64bb5a6cec4a3c7a9931bf420');

-- ----------------------------
-- Table structure for `tour_role`
-- ----------------------------
DROP TABLE IF EXISTS `tour_role`;
CREATE TABLE `tour_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `pid` smallint(6) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT '1',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_role
-- ----------------------------
INSERT INTO `tour_role` VALUES ('1', '超级管理员', null, '1', '超级管理员超级管理员');
INSERT INTO `tour_role` VALUES ('2', '管理员', null, '1', '管理员描述');
INSERT INTO `tour_role` VALUES ('3', '会员', null, '1', '描述');
INSERT INTO `tour_role` VALUES ('17', '体育分类', '0', '1', '旅游资源统计');

-- ----------------------------
-- Table structure for `tour_role_user`
-- ----------------------------
DROP TABLE IF EXISTS `tour_role_user`;
CREATE TABLE `tour_role_user` (
  `role_id` mediumint(9) unsigned DEFAULT NULL,
  `user_id` char(32) DEFAULT NULL,
  KEY `group_id` (`role_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_role_user
-- ----------------------------
INSERT INTO `tour_role_user` VALUES ('3', '72');
INSERT INTO `tour_role_user` VALUES ('12', '73');
INSERT INTO `tour_role_user` VALUES ('13', '74');
INSERT INTO `tour_role_user` VALUES ('2', '107');
INSERT INTO `tour_role_user` VALUES ('1', '86');
INSERT INTO `tour_role_user` VALUES ('3', '69');
INSERT INTO `tour_role_user` VALUES ('3', '70');
INSERT INTO `tour_role_user` VALUES ('2', '71');
INSERT INTO `tour_role_user` VALUES ('2', '87');
INSERT INTO `tour_role_user` VALUES ('3', '88');
INSERT INTO `tour_role_user` VALUES ('2', '108');
INSERT INTO `tour_role_user` VALUES ('3', '109');
INSERT INTO `tour_role_user` VALUES ('2', '110');
INSERT INTO `tour_role_user` VALUES ('2', '111');
INSERT INTO `tour_role_user` VALUES ('1', '112');
INSERT INTO `tour_role_user` VALUES ('2', '113');
INSERT INTO `tour_role_user` VALUES ('1', '114');
INSERT INTO `tour_role_user` VALUES ('1', '115');
INSERT INTO `tour_role_user` VALUES ('1', '116');
INSERT INTO `tour_role_user` VALUES ('1', '117');
INSERT INTO `tour_role_user` VALUES ('3', '141');
INSERT INTO `tour_role_user` VALUES ('1', '119');
INSERT INTO `tour_role_user` VALUES ('1', '121');
INSERT INTO `tour_role_user` VALUES ('1', '122');
INSERT INTO `tour_role_user` VALUES ('1', '123');
INSERT INTO `tour_role_user` VALUES ('1', '124');
INSERT INTO `tour_role_user` VALUES ('1', '125');
INSERT INTO `tour_role_user` VALUES ('1', '126');
INSERT INTO `tour_role_user` VALUES ('1', '127');
INSERT INTO `tour_role_user` VALUES ('1', '128');
INSERT INTO `tour_role_user` VALUES ('1', '129');
INSERT INTO `tour_role_user` VALUES ('1', '130');
INSERT INTO `tour_role_user` VALUES ('1', '131');
INSERT INTO `tour_role_user` VALUES ('1', '134');
INSERT INTO `tour_role_user` VALUES ('1', '135');
INSERT INTO `tour_role_user` VALUES ('17', '136');
INSERT INTO `tour_role_user` VALUES ('17', '139');
INSERT INTO `tour_role_user` VALUES ('1', '140');

-- ----------------------------
-- Table structure for `tour_user`
-- ----------------------------
DROP TABLE IF EXISTS `tour_user`;
CREATE TABLE `tour_user` (
  `user_id` int(100) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `logintime` varchar(128) DEFAULT NULL,
  `loginip` text,
  `status` int(2) DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tour_user
-- ----------------------------
INSERT INTO `tour_user` VALUES ('86', 'admin', '4297f44b13955235245b2497399d7a93', '1470895205', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('87', '管理员测试', '4297f44b13955235245b2497399d7a93', '1456294831', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('88', '会员测试', '4297f44b13955235245b2497399d7a93', '1456294603', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('107', 'admin123', '4297f44b13955235245b2497399d7a93', '1456295345', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('108', 'admin123312', '45a5381e5a89cc97afdba368553b3243', '1456303613', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('109', '一部测试', '4297f44b13955235245b2497399d7a93', '1456303671', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('115', '惹我热吻', '8f5f90130c5393affe3b6037c319d1bb', '1456304010', '127.0.0.1', '0');
INSERT INTO `tour_user` VALUES ('116', 'admindsdsa', '5d87c48737641ddd59b231d4d933d954', '1456304128', '127.0.0.1', '0');
INSERT INTO `tour_user` VALUES ('117', '惹我热吻', '8f5f90130c5393affe3b6037c319d1bb', '1456304234', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('119', '惹我热吻', '8f5f90130c5393affe3b6037c319d1bb', '1456304235', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('121', 'admindsdsa', '5d87c48737641ddd59b231d4d933d954', '1456304266', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('122', 'adminrewrew', '16affafe81e0b9185ebd199ab19f1868', '1456304386', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('123', 'adminrewrew', '16affafe81e0b9185ebd199ab19f1868', '1456304390', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('124', 'ewqewq', 'bff9a869137805d4f02640e9aa141881', '1456304396', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('125', 'ewqewq', 'bff9a869137805d4f02640e9aa141881', '1456304523', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('126', 'adminrewrewr', '4237eb259879f58e49d40e49746dbc13', '1456304528', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('127', 'adminrewrwe', '213c6ecc5b2cdbf3feb3b415ed445caf', '1456304533', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('128', 'admintretre', 'b5439ba5576cbd395edd8e1d7bd57028', '1456304624', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('129', 'adminrewr', '3964fd31837a486a455e4cec286a04e3', '1456304636', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('130', 'adminrewrewrewrew', '3964fd31837a486a455e4cec286a04e3', '1456304647', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('131', 'adminrewrewrewrew', '3964fd31837a486a455e4cec286a04e3', '1456304664', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('134', '惹我热吻惹我', '3d186804534370c3c817db0563f0e461', '1456304679', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('135', '321321', 'bb2d91d0fbbebe8719509ed0f865c63f', '1456304686', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('136', 'adminewrew', '6f106aee6475d00a193095639575632b', '1457661341', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('139', 'admin321321', '139e1603741c4ffb4a88a7776d79ab6f', '1457661427', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('140', 'tretretre', '27648ca605dfab27b2955eef714ef573', '1457661531', '127.0.0.1', '1');
INSERT INTO `tour_user` VALUES ('141', 'controlIndex', 'd1034c027fbf9a4d745e4490097250a1', '1461912267', '127.0.0.1', '1');

-- ----------------------------
-- Table structure for `version_app`
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

-- ----------------------------
-- Table structure for `version_download_log`
-- ----------------------------
DROP TABLE IF EXISTS `version_download_log`;
CREATE TABLE `version_download_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` varchar(128) DEFAULT NULL COMMENT '下载软件版本id',
  `download_time` varchar(128) DEFAULT '' COMMENT '下载日期',
  `download_user` varchar(128) DEFAULT NULL COMMENT '下载用户信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of version_download_log
-- ----------------------------
INSERT INTO `version_download_log` VALUES ('93', '132', '1454487384', 'admin');
INSERT INTO `version_download_log` VALUES ('94', '159', '1454487399', 'admin');
INSERT INTO `version_download_log` VALUES ('95', '158', '1454487405', 'admin');
INSERT INTO `version_download_log` VALUES ('96', '158', '1454487407', 'admin');
INSERT INTO `version_download_log` VALUES ('97', '159', '1454487418', 'admin');
INSERT INTO `version_download_log` VALUES ('98', '159', '1454487423', 'admin');
INSERT INTO `version_download_log` VALUES ('99', '133', '1454487437', 'admin');
INSERT INTO `version_download_log` VALUES ('100', '133', '1454487439', 'admin');
INSERT INTO `version_download_log` VALUES ('101', '162', '1454496799', 'admin');
INSERT INTO `version_download_log` VALUES ('102', '163', '1454640229', 'admin');
INSERT INTO `version_download_log` VALUES ('103', '163', '1454642761', 'admin');
INSERT INTO `version_download_log` VALUES ('104', '164', '1454644598', 'user1200072538');
INSERT INTO `version_download_log` VALUES ('105', '164', '1454644613', 'user755568298');
INSERT INTO `version_download_log` VALUES ('106', '164', '1454644708', 'user1858833927');
INSERT INTO `version_download_log` VALUES ('107', '164', '1454738294', 'user592321558');
INSERT INTO `version_download_log` VALUES ('108', '165', '1455670464', 'user1110789341');
INSERT INTO `version_download_log` VALUES ('109', '165', '1455670573', 'user1837239479');
INSERT INTO `version_download_log` VALUES ('110', '168', '1455670585', 'user426199601');
INSERT INTO `version_download_log` VALUES ('111', '166', '1455670464', 'user717908596');
INSERT INTO `version_download_log` VALUES ('112', '166', '1455670465', 'user2024775267');
INSERT INTO `version_download_log` VALUES ('113', '168', '1455670476', 'user2055896985');
INSERT INTO `version_download_log` VALUES ('114', '168', '1455670478', 'user2122848486');
INSERT INTO `version_download_log` VALUES ('115', '168', '1455670737', 'user1071652155');
INSERT INTO `version_download_log` VALUES ('116', '165', '1455670816', 'user951377336');
INSERT INTO `version_download_log` VALUES ('117', '166', '1455670820', 'user415600393');
INSERT INTO `version_download_log` VALUES ('118', '169', '1455671391', 'user1745188741');
INSERT INTO `version_download_log` VALUES ('119', '165', '1455671750', 'user1518351094');
INSERT INTO `version_download_log` VALUES ('120', '165', '1455671744', 'user1958195151');
INSERT INTO `version_download_log` VALUES ('121', '165', '1455671747', 'user1606596268');
INSERT INTO `version_download_log` VALUES ('122', '168', '1455671751', 'user1720374265');
INSERT INTO `version_download_log` VALUES ('123', '168', '1455671755', 'user461446448');
INSERT INTO `version_download_log` VALUES ('124', '165', '1455697965', 'user1947440067');
INSERT INTO `version_download_log` VALUES ('125', '165', '1455698001', 'user1171116215');
INSERT INTO `version_download_log` VALUES ('126', '166', '1455698019', 'user450242553');
INSERT INTO `version_download_log` VALUES ('127', '165', '1455761153', 'user1545851807');
INSERT INTO `version_download_log` VALUES ('128', '167', '1455761225', 'user221851742');
INSERT INTO `version_download_log` VALUES ('129', '167', '1455761243', 'user1289683355');
INSERT INTO `version_download_log` VALUES ('130', '167', '1455761287', 'user2136669335');
INSERT INTO `version_download_log` VALUES ('131', '167', '1455761434', 'user398394109');
INSERT INTO `version_download_log` VALUES ('132', '167', '1455761661', 'user603613586');
INSERT INTO `version_download_log` VALUES ('133', '167', '1455761721', 'user1563531399');
INSERT INTO `version_download_log` VALUES ('134', '167', '1455761725', 'user2122841476');
INSERT INTO `version_download_log` VALUES ('135', '167', '1455761725', 'user1696801531');
INSERT INTO `version_download_log` VALUES ('136', '167', '1455761725', 'user1757189895');
INSERT INTO `version_download_log` VALUES ('137', '167', '1455761889', 'user550296180');
INSERT INTO `version_download_log` VALUES ('138', '167', '1455761935', 'user150455235');
INSERT INTO `version_download_log` VALUES ('139', '167', '1455761938', 'user856541538');
INSERT INTO `version_download_log` VALUES ('140', '167', '1455762220', 'user1333891246');
INSERT INTO `version_download_log` VALUES ('141', '167', '1455762286', 'user94074261');
INSERT INTO `version_download_log` VALUES ('142', '167', '1455762297', 'user788776223');
INSERT INTO `version_download_log` VALUES ('143', '170', '1455764095', 'admin');
INSERT INTO `version_download_log` VALUES ('144', '165', '1455764199', 'user1361861576');
INSERT INTO `version_download_log` VALUES ('145', '171', '1455764315', 'admin');
INSERT INTO `version_download_log` VALUES ('146', '166', '1455766409', 'admin');
INSERT INTO `version_download_log` VALUES ('147', '165', '1456196064', 'user1889326958');
INSERT INTO `version_download_log` VALUES ('148', '167', '1456196084', 'user1287969732');
INSERT INTO `version_download_log` VALUES ('149', '167', '1456196085', 'user1159499651');
INSERT INTO `version_download_log` VALUES ('150', '165', '1456196086', 'user1607977761');
INSERT INTO `version_download_log` VALUES ('151', '165', '1456196086', 'user1975687422');
INSERT INTO `version_download_log` VALUES ('152', '165', '1456196087', 'user1285117619');
INSERT INTO `version_download_log` VALUES ('153', '165', '1456196127', 'user599498904');
INSERT INTO `version_download_log` VALUES ('154', '165', '1456196797', 'user1971504745');
INSERT INTO `version_download_log` VALUES ('155', '165', '1456196799', 'user1066752609');
INSERT INTO `version_download_log` VALUES ('156', '167', '1456281043', 'user1634041541');
INSERT INTO `version_download_log` VALUES ('157', '167', '1457056659', 'user465125743');
INSERT INTO `version_download_log` VALUES ('158', '167', '1457056660', 'user1351145209');
INSERT INTO `version_download_log` VALUES ('159', '167', '1458018060', 'user2139198542');
INSERT INTO `version_download_log` VALUES ('160', '167', '1458018068', 'user137505229');
INSERT INTO `version_download_log` VALUES ('161', '176', '1459136272', 'admin');
