#1.database & user

use mysql;

#delete database & user
drop database if exists  office_data;
delete from user where user='office_data';
flush privileges;

#create database & user
create database  office_data default character set utf8 collate utf8_general_ci;
grant all privileges on  office_data.* to 'office_data'@'localhost' identified by 'Huawei_123' with grant option;
grant all privileges on  office_data.* to 'office_data'@'%' identified by 'Huawei_123' with grant option;

flush privileges;
use  office_data;
set global max_connections=2000;
set global group_concat_max_len=102400;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `sys_oper_log`;
create table sys_oper_log (
  oper_id 			int(11) 		not null auto_increment    comment '日志主键',
  title             varchar(50)     default ''                 comment '模块标题',
  business_type     int(2)          default 0                  comment '业务类型（0其它 1新增 2修改 3删除）',
  method            varchar(100)    default ''                 comment '方法名称',
  oper_name 	    varchar(50)     default '' 		 	 	   comment '操作人员',
  oper_url 		    varchar(255) 	default '' 				   comment '请求URL',
  oper_ip 			varchar(30) 	default '' 				   comment '主机地址',
  oper_param 		varchar(255) 	default '' 				   comment '请求参数',
  status 			int(1) 		    default 0				   comment '操作状态（0正常 1异常）',
  error_msg 		varchar(2000) 	default '' 				   comment '错误消息',
  oper_time 		datetime                                   comment '操作时间',
  primary key (oper_id)
) engine=innodb auto_increment=100 default charset=utf8 comment = '操作日志记录';

DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `identify` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=691 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `good_store`;
CREATE TABLE `good_store` (
  `good_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `good_name` varchar(64) DEFAULT NULL COMMENT '商品名称',
  `good_count` varchar(64) DEFAULT NULL COMMENT '商品数量',
  `producer` varchar(64) DEFAULT NULL COMMENT '生产厂商',
  `good_price` varchar(64) DEFAULT NULL COMMENT '商品价格',
  PRIMARY KEY (`good_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `sm_user`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user`;
CREATE TABLE `sm_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account` varchar(32) NOT NULL COMMENT '账户名称',
  `password` varchar(256) NOT NULL COMMENT '密码',
  `name` varchar(32) NOT NULL COMMENT '用户名称',
  `gender` int(11) DEFAULT NULL COMMENT '性别    0女  1男',
  `telephone` varchar(32) NOT NULL COMMENT '电话',
  `email` varchar(128) NOT NULL COMMENT '电子邮件',
  `resetpwd` int(11) DEFAULT NULL COMMENT '强制重置密码',
  `description` varchar(256) DEFAULT NULL COMMENT '备注',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建者标识',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `account_type` int(11) DEFAULT NULL COMMENT '账号类型1：普通',
  `del_flag` int(11) DEFAULT '0' COMMENT '删除标志(0为未删除，1为已删除，默认为0)',
  `is_active` int(11) DEFAULT '1' COMMENT '是否激活   0 未激活  1已激活',
  `employee_id` varchar(32) DEFAULT NULL  COMMENT '员工ID',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sm_user
-- ----------------------------
INSERT INTO `sm_user` VALUES ('1', 'admin', '94e8cde4612b3fd390677d42e7b22002', 'admin', '1', '18885245451', 'fhxin@isoftstone.com', null, null, null, null, null, '0', '1', '0043');
INSERT INTO `sm_user` VALUES ('2', 'wangshuo', 'e10adc3949ba59abbe56e057f20f883e', '王硕', '0', '15845489542', 'yyy@qq.com', null, null, null, null, null, '0', '1', '15485');
INSERT INTO `sm_user` VALUES ('3', 'dawei', 'e10adc3949ba59abbe56e057f20f883e', '大伟', '0', '18845987520', '123@qq.com', null, null, null, null, null, '0', '1', '18452');
INSERT INTO `sm_user` VALUES ('207', 'luoquan', '202cb962ac59075b964b07152d234b70', '罗权', '0', '52631484896', '123@qq.com', null, null, null, null, null, '0', '1', '996');
INSERT INTO `sm_user` VALUES ('208', 'zhendong', '202cb962ac59075b964b07152d234b70', '振东', '0', '74125896325', 'qqq@qq.com', null, null, null, null, null, '0', '1', '489');
INSERT INTO `sm_user` VALUES ('209', 'shijie', '202cb962ac59075b964b07152d234b70', '仕杰', '0', '78965412302', 'hasd@qq.com', null, null, null, null, null, '0', '1', '7854');

DROP TABLE IF EXISTS `user_income`;
CREATE TABLE `user_income` (
  `income_id`  bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `income_money` float(11,2)  DEFAULT 0 COMMENT '收入工资',
  `income_time` datetime DEFAULT NULL COMMENT '收入时间',
  PRIMARY KEY (`income_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户收入表';


insert into user_income(user_id,income_money,income_time) 
  values('12','10000','2018-07-30 14:56:10');
insert into user_income(user_id,income_money,income_time) 
  values('12','15000','2018-05-30 14:56:10');
  insert into user_income(user_id,income_money,income_time) 
  values('12','13000','2018-04-30 14:56:10');
  
DROP TABLE IF EXISTS `file_info`;
CREATE TABLE `file_info` (
  `file_id`  varchar(40) NOT NULL,
  `file_name` varchar(128) NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='文件列表';
  
-- ----------------------------
-- Table structure for `role_table`
-- ----------------------------
DROP TABLE IF EXISTS `role_table`;
CREATE TABLE `role_table` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(64) NOT NULL COMMENT '角色名称',
  `english_name` varchar(64) NOT NULL COMMENT '角色英语名称',
  `role_describe` varchar(64) NOT NULL COMMENT '角色描述',
  `creat_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `del_flag` int(11) DEFAULT '0' COMMENT '删除标志(0为未删除，1为已删除，默认为0)',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_table
-- ----------------------------
INSERT INTO `role_table` VALUES ('1', '总经理', 'Manager', '管理员', '2018-11-01 16:31:06', '2018-11-01 16:31:10', '0');
INSERT INTO `role_table` VALUES ('2', '员工', 'employee', '职员', '2018-11-09 00:00:00', '2018-11-09 00:00:00', '0');
INSERT INTO `role_table` VALUES ('3', '部门经理', 'depart-manager', '部门管理员', '2018-11-23 10:28:05', '2018-11-23 10:28:05', '0');

-- ----------------------------
-- Table structure for `sm_user_ref_role`
-- ----------------------------
DROP TABLE IF EXISTS `sm_user_ref_role`;
CREATE TABLE `sm_user_ref_role` (
  `role_id` int(20) NOT NULL COMMENT '角色id',
  `user_id` int(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_user_ref_role
-- ----------------------------
INSERT INTO `sm_user_ref_role` VALUES ('1', '2');
INSERT INTO `sm_user_ref_role` VALUES ('2', '2');
INSERT INTO `sm_user_ref_role` VALUES ('1', '3');

-- ----------------------------
-- Table structure for `sm_role_ref_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `sm_role_ref_privilege`;
CREATE TABLE `sm_role_ref_privilege` (
  `role_id` int(20) NOT NULL COMMENT '角色id',
  `menu_id` int(20) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`menu_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_role_ref_privilege
-- ----------------------------
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '1');
INSERT INTO `sm_role_ref_privilege` VALUES ('2', '1');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '2');
INSERT INTO `sm_role_ref_privilege` VALUES ('2', '2');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '6');
INSERT INTO `sm_role_ref_privilege` VALUES ('2', '6');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '11');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '12');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '13');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '15');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '16');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '17');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '18');
INSERT INTO `sm_role_ref_privilege` VALUES ('2', '22');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '25');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '26');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '27');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '28');
INSERT INTO `sm_role_ref_privilege` VALUES ('1', '29');
INSERT INTO `sm_role_ref_privilege` VALUES ('2', '31');

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_url` varchar(255) DEFAULT NULL COMMENT '菜单url',
  `menu_privilege` varchar(255) DEFAULT NULL COMMENT '菜单权限',
  `menu_type` int(10) DEFAULT NULL COMMENT '菜单类型',
  `parent_id` int(10) DEFAULT NULL COMMENT '父菜单ID',
  `menu_name` varchar(255) DEFAULT NULL COMMENT '菜单名称',
  `icon_class` varchar(255) DEFAULT NULL COMMENT '菜单图标类名',
  `sort` varchar(10) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='菜单表';
-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', null, 'system:manage', '0', '-1', '系统管理', 'ui-icon ui-\r\n\r\nui-icon ui-icon-carat-1-n', '0');
INSERT INTO `sys_menu` VALUES ('2', null, 'system:user/role', '0', '1', '用户及授权管理', 'ui-icon ui-icon-\r\n\r\nui-icon ui-icon-triangle-1-e', '2');
INSERT INTO `sys_menu` VALUES ('3', '/user/userList', 'system:user:view', '1', '2', '用户管理', 'ui-icon ui-icon-calculator', '0');
INSERT INTO `sys_menu` VALUES ('6', '/role/roleManager', 'system:role:view', '1', '2', '角色管理', 'ui-icon ui-icon-calculator', '1');
INSERT INTO `sys_menu` VALUES ('7', null, 'system:settings', '0', '1', '系统配置', 'ui-icon ui-icon-\r\n\r\nui-icon ui-icon-triangle-1-e', '0');
INSERT INTO `sys_menu` VALUES ('8', null, 'system:log', '0', '1', '日志管理', 'ui-icon ui-icon-\r\n\r\nui-icon ui-icon-triangle-1-e', '1');
INSERT INTO `sys_menu` VALUES ('9', null, 'system:security:view', '1', '7', '安全配置', 'ui-icon ui-icon-calculator', '0');
INSERT INTO `sys_menu` VALUES ('10', '/monitor/log', 'system:log:view', '1', '8', '操作日志管理', 'ui-icon ui-icon-calculator', '0');
INSERT INTO `sys_menu` VALUES ('11', null, 'system:service', '0', '-1', '业务管理', 'ui-icon ui-\r\n\r\nui-icon ui-icon-carat-1-n', '1');
INSERT INTO `sys_menu` VALUES ('12', null, 'system:plat', '0', '11', '合同管理', 'ui-icon ui-icon-\r\n\r\nui-icon ui-icon-triangle-1-e', '0');
INSERT INTO `sys_menu` VALUES ('13', null, 'system:logistics', '0', '11', '交易分析', 'ui-icon ui-icon-\r\n\r\nui-icon ui-icon-triangle-1-e', '1');
INSERT INTO `sys_menu` VALUES ('15', '/contract/contractManager', 'system:plat:electronicpalt', '1', '12', '电子合同', 'ui-icon ui-icon-calculator', '1');
INSERT INTO `sys_menu` VALUES ('16', null, 'system:plat:respository', '1', '12', '合同协议库', 'ui-icon ui-icon-calculator', '0');
INSERT INTO `sys_menu` VALUES ('17', '/report/line', 'system:business:marketdata', '1', '13', '市场数据', 'ui-icon ui-icon-calculator', '2');
INSERT INTO `sys_menu` VALUES ('18', '/report/draw', 'system:business:data', '1', '13', '交易数据', 'ui-icon ui-icon-calculator', '1');
INSERT INTO `sys_menu` VALUES ('19', null, 'system:user:add', '2', '3', '用户添加', 'ui-icon ui-icon-plus', '0');
INSERT INTO `sys_menu` VALUES ('20', null, 'system:user:delete', '2', '3', '用户删除', 'ui-icon ui-icon-minusthick', '1');
INSERT INTO `sys_menu` VALUES ('21', null, 'system:user:query', '2', '3', '用户查询', 'ui-icon ui-icon-search', '2');
INSERT INTO `sys_menu` VALUES ('22', null, 'system:role:add', '2', '6', '角色添加', 'ui-icon ui-icon-plus', '0');
INSERT INTO `sys_menu` VALUES ('23', null, 'system:role:delete', '2', '6', '角色删除', 'ui-icon ui-icon-minusthick', '1');
INSERT INTO `sys_menu` VALUES ('25', null, 'system:role:privilege', '2', '6', '角色授权', 'ui-icon ui-icon-person', '2');
INSERT INTO `sys_menu` VALUES ('26', '', 'system:goods', '0', '11', '商品管理', 'ui-icon ui-icon-triangle-1-e', '2');
INSERT INTO `sys_menu` VALUES ('27', '/warehouse/houseList', 'system:goods:respository', '1', '26', '库存信息', 'ui-icon ui-icon-calculator', '2');
INSERT INTO `sys_menu` VALUES ('28', null, 'system:goods:import', '1', '26', '进库管理', 'ui-icon ui-icon-arrowreturnthick-1-s', '1');
INSERT INTO `sys_menu` VALUES ('29', null, 'system:goods:export', '1', '26', '出库管理', 'ui-icon ui-icon-arrowreturnthick-1-n', '0');
INSERT INTO `sys_menu` VALUES ('30', null, 'system:user:allocate', '2', '3', '用户分配', 'ui-icon ui-icon-plus', '3');
INSERT INTO `sys_menu` VALUES ('31', null, 'system:role:query', '2', '6', '角色查询', 'ui-icon ui-icon-search', '3');
INSERT INTO `sys_menu` VALUES ('32', '/report/pie', 'system:business:analysis', '1', '13', '访问分析', 'ui-icon ui-icon-calculator', '0');
INSERT INTO `sys_menu` VALUES ('33', '/post/postManager', 'system:post:view', '1', '2', '岗位管理', 'ui-icon ui-icon-calculator', '2');
INSERT INTO `sys_menu` VALUES ('34', '/depart/depList', 'system:department:view', '1', '2', '部门管理', 'ui-icon ui-icon-calculator', '3');
INSERT INTO `sys_menu` VALUES ('35', null, 'system:role:update', '2', '6', '角色修改', null, '0');
INSERT INTO `sys_menu` VALUES ('36', null, 'system:dept:add', '2', '34', '新增部门', 'ui-icon ui-icon-plus', '7');
INSERT INTO `sys_menu` VALUES ('37', null, 'system:dept:update', '2', '34', '修改部门', 'ui-icon ui-icon-wrench', '6');
INSERT INTO `sys_menu` VALUES ('38', null, 'system:dept:delete', '2', '34', '删除部门', 'ui-icon ui-icon-minus', '5');
INSERT INTO `sys_menu` VALUES ('39', null, 'system:dept:list', '2', '34', '部门列表', 'ui-icon ui-icon-disk', '4');
INSERT INTO `sys_menu` VALUES ('40', null, 'system:dept:allocate', '2', '34', '员工分配', 'ui-icon ui-icon-contact', '3');
INSERT INTO `sys_menu` VALUES ('41', null, 'system:dept:change', '2', '34', '部门切换', 'ui-icon ui-icon-transfer-e-w', '2');
INSERT INTO `sys_menu` VALUES ('42', null, 'system:dept:lock', '2', '34', '绑定', 'ui-icon ui-icon-locked', '1');
INSERT INTO `sys_menu` VALUES ('43', null, 'system:dept:unlock', '2', '34', '解绑', 'ui-icon ui-icon-unlockeds', '0');
INSERT INTO `sys_menu` VALUES ('44', null, 'system:seller', '0', '11', '供应商', 'ui-icon ui-icon-triangle-1-e', '2');
INSERT INTO `sys_menu` VALUES ('45', null, 'system::buyer', '0', '11', '采购商', 'ui-icon ui-icon-triangle-1-e', '2');
INSERT INTO `sys_menu` VALUES ('46', '/gradeitem/gradeitem', 'system:grade:item', '2', '44', '供应商评价指标', 'ui-icon ui-icon-calculator', '0');
INSERT INTO `sys_menu` VALUES ('47', '/gradeData/gradeData', 'system:goods:respository', '1', '44', '供应商评级数据', 'ui-icon ui-icon-calculator', '3');
INSERT INTO `sys_menu` VALUES ('48', '/seller/sellerInfo', 'system:seller:sellerInfo', '1', '44', '供应商信息', 'ui-icon ui-icon-minus', '4');
INSERT INTO `sys_menu` VALUES ('49', '/buyer/buyerList', 'system::buyerInfo', '2', '45', '采购商信息', 'ui-icon ui-icon-calculator', '2');
INSERT INTO `sys_menu` VALUES ('50', '/file/uploadPage', 'system:plat:electronicupload', '1', '12', '上传合同', 'ui-icon ui-icon-calculator', '1');
INSERT INTO `sys_menu` VALUES ('144', '/organization/orglist', 'system:organization:view', '1', '2', '组织管理', 'ui-icon ui-icon-calculator', '4');
INSERT INTO `sys_menu` VALUES ('145', null, 'system:apply:applyCut', '2', '41', '申请调换', 'ui-icon ui-icon-transfer-e-w', '3');
INSERT INTO `sys_menu` VALUES ('146', null, 'system:apply:apply', '2', '41', '审批', 'ui-icon ui-icon-pencil', '2');
INSERT INTO `sys_menu` VALUES ('147', null, 'system:apply:replaceApply', '2', '41', '代发申请', 'ui-icon ui-icon-person', '1');
INSERT INTO `sys_menu` VALUES ('148', null, 'system:apply:cut', '2', '41', '切换', 'ui-icon ui-icon-transferthick-e-w', '0');
INSERT INTO `sys_menu` VALUES ('210', '', 'system:service', '0', '11', 'OJ', 'ui-icon ui-\r\n\r\nui-icon ui-icon-carat-1-n', '5');
INSERT INTO `sys_menu` VALUES ('211', '/subjectController/subject', 'system:goods', '1', '210', '题目管理', 'ui-icon ui-icon-triangle-1-e', '10');
INSERT INTO `sys_menu` VALUES ('300', '/oj/ojIndex', 'system:service', '1', '210', '做题', 'ui-icon ui-icon-minus', '0');
INSERT INTO `sys_menu` VALUES ('212', null, 'monitor:operlog:list', null, '10', '日志列表', null, null);
INSERT INTO `sys_menu` VALUES ('213', null, 'monitor:operlog:remove', null, '10', '删除日志', null, null);
INSERT INTO `sys_menu` VALUES ('214', null, 'monitor:operlog:updata', null, '10', '修改日志', null, null);
-- ----------------------------
-- Table structure for `sys_language`
-- ----------------------------
DROP TABLE IF EXISTS `sys_language`;
CREATE TABLE `sys_language` (
  `lang_id` int(10) NOT NULL AUTO_INCREMENT,
  `lang_type` varchar(30) DEFAULT NULL COMMENT '语言类型',
  `lang_desc` varchar(20) DEFAULT NULL COMMENT '语言描述',
  PRIMARY KEY (`lang_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT '语言表';

-- ----------------------------
-- Records of sys_language
-- ----------------------------
INSERT INTO `sys_language` VALUES ('1', 'zh', '中文');
INSERT INTO `sys_language` VALUES ('2', 'en', '英文');

-- ----------------------------
-- Table structure for `sys_i18n`
-- ----------------------------
DROP TABLE IF EXISTS `sys_i18n`;
CREATE TABLE `sys_i18n` (
  `inter_id` int(100) NOT NULL AUTO_INCREMENT,
  `inter_menu_id` int(10) DEFAULT NULL COMMENT '菜单ID',
  `inter_lang_id` int(10) DEFAULT NULL COMMENT '语言ID',
  `inter_value` varchar(200) DEFAULT NULL COMMENT '国际化值',
  PRIMARY KEY (`inter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT '国际化表';

-- ----------------------------
-- Records of sys_i18n
-- ----------------------------
INSERT INTO `sys_i18n` VALUES ('1', '1', '1', '系统管理');
INSERT INTO `sys_i18n` VALUES ('2', '1', '2', 'System Manage');
INSERT INTO `sys_i18n` VALUES ('3', '2', '1', '用户及授权管理');
INSERT INTO `sys_i18n` VALUES ('4', '2', '2', 'User/Role Manage');
INSERT INTO `sys_i18n` VALUES ('5', '3', '1', '用户管理');
INSERT INTO `sys_i18n` VALUES ('6', '3', '2', 'User Manage');
INSERT INTO `sys_i18n` VALUES ('11', '6', '1', '角色管理');
INSERT INTO `sys_i18n` VALUES ('12', '6', '2', 'Role Manage');
INSERT INTO `sys_i18n` VALUES ('13', '7', '1', '系统配置');
INSERT INTO `sys_i18n` VALUES ('14', '7', '2', 'System Settings');
INSERT INTO `sys_i18n` VALUES ('15', '8', '1', '日志管理');
INSERT INTO `sys_i18n` VALUES ('16', '8', '2', 'Log Manage');
INSERT INTO `sys_i18n` VALUES ('17', '9', '1', '安全配置');
INSERT INTO `sys_i18n` VALUES ('18', '9', '2', 'Security Manage');
INSERT INTO `sys_i18n` VALUES ('19', '10', '1', '操作日志管理');
INSERT INTO `sys_i18n` VALUES ('20', '10', '2', 'Operation Log Manage');
INSERT INTO `sys_i18n` VALUES ('21', '11', '1', '业务管理');
INSERT INTO `sys_i18n` VALUES ('22', '11', '2', 'Bussiness Manage');
INSERT INTO `sys_i18n` VALUES ('23', '12', '1', '合同管理');
INSERT INTO `sys_i18n` VALUES ('24', '12', '2', 'Bargin Manage');
INSERT INTO `sys_i18n` VALUES ('25', '13', '1', '交易分析');
INSERT INTO `sys_i18n` VALUES ('26', '13', '2', 'Business Analysis');
INSERT INTO `sys_i18n` VALUES ('27', '14', '1', '商品管理');
INSERT INTO `sys_i18n` VALUES ('28', '14', '2', 'Goods Manage');
INSERT INTO `sys_i18n` VALUES ('29', '15', '1', '电子合同');
INSERT INTO `sys_i18n` VALUES ('30', '15', '2', 'Electronic Plat');
INSERT INTO `sys_i18n` VALUES ('31', '16', '1', '合同协议库');
INSERT INTO `sys_i18n` VALUES ('32', '16', '2', 'Plat Repository');
INSERT INTO `sys_i18n` VALUES ('33', '17', '1', '市场数据');
INSERT INTO `sys_i18n` VALUES ('34', '17', '2', 'Market data');
INSERT INTO `sys_i18n` VALUES ('35', '18', '1', '交易数据');
INSERT INTO `sys_i18n` VALUES ('36', '18', '2', 'Business Data');
INSERT INTO `sys_i18n` VALUES ('37', '19', '1', '用户添加');
INSERT INTO `sys_i18n` VALUES ('38', '19', '2', 'Add User');
INSERT INTO `sys_i18n` VALUES ('39', '20', '1', '用户删除');
INSERT INTO `sys_i18n` VALUES ('40', '20', '2', 'Delete User');
INSERT INTO `sys_i18n` VALUES ('41', '21', '1', '用户查询');
INSERT INTO `sys_i18n` VALUES ('42', '21', '2', 'Query User');
INSERT INTO `sys_i18n` VALUES ('43', '22', '1', '角色添加');
INSERT INTO `sys_i18n` VALUES ('44', '22', '2', 'Add Role');
INSERT INTO `sys_i18n` VALUES ('45', '23', '1', '角色删除');
INSERT INTO `sys_i18n` VALUES ('46', '23', '2', 'Delete Role');
INSERT INTO `sys_i18n` VALUES ('47', '24', '1', '查询');
INSERT INTO `sys_i18n` VALUES ('48', '24', '2', 'delete');
INSERT INTO `sys_i18n` VALUES ('49', '25', '1', '授权');
INSERT INTO `sys_i18n` VALUES ('50', '25', '2', 'authorization');
INSERT INTO `sys_i18n` VALUES ('51', '26', '1', '商品管理');
INSERT INTO `sys_i18n` VALUES ('52', '26', '2', 'Goods Manage');
INSERT INTO `sys_i18n` VALUES ('53', '27', '1', '库存信息');
INSERT INTO `sys_i18n` VALUES ('54', '27', '2', 'Repository Info');
INSERT INTO `sys_i18n` VALUES ('55', '28', '1', '进库管理');
INSERT INTO `sys_i18n` VALUES ('56', '28', '2', 'Import Manage');
INSERT INTO `sys_i18n` VALUES ('57', '29', '1', '出库管理');
INSERT INTO `sys_i18n` VALUES ('58', '29', '2', 'Export Manage');
INSERT INTO `sys_i18n` VALUES ('59', '30', '1', '用户分配');
INSERT INTO `sys_i18n` VALUES ('60', '30', '2', 'Allocate User');
INSERT INTO `sys_i18n` VALUES ('61', '31', '1', '角色查询');
INSERT INTO `sys_i18n` VALUES ('62', '31', '2', 'Query Role');
INSERT INTO `sys_i18n` VALUES ('63', '32', '1', '访问分析');
INSERT INTO `sys_i18n` VALUES ('64', '32', '2', 'Access Analysis');
INSERT INTO `sys_i18n` VALUES ('65', '33', '1', '岗位管理');
INSERT INTO `sys_i18n` VALUES ('66', '33', '2', 'Post Manage');
INSERT INTO `sys_i18n` VALUES ('67', '1001', '1', '男');
INSERT INTO `sys_i18n` VALUES ('68', '1001', '2', 'man');
INSERT INTO `sys_i18n` VALUES ('69', '1002', '1', '女');
INSERT INTO `sys_i18n` VALUES ('70', '1002', '2', 'woman');
INSERT INTO `sys_i18n` VALUES ('71', '1003', '1', '未知');
INSERT INTO `sys_i18n` VALUES ('72', '1003', '2', 'unknown');
INSERT INTO `sys_i18n` VALUES ('73', '34', '1', '部门管理');
INSERT INTO `sys_i18n` VALUES ('74', '34', '2', 'Department Manage');
INSERT INTO `sys_i18n` VALUES ('75', '35', '1', '角色修改');
INSERT INTO `sys_i18n` VALUES ('76', '35', '2', 'Update Role');
INSERT INTO `sys_i18n` VALUES ('77', '36', '1', '新增部门');
INSERT INTO `sys_i18n` VALUES ('78', '36', '2', 'Add Department');
INSERT INTO `sys_i18n` VALUES ('79', '37', '1', '修改部门');
INSERT INTO `sys_i18n` VALUES ('80', '37', '2', 'Update Department');
INSERT INTO `sys_i18n` VALUES ('81', '38', '1', '删除部门');
INSERT INTO `sys_i18n` VALUES ('82', '38', '2', 'Delete Department');
INSERT INTO `sys_i18n` VALUES ('83', '39', '1', '部门列表');
INSERT INTO `sys_i18n` VALUES ('84', '39', '2', 'Department List');
INSERT INTO `sys_i18n` VALUES ('85', '40', '1', '员工分配');
INSERT INTO `sys_i18n` VALUES ('86', '40', '2', 'Allocate Staff');
INSERT INTO `sys_i18n` VALUES ('87', '41', '1', '部门切换');
INSERT INTO `sys_i18n` VALUES ('88', '41', '2', 'Change Department');
INSERT INTO `sys_i18n` VALUES ('89', '42', '1', '绑定');
INSERT INTO `sys_i18n` VALUES ('90', '42', '2', 'Lock Department');
INSERT INTO `sys_i18n` VALUES ('91', '43', '1', '解绑');
INSERT INTO `sys_i18n` VALUES ('92', '43', '2', 'Unlock Department');
INSERT INTO `sys_i18n` VALUES ('93', '1004', '1', '成功');
INSERT INTO `sys_i18n` VALUES ('94', '1004', '2', 'success');
INSERT INTO `sys_i18n` VALUES ('95', '1005', '1', '失败');
INSERT INTO `sys_i18n` VALUES ('96', '1005', '2', 'fail');
INSERT INTO `sys_i18n` VALUES ('97', '1006', '1', '管理部门');
INSERT INTO `sys_i18n` VALUES ('98', '1006', '2', 'Manage Department');
INSERT INTO `sys_i18n` VALUES ('99', '1007', '1', '财务部门');
INSERT INTO `sys_i18n` VALUES ('100', '1007', '2', 'Finance Department');
INSERT INTO `sys_i18n` VALUES ('101', '1008', '1', '人事部门');
INSERT INTO `sys_i18n` VALUES ('102', '1008', '2', 'Personnel Department');
INSERT INTO `sys_i18n` VALUES ('103', '1009', '1', '后勤部门');
INSERT INTO `sys_i18n` VALUES ('104', '1009', '2', 'Back Office');
INSERT INTO `sys_i18n` VALUES ('105', '1010', '1', '系统');
INSERT INTO `sys_i18n` VALUES ('106', '1010', '2', 'System');
INSERT INTO `sys_i18n` VALUES ('107', '1011', '1', '电力公司');
INSERT INTO `sys_i18n` VALUES ('108', '1011', '2', 'Power Company');
INSERT INTO `sys_i18n` VALUES ('109', '1012', '1', '煤炭公司');
INSERT INTO `sys_i18n` VALUES ('110', '1012', '2', 'Coal Company');
INSERT INTO `sys_i18n` VALUES ('111', '1013', '1', '贸易电商');
INSERT INTO `sys_i18n` VALUES ('112', '1013', '2', 'Trade E-Commerce');
INSERT INTO `sys_i18n` VALUES ('113', '46', '1', '供应商评价指标');
INSERT INTO `sys_i18n` VALUES ('114', '46', '2', 'Grade Item');
INSERT INTO `sys_i18n` VALUES ('115', '47', '1', '供应商评级数据');
INSERT INTO `sys_i18n` VALUES ('116', '47', '2', 'sellergrade');
INSERT INTO `sys_i18n` VALUES ('117', '44', '1', '供应商');
INSERT INTO `sys_i18n` VALUES ('118', '44', '2', 'seller');
INSERT INTO `sys_i18n` VALUES ('119', '45', '1', '采购商');
INSERT INTO `sys_i18n` VALUES ('120', '45', '2', 'buyer');
INSERT INTO `sys_i18n` VALUES ('121', '48', '1', '供应商信息');
INSERT INTO `sys_i18n` VALUES ('122', '48', '2', 'sellerInfo');
INSERT INTO `sys_i18n` VALUES ('123', '49', '1', '采购商信息');
INSERT INTO `sys_i18n` VALUES ('124', '49', '2', 'buyerInfo');
INSERT INTO `sys_i18n` VALUES ('127', '50', '1', '上传合同');
INSERT INTO `sys_i18n` VALUES ('128', '50', '2', 'UploadContract');
INSERT INTO `sys_i18n` VALUES ('125', '144', '1', '组织管理');
INSERT INTO `sys_i18n` VALUES ('126', '144', '2', 'Organization Manage');
INSERT INTO `sys_i18n` VALUES ('210', '210', '1', 'OJ');
INSERT INTO `sys_i18n` VALUES ('211', '210', '2', 'OJ');
INSERT INTO `sys_i18n` VALUES ('212', '211', '1', '题目管理');
INSERT INTO `sys_i18n` VALUES ('213', '211', '2', 'subject');
INSERT INTO `sys_i18n` VALUES ('300', '300', '1', '做题');
INSERT INTO `sys_i18n` VALUES ('301', '300', '2', 'practice');
INSERT INTO `sys_i18n` VALUES ('214', '212', '1', '日志列表');
INSERT INTO `sys_i18n` VALUES ('215', '212', '2', 'operlog_list');
INSERT INTO `sys_i18n` VALUES ('216', '213', '1', '删除日志');
INSERT INTO `sys_i18n` VALUES ('217', '213', '2', 'delete_log');
INSERT INTO `sys_i18n` VALUES ('218', '214', '1', '更新日志');
INSERT INTO `sys_i18n` VALUES ('219', '214', '2', 'update_log');
INSERT INTO `sys_i18n` VALUES ('1000', '1101', '1', '组织');
INSERT INTO `sys_i18n` VALUES ('1001', '1101', '2', 'organization');
INSERT INTO `sys_i18n` VALUES ('1002', '1102', '1', '部门');
INSERT INTO `sys_i18n` VALUES ('1003', '1102', '2', 'dept');
INSERT INTO `sys_i18n` VALUES ('1004', '1103', '1', '岗位');
INSERT INTO `sys_i18n` VALUES ('1005', '1103', '2', 'post');
INSERT INTO `sys_i18n` VALUES ('1006', '1104', '1', '总公司');
INSERT INTO `sys_i18n` VALUES ('1007', '1104', '2', 'head_office');
INSERT INTO `sys_i18n` VALUES ('1008', '1105', '1', '分公司');
INSERT INTO `sys_i18n` VALUES ('1009', '1105', '2', 'branch_office');
INSERT INTO `sys_i18n` VALUES ('1010', '1106', '1', '电厂');
INSERT INTO `sys_i18n` VALUES ('1011', '1106', '2', 'power_plant');
INSERT INTO `sys_i18n` VALUES ('1012', '145', '1', '申请调换');
INSERT INTO `sys_i18n` VALUES ('1013', '145', '2', 'Change Application');
INSERT INTO `sys_i18n` VALUES ('1014', '146', '1', '审批');
INSERT INTO `sys_i18n` VALUES ('1015', '146', '2', 'Approve');
INSERT INTO `sys_i18n` VALUES ('1016', '147', '1', '代发申请');
INSERT INTO `sys_i18n` VALUES ('1017', '147', '2', 'Replace Application');
INSERT INTO `sys_i18n` VALUES ('1018', '148', '1', '切换');
INSERT INTO `sys_i18n` VALUES ('1019', '148', '2', 'Cut');

-- ----------------------------
-- Table structure for `sys_dict_data`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` int(11) NOT NULL AUTO_INCREMENT COMMENT '字典编码,与国际化表的菜单id相对应',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('3', '用户管理', 'user_manager', 'sys_manger', 'N', '0', '用户管理');
INSERT INTO `sys_dict_data` VALUES ('6', '角色管理', 'role_manager', 'sys_manger', 'N', '0', '角色管理');
INSERT INTO `sys_dict_data` VALUES ('10', '操作日志管理', 'operlog_manager', 'sys_manger', 'N', '0', '操作日志管理');
INSERT INTO `sys_dict_data` VALUES ('19', '用户添加', '5', 'sys_module_user', 'N', '0', '用户添加');
INSERT INTO `sys_dict_data` VALUES ('22', '角色添加', '1', 'sys_module_role', 'N', '0', '角色添加');
INSERT INTO `sys_dict_data` VALUES ('23', '角色删除', '2', 'sys_module_role', 'N', '0', '角色删除');
INSERT INTO `sys_dict_data` VALUES ('25', '角色授权', '3', 'sys_module_role', 'N', '0', '角色授权');
INSERT INTO `sys_dict_data` VALUES ('35', '角色修改', '4', 'sys_module_role', 'N', '0', '角色修改');
INSERT INTO `sys_dict_data` VALUES ('1001', '男', '0', 'sys_user_sex', 'Y', '0', '性别男');
INSERT INTO `sys_dict_data` VALUES ('1002', '女', '1', 'sys_user_sex', 'N', '0', '性别女');
INSERT INTO `sys_dict_data` VALUES ('1003', '未知', '2', 'sys_user_sex', 'N', '0', '性别未知');
INSERT INTO `sys_dict_data` VALUES ('1004', '成功', '0', 'sys_operate_status', 'N', '0', '操作成功');
INSERT INTO `sys_dict_data` VALUES ('1005', '失败', '1', 'sys_operate_status', 'N', '0', '操作失败');
INSERT INTO `sys_dict_data` VALUES ('1006', '管理部门', 'manage_dept', 'sys_dept', 'N', '0', '管理部门');
INSERT INTO `sys_dict_data` VALUES ('1007', '财务部门', 'finance_dept', 'sys_dept', 'N', '0', '财务部门');
INSERT INTO `sys_dict_data` VALUES ('1008', '人事部门', 'personnel_dept', 'sys_dept', 'N', '0', '人事部门');
INSERT INTO `sys_dict_data` VALUES ('1009', '后勤部门', 'back_office', 'sys_dept', 'N', '0', '后勤部门');
INSERT INTO `sys_dict_data` VALUES ('1010', '系统', 'system', 'sys_dept', 'N', '0', '系统');
INSERT INTO `sys_dict_data` VALUES ('1011', '电力公司', 'electronic_org', 'sys_org', 'N', '0', '电力公司');
INSERT INTO `sys_dict_data` VALUES ('1012', '煤炭公司', 'coal_org', 'sys_org', 'N', '0', '煤炭公司');
INSERT INTO `sys_dict_data` VALUES ('1013', '贸易电商', 'trade_e-commerce', 'sys_org', 'N', '0', '贸易电商');
INSERT INTO `sys_dict_data` VALUES ('1101', '组织', 'organization', 'sys_organization_branch', 'N', '0', '');
INSERT INTO `sys_dict_data` VALUES ('1102', '部门', 'dept', 'sys_organization_branch', 'N', '0', '');
INSERT INTO `sys_dict_data` VALUES ('1103', '岗位', 'post', 'sys_organization_branch', 'N', '0', '');
INSERT INTO `sys_dict_data` VALUES ('1104', '总公司', '1', 'sys_organization_type', 'N', '0', '');
INSERT INTO `sys_dict_data` VALUES ('1105', '分公司', '2', 'sys_organization_type', 'N', '0', '');
INSERT INTO `sys_dict_data` VALUES ('1106', '电厂', '3', 'sys_organization_type', 'N', '0', '');

-- ----------------------------
-- Records of good_store
-- ----------------------------
INSERT INTO `good_store` VALUES ('1', '西红柿', '5', '南京一农场', '4');
INSERT INTO `good_store` VALUES ('3', '茄子1', '3', '南京三给农场', '4');
INSERT INTO `good_store` VALUES ('6', '农夫山泉矿泉水', '1200', '红旗一厂', '2');
INSERT INTO `good_store` VALUES ('12', '塔顶1', '23', '平安大厂', '23');
INSERT INTO `good_store` VALUES ('13', '读书法', '23', '213', '123');
INSERT INTO `good_store` VALUES ('14', '村2', '23', '大厂', '23');
INSERT INTO `good_store` VALUES ('16', '工地', '23', '顶替', '123');
INSERT INTO `good_store` VALUES ('17', '枯夺', '123', '123', '123');
INSERT INTO `good_store` VALUES ('18', '根本在', '123', '123', '123');
INSERT INTO `good_store` VALUES ('19', 'dsf标有', '12', '11', '123');
INSERT INTO `good_store` VALUES ('20', '12地地', '123', '123', '123');
INSERT INTO `good_store` VALUES ('21', '1霸', '123', '123', '123');
INSERT INTO `good_store` VALUES ('22', '123革', '123', '上海一汽', '132');
INSERT INTO `good_store` VALUES ('23', '笔记本电脑', '100', '神州数码', '3300');
INSERT INTO `good_store` VALUES ('24', '西红柿1', '2', '23', '12');
INSERT INTO `good_store` VALUES ('37', '12', '123', '123', '10');
INSERT INTO `good_store` VALUES ('38', '12', '12', '112', '10');
INSERT INTO `good_store` VALUES ('39', '红色', '123', '13', '10');



-- ----------------------------
-- Table structure for `sm_post`
-- ----------------------------
DROP TABLE IF EXISTS `sm_post`;
CREATE TABLE `sm_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `role_id` int(10) NOT NULL COMMENT '角色ID',
  `org_id` int(10) NOT NULL COMMENT '组织ID',
  `post_name` varchar(64) NOT NULL COMMENT '岗位名称',
  `post_describe` varchar(64) NOT NULL COMMENT '岗位描述',
  `creat_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `del_flag` int(11) DEFAULT '0' COMMENT '删除标志(0为未删除，1为已删除，默认为0)',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_post
-- ----------------------------
INSERT INTO `sm_post` VALUES ('1', '1', '1', '总经理', '管理员', '2018-11-21 17:02:12', '2018-11-21 17:02:16', '0');
INSERT INTO `sm_post` VALUES ('2', '2', '2', '后勤', '员工', '2018-11-21 17:02:12', '2018-11-23 17:07:46', '0');
INSERT INTO `sm_post` VALUES ('3', '3', '3', '经理', '中层', '2018-11-21 17:02:12', '2018-11-26 17:05:16', '0');
-- ----------------------------
-- Table structure for `sm_post_ref_user`
-- ----------------------------
DROP TABLE IF EXISTS `sm_post_ref_user`;
CREATE TABLE `sm_post_ref_user` (
  `post_id` int(20) NOT NULL COMMENT '岗位id',
  `user_id` int(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sm_post_ref_user
-- ----------------------------
INSERT INTO `sm_post_ref_user` VALUES ('1', '0');
INSERT INTO `sm_post_ref_user` VALUES ('2', '0');
INSERT INTO `sm_post_ref_user` VALUES ('3', '0');
INSERT INTO `sm_post_ref_user` VALUES ('1', '2');
INSERT INTO `sm_post_ref_user` VALUES ('2', '2');
INSERT INTO `sm_post_ref_user` VALUES ('2', '3');
INSERT INTO `sm_post_ref_user` VALUES ('3', '3');
INSERT INTO `sm_post_ref_user` VALUES ('2', '207');
INSERT INTO `sm_post_ref_user` VALUES ('3', '207');
INSERT INTO `sm_post_ref_user` VALUES ('1', '208');
INSERT INTO `sm_post_ref_user` VALUES ('3', '208');
INSERT INTO `sm_post_ref_user` VALUES ('1', '209');
INSERT INTO `sm_post_ref_user` VALUES ('2', '209');
INSERT INTO `sm_post_ref_user` VALUES ('3', '209');

-- ----------------------------
-- Table structure for `sys_department`
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department` (
  `dep_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `dep_name` varchar(255) DEFAULT NULL COMMENT '部门名称',
  `dep_describe` varchar(255) DEFAULT NULL COMMENT '部门描述',
  `org_id` int(10) DEFAULT NULL COMMENT '组织id',
  `dep_par_id` int(10) DEFAULT NULL COMMENT '副部门id',
  `sort` int(10) DEFAULT NULL COMMENT '部门排序',
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES ('100', '管理部门', '参与公司决策及管理', '1', '-1', '0');
INSERT INTO `sys_department` VALUES ('101', '财务部门', '掌管公司财务', '1', '-1', '1');
INSERT INTO `sys_department` VALUES ('102', '人事部门', '人事调动', '1', '100', '0');
INSERT INTO `sys_department` VALUES ('103', '后勤部门', '后勤', '2', '-1', '0');
INSERT INTO `sys_department` VALUES ('104', '测试', '测试', '3', '-1', '0');

-- ----------------------------
-- Table structure for `sys_user_dept`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_dept`;
CREATE TABLE `sys_user_dept` (
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `dep_id` int(10) NOT NULL COMMENT '部门id',
  `dep_apply_id` int(10) DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户部门表';

-- ----------------------------
-- Records of sys_user_dept
-- ----------------------------
INSERT INTO `sys_user_dept` VALUES ('2', '101', '1', '0');
INSERT INTO `sys_user_dept` VALUES ('3', '102', null, null);
INSERT INTO `sys_user_dept` VALUES ('207', '104', '1', '1');
INSERT INTO `sys_user_dept` VALUES ('208', '103', null, null);
INSERT INTO `sys_user_dept` VALUES ('209', '104', null, null);

-- ----------------------------
-- Table structure for `sys_org`
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org` (
  `org_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '组织id',
  `parent_id` int(10) DEFAULT NULL COMMENT '父id',
  `org_name` varchar(255) DEFAULT NULL COMMENT '组织名称',
  `org_type` varchar(32) DEFAULT NULL COMMENT '组织类型（1集团、2分公司、3电厂）',
  `status` char(1) DEFAULT '0' COMMENT '是否删除（0：未删除，1：删除）',
  `modifier` varchar(32) DEFAULT NULL COMMENT '修改人',
  `modtime` datetime DEFAULT NULL COMMENT '修改时间',
  `description` varchar(400) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='组织表';

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES ('1', '-1', '系统', '1', '0', null, '2018-12-03 09:44:13', 'a');
INSERT INTO `sys_org` VALUES ('2', '1', '煤炭公司', '2', '0', null, '2018-12-03 10:06:33', 'a');
INSERT INTO `sys_org` VALUES ('3', '1', '贸易电商', '1', '0', null, '2018-12-03 11:15:47', 'a');
-- ----------------------------
-- Table structure for `t_suppliergradeitem`
-- ----------------------------
DROP TABLE IF EXISTS `t_suppliergradeitem`;
CREATE TABLE `t_suppliergradeitem` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '指标标识',
  `item_code` varchar(50) NOT NULL COMMENT '指标代码',
  `item_name` varchar(128) DEFAULT NULL COMMENT '指标名称',
  `prcsn` int(11) DEFAULT NULL COMMENT '精度',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `weight` float(6,2) DEFAULT NULL COMMENT '权重',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_suppliergradeitem
-- ----------------------------
INSERT INTO `t_suppliergradeitem` VALUES ('2', '1234', '供应商', '10000', '2', '400.00', '有钱');
INSERT INTO `t_suppliergradeitem` VALUES ('6', '8080', '煤老板', '1000', null, '600.00', '2345');
INSERT INTO `t_suppliergradeitem` VALUES ('9', '8070', '供应商123', '1000', null, '200.00', '累死');

-- ----------------------------
-- Table structure for t_fultbsupplier
-- ----------------------------
DROP TABLE IF EXISTS `t_fultbsupplier`;
CREATE TABLE `t_fultbsupplier` (
  `supplierid` int(64) NOT NULL AUTO_INCREMENT COMMENT '供应商ID',
  `seller_name` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `linkman` varchar(64) DEFAULT NULL COMMENT '联系人',
  `linktel` varchar(64) DEFAULT NULL COMMENT '联系电话',
  `address` varchar(256) DEFAULT NULL COMMENT '联系地址',
  PRIMARY KEY (`supplierid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_fultbsupplier
-- ----------------------------
INSERT INTO `t_fultbsupplier` VALUES ('1', 'ccvfqq', 'rvvc', '5148', 'dcdedf');
INSERT INTO `t_fultbsupplier` VALUES ('2', '111', '222', '23231', '6288');
INSERT INTO `t_fultbsupplier` VALUES ('4', 'dds', 'faaa', '3435', 'sfff');
INSERT INTO `t_fultbsupplier` VALUES ('5', 'dfeiwwei', 'svmdev', '4845', 'dvaw');

-- ----------------------------
-- Table structure for t_supgradeitem_data
-- ----------------------------
DROP TABLE IF EXISTS `t_supgradeitem_data`;
CREATE TABLE `t_supgradeitem_data` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `SUPPLIERID` varchar(36) DEFAULT NULL,
  `TIME_TYPE_ID` varchar(10) DEFAULT NULL,
  `ITEM_ID` varchar(32) DEFAULT NULL,
  `TIME_ID` datetime DEFAULT NULL,
  `ITEM_CODE` varchar(50) DEFAULT NULL,
  `SYS_RES_CODE` varchar(200) DEFAULT NULL,
  `BUYERCODE` varchar(32) DEFAULT NULL,
  `ITEM_VALUE_FACT` int(11) DEFAULT NULL,
  `ITEM_VALUE_REPORT` int(11) DEFAULT NULL,
  `ITEM_VALUE_APPROVE` int(11) DEFAULT NULL,
  `STATE_ID` int(11) DEFAULT NULL,
  `VERSION_ID` int(11) DEFAULT NULL,
  `FILL_IN_PERSON` varchar(32) DEFAULT NULL,
  `DATE_ID` datetime DEFAULT NULL,
  `END_UPDATE_DATE` datetime DEFAULT NULL,
  `REMARKS` varchar(100) DEFAULT NULL,
  `AUDITING_FLAG` varchar(1) DEFAULT NULL,
  `REPORT_SET` varchar(32) DEFAULT NULL,
  `IS_GS_CHECK` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='供应商评级数据\r\nID varchar(32) not null comment ''标识'',\r\n SUPPLIERID varchar(36),\r\n TIME_TYPE_ID varchar(10) comment ''时间类型:日,周,月,季,年'',\r\n ITEM_ID varchar(32),\r\n TIME_ID datetime\r\n ITEM_CODE varchar(50) comment ''本编码可以从标准指标编码选择，也可自己添加，只代表指标编码，不冠前缀'',\r\n SYS_RES_CODE varchar(200) comment ''机构编码'',\r\n BUYERCODE varchar(32) comment ''采购商编码'',\r\n ITEM_VALUE_FACT int( comment ''实际值'',\r\n ITEM_VALUE_REPORT int comment ''上报值'',\r\n ITEM_VALUE_APPROVE int comment ''审批值'',\r\n   STATE_ID int comment ''1：草稿状态 (保存)\r\n 2：初始状态 (提交)\r\n 3: 前期修改状态 (提交后到上报时间点前的修改状态)\r\n 4: 后期修改状态 (上报时间点后的修改状态)'',\r\n VERSION_ID int,\r\n FILL_IN_PERSON varchar(32),\r\n DATE_ID datetime ''日期标识'',\r\n END_UPDATE_DATE datetime,\r\n REMARKS varchar(100) comment ''备注'',\r\n AUDITING_FLAG varchar(1) comment ''审核标志'',\r\n REPORT_SET varchar(32) comment ''上报类型:1-不上报，2-上报集团，3-上报分公司，4-上报集团和分公司'',\r\n IS_GS_CHECK varchar(10) comment ''是否公司审核：1：是，分公司审核；0：否，分公司不审核'',\r\n';

-- ----------------------------
-- Records of t_supgradeitem_data
-- ----------------------------
INSERT INTO `t_supgradeitem_data` VALUES ('1', null, null, null, null, null, '123465789', '345687', '123', '456', '789', '1', null, null, null, null, '测试', null, null, null);


-- ----------------------------
-- Table structure for t_fultbsupplier2
-- ----------------------------
DROP TABLE IF EXISTS `t_fultbsupplier2`;
CREATE TABLE `t_fultbsupplier2` (
  `buyerid` int(36) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `linkman` varchar(64) DEFAULT NULL COMMENT '联系人',
  `linktel` varchar(64) DEFAULT NULL COMMENT '联系电话',
  `address` varchar(256) DEFAULT NULL COMMENT '联系地址',
  PRIMARY KEY (`buyerid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_fultbsupplier2
-- ----------------------------
INSERT INTO `t_fultbsupplier2` VALUES ('1', '50', '6', '5', '5');
INSERT INTO `t_fultbsupplier2` VALUES ('2', '2', 'dd', '120', null);
INSERT INTO `t_fultbsupplier2` VALUES ('3', '3', 'cc', '1879597', 'cc');
INSERT INTO `t_fultbsupplier2` VALUES ('5', '5', 'ee', '6', '8');
INSERT INTO `t_fultbsupplier2` VALUES ('15', '2', '2', '222', '0');
INSERT INTO `t_fultbsupplier2` VALUES ('16', '4', '3', '9', '0');
INSERT INTO `t_fultbsupplier2` VALUES ('17', '8', '8', '8', '8');
INSERT INTO `t_fultbsupplier2` VALUES ('18', '8', '0', '8', '0');

-- ----------------------------
-- Table structure for `office_document_data`
-- ----------------------------
DROP TABLE IF EXISTS `office_document_data`;
CREATE TABLE `office_document_data` (
  `docutment_data_id` varchar(50) NOT NULL COMMENT '文档id',
  `docutment_data_name` varchar(256) DEFAULT NULL COMMENT '数据名称',
  `docutment_data` longtext COMMENT '文档数据',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`docutment_data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档数据表';

-- ----------------------------
-- Table structure for `office_document_info`
-- ----------------------------
DROP TABLE IF EXISTS `office_document_info`;
CREATE TABLE `office_document_info` (
  `docutment_info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文档id',
  `docutment_info_name` varchar(256) DEFAULT NULL COMMENT '文档名称',
  `docutment_head_data_id` varchar(50) DEFAULT NULL COMMENT '文档头数据id',
  `docutment_body_data_id` varchar(50) DEFAULT NULL COMMENT '文档体数据id',
  `docutment_pict_data_id` varchar(50) DEFAULT NULL COMMENT '文档图片数据id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`docutment_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='文档信息表';

DROP TABLE IF EXISTS `t_subject`;
CREATE TABLE `t_subject` (
  `subject_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '题目编号',
  `subject_name` varchar(128) NOT NULL COMMENT '题目名称',
  `subject_desc` varchar(256) NOT NULL COMMENT '题目描述',
  `subject_input` varchar(1024) NOT NULL COMMENT '题目输入',
  `subject_out` varchar(1024) NOT NULL COMMENT '题目输出',
  `sample_input` varchar(1024) NOT NULL COMMENT '样例输入',
  `sample_out` varchar(1024) NOT NULL COMMENT '样例输出',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `unit_input` varchar(8192) NOT NULL COMMENT '用例输入',
  `unit_out` varchar(8192) NOT NULL COMMENT '用例输出',
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='题目表';

-- ----------------------------
-- Table structure for u_subject
-- ----------------------------
-- ----------------------------
-- Table structure for `u_subject`
-- ----------------------------
DROP TABLE IF EXISTS `u_subject`;
CREATE TABLE `u_subject` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_java` varchar(10240) NOT NULL,
  `state` int(11) NOT NULL,
  `e_log` varchar(10240) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_subject
-- ----------------------------
INSERT INTO `t_subject` VALUES ('7', '字符串最后一个单词的长度', '计算字符串最后一个单词的长度，单词以空格隔开。', '一行字符串，非空，长度小于5000。', '整数N，最后一个单词的长度。', 'hello world', '5', '2018-12-24 10:45:08', '2018-12-24 14:51:47', 'hello world', '5');
INSERT INTO `t_subject` VALUES ('8', '计算字符个数', '写出一个程序，接受一个由字母和数字组成的字符串，和一个字符，然后输出输入字符串中含有该字符的个数。不区分大小写。 ', '输入一个有字母和数字以及空格组成的字符串，和一个字符。', '输出输入字符串中含有该字符的个数。', 'ABCDEF A', '1', '2018-12-24 11:02:19', '2018-12-24 14:52:05', 'ABCDEF A', '1');
INSERT INTO `t_subject` VALUES ('9', '明明的随机数 ', ' 明明想在学校中请一些同学一起做一项问卷调查，为了实验的客观性，他先用计算机生成了N个1到1000之间的随机整数（N≤1000），对于其中重复的数字，只保留一个，把其余相同的数去掉，不同的数对应着不同的学生的学号。然后再把这些数从小到大排序，按照排好的顺序去找同学做调查。请你协助明明完成“去重”与“排序”的工作(同一个测试用例里可能会有多组数据，希望大家能正确处理)。\n\n\n\nInput Param\n\nn               输入随机数的个数\n\ninputArray      n个随机整数组成的数组\n\n\nReturn Value\n\nOutputArray    输出处理后的随机整数\n\n\n\n注：测试用例保证输入参数的正确性，答题者无需验证。测试用例不止一组。 ', '输入多行，先输入随机整数的个数，再输入相应个数的整数', '返回多行，处理后的结果', '11\n10\n20\n40\n32\n67\n40\n20\n89\n300\n400\n15', '10\n15\n20\n32\n40\n67\n89\n300\n400', '2018-12-24 11:21:26', '2018-12-24 13:49:43', '11\n10\n20\n40\n32\n67\n40\n20\n89\n300\n400\n15', '10\n15\n20\n32\n40\n67\n89\n300\n400');
INSERT INTO `t_subject` VALUES ('10', '字符串分隔 ', '?连续输入字符串，请按长度为8拆分每个字符串后输出到新的字符串数组；\n?长度不是8整数倍的字符串请在后面补数字0，空字符串不处理。', '连续输入字符串(输入2次,每个字符串长度小于100)', '输出到长度为8的新字符串数组', 'abc\n123456789', 'abc00000\n12345678\n90000000', '2018-12-24 13:52:43', '2018-12-24 13:52:43', 'abc\n123456789', 'abc00000\n12345678\n90000000');
INSERT INTO `t_subject` VALUES ('11', '进制转换 ', ' 写出一个程序，接受一个十六进制的数值字符串，输出该数值的十进制字符串。（多组同时输入 ）', '输入一个十六进制的数值字符串。', '输出该数值的十进制字符串。', '0xA', '10', '2018-12-24 13:54:14', '2018-12-24 13:54:14', '0xA', '10');
INSERT INTO `t_subject` VALUES ('12', '质数因子 ', ' 功能:输入一个正整数，按照从小到大的顺序输出它的所有质数的因子（如180的质数因子为2 2 3 3 5 ）\n最后一个数后面也要有空格\n\n详细描述：\n\n\n函数接口说明：\n\npublic String getResult(long ulDataInput)\n\n输入参数：\n\nlong ulDataInput：输入的正整数\n\n返回值：\n\nString ', '输入一个long型整数', '按照从小到大的顺序输出它的所有质数的因子，以空格隔开。最后一个数后面也要有空格。', '180', '2 2 3 3 5', '2018-12-24 13:57:03', '2018-12-24 13:57:03', '180', '2 2 3 3 5');
INSERT INTO `t_subject` VALUES ('13', '取近似值 ', '写出一个程序，接受一个正浮点数值，输出该数值的近似整数值。如果小数点后数值大于等于5,向上取整；小于5，则向下取整。 ', '输入一个正浮点数值', '输出该数值的近似整数值', '5.5', '6', '2018-12-24 13:57:59', '2018-12-24 13:57:59', '5.5', '6');
INSERT INTO `t_subject` VALUES ('14', '合并表记录 ', '数据表记录包含表索引和数值，请对表索引相同的记录进行合并，即将相同索引的数值进行求和运算，输出按照key值升序进行输出。 ', '先输入键值对的个数\n然后输入成对的index和value值，以空格隔开', '输出合并后的键值对（多行）', '4\n0 1\n0 2\n1 2\n3 4', '0 3\n1 2\n3 4', '2018-12-24 13:59:06', '2018-12-24 13:59:06', '4\n0 1\n0 2\n1 2\n3 4', '0 3\n1 2\n3 4');
INSERT INTO `t_subject` VALUES ('15', '提取不重复的整数 ', '输入一个int型整数，按照从右向左的阅读顺序，返回一个不含重复数字的新的整数。', '输入一个int型整数', '按照从右向左的阅读顺序，返回一个不含重复数字的新的整数', '9876673', '37689', '2018-12-24 14:00:20', '2018-12-24 14:00:20', '9876673', '37689');
INSERT INTO `t_subject` VALUES ('16', '字符个数统计', '编写一个函数，计算字符串中含有的不同字符的个数。字符在ACSII码范围内(0~127)。不在范围内的不作统计。', '输入N个字符，字符在ACSII码范围内。', '输出范围在(0~127)字符的个数。', 'abc', '3', '2018-12-24 14:02:24', '2018-12-24 14:02:24', 'abc', '3');

CREATE TABLE `map_location_info` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `lon` varchar(20) NOT NULL COMMENT '经度',
  `lat` varchar(20) NOT NULL COMMENT '纬度',
  `city` varchar(23) NOT NULL COMMENT '城市',
  `soak` varchar(11) NOT NULL COMMENT '浸水 1是 0否',
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE `map_location_log` (
  `location_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `lon` varchar(20) NOT NULL COMMENT '经度',
  `lat` varchar(20) NOT NULL COMMENT '纬度',
  `city` varchar(23) NOT NULL COMMENT '城市',
  `log_datetime` datetime NOT NULL,
  PRIMARY KEY (`location_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
