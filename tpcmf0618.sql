/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.26 : Database - thinkcmf
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`thinkcmf` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `thinkcmf`;

/*Table structure for table `qm_activity` */

DROP TABLE IF EXISTS `qm_activity`;

CREATE TABLE `qm_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '运营活动ID',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型：1=banner 2=常驻入口',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '活动名称',
  `logo` varchar(125) NOT NULL DEFAULT '' COMMENT '活动LOGO',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '活动跳转链接',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '活动开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '活动结束时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态:1=上线 2=下线',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `qm_activity` */

/*Table structure for table `qm_admin_menu` */

DROP TABLE IF EXISTS `qm_admin_menu`;

CREATE TABLE `qm_admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '菜单类型;1:有界面可访问菜单,2:无界面可访问菜单,0:只作为菜单',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;1:显示,0:不显示',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `app` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '应用名',
  `controller` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '控制器名',
  `action` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '操作名称',
  `param` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '额外参数',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parent_id` (`parent_id`),
  KEY `controller` (`controller`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8mb4 COMMENT='后台菜单表';

/*Data for the table `qm_admin_menu` */

insert  into `qm_admin_menu`(`id`,`parent_id`,`type`,`status`,`list_order`,`app`,`controller`,`action`,`param`,`name`,`icon`,`remark`) values (1,0,0,0,20,'admin','Plugin','default','','插件中心','cloud','插件中心'),(2,1,1,1,10000,'admin','Hook','index','','钩子管理','','钩子管理'),(3,2,1,0,10000,'admin','Hook','plugins','','钩子插件管理','','钩子插件管理'),(4,2,2,0,10000,'admin','Hook','pluginListOrder','','钩子插件排序','','钩子插件排序'),(5,2,1,0,10000,'admin','Hook','sync','','同步钩子','','同步钩子'),(6,0,0,0,0,'admin','Setting','default','','设置','cogs','系统设置入口'),(7,6,1,1,50,'admin','Link','index','','友情链接','','友情链接管理'),(8,7,1,0,10000,'admin','Link','add','','添加友情链接','','添加友情链接'),(9,7,2,0,10000,'admin','Link','addPost','','添加友情链接提交保存','','添加友情链接提交保存'),(10,7,1,0,10000,'admin','Link','edit','','编辑友情链接','','编辑友情链接'),(11,7,2,0,10000,'admin','Link','editPost','','编辑友情链接提交保存','','编辑友情链接提交保存'),(12,7,2,0,10000,'admin','Link','delete','','删除友情链接','','删除友情链接'),(13,7,2,0,10000,'admin','Link','listOrder','','友情链接排序','','友情链接排序'),(14,7,2,0,10000,'admin','Link','toggle','','友情链接显示隐藏','','友情链接显示隐藏'),(15,6,1,1,10,'admin','Mailer','index','','邮箱配置','','邮箱配置'),(16,15,2,0,10000,'admin','Mailer','indexPost','','邮箱配置提交保存','','邮箱配置提交保存'),(17,15,1,0,10000,'admin','Mailer','template','','邮件模板','','邮件模板'),(18,15,2,0,10000,'admin','Mailer','templatePost','','邮件模板提交','','邮件模板提交'),(19,15,1,0,10000,'admin','Mailer','test','','邮件发送测试','','邮件发送测试'),(20,6,1,0,10000,'admin','Menu','index','','后台菜单','','后台菜单管理'),(21,20,1,0,10000,'admin','Menu','lists','','所有菜单','','后台所有菜单列表'),(22,20,1,0,10000,'admin','Menu','add','','后台菜单添加','','后台菜单添加'),(23,20,2,0,10000,'admin','Menu','addPost','','后台菜单添加提交保存','','后台菜单添加提交保存'),(24,20,1,0,10000,'admin','Menu','edit','','后台菜单编辑','','后台菜单编辑'),(25,20,2,0,10000,'admin','Menu','editPost','','后台菜单编辑提交保存','','后台菜单编辑提交保存'),(26,20,2,0,10000,'admin','Menu','delete','','后台菜单删除','','后台菜单删除'),(27,20,2,0,10000,'admin','Menu','listOrder','','后台菜单排序','','后台菜单排序'),(28,20,1,0,10000,'admin','Menu','getActions','','导入新后台菜单','','导入新后台菜单'),(29,6,1,1,30,'admin','Nav','index','','导航管理','','导航管理'),(30,29,1,0,10000,'admin','Nav','add','','添加导航','','添加导航'),(31,29,2,0,10000,'admin','Nav','addPost','','添加导航提交保存','','添加导航提交保存'),(32,29,1,0,10000,'admin','Nav','edit','','编辑导航','','编辑导航'),(33,29,2,0,10000,'admin','Nav','editPost','','编辑导航提交保存','','编辑导航提交保存'),(34,29,2,0,10000,'admin','Nav','delete','','删除导航','','删除导航'),(35,29,1,0,10000,'admin','NavMenu','index','','导航菜单','','导航菜单'),(36,35,1,0,10000,'admin','NavMenu','add','','添加导航菜单','','添加导航菜单'),(37,35,2,0,10000,'admin','NavMenu','addPost','','添加导航菜单提交保存','','添加导航菜单提交保存'),(38,35,1,0,10000,'admin','NavMenu','edit','','编辑导航菜单','','编辑导航菜单'),(39,35,2,0,10000,'admin','NavMenu','editPost','','编辑导航菜单提交保存','','编辑导航菜单提交保存'),(40,35,2,0,10000,'admin','NavMenu','delete','','删除导航菜单','','删除导航菜单'),(41,35,2,0,10000,'admin','NavMenu','listOrder','','导航菜单排序','','导航菜单排序'),(42,1,1,1,10000,'admin','Plugin','index','','插件列表','','插件列表'),(43,42,2,0,10000,'admin','Plugin','toggle','','插件启用禁用','','插件启用禁用'),(44,42,1,0,10000,'admin','Plugin','setting','','插件设置','','插件设置'),(45,42,2,0,10000,'admin','Plugin','settingPost','','插件设置提交','','插件设置提交'),(46,42,2,0,10000,'admin','Plugin','install','','插件安装','','插件安装'),(47,42,2,0,10000,'admin','Plugin','update','','插件更新','','插件更新'),(48,42,2,0,10000,'admin','Plugin','uninstall','','卸载插件','','卸载插件'),(49,110,0,1,10000,'admin','User','default','','管理组','','管理组'),(50,49,1,1,10000,'admin','Rbac','index','','角色管理','','角色管理'),(51,50,1,0,10000,'admin','Rbac','roleAdd','','添加角色','','添加角色'),(52,50,2,0,10000,'admin','Rbac','roleAddPost','','添加角色提交','','添加角色提交'),(53,50,1,0,10000,'admin','Rbac','roleEdit','','编辑角色','','编辑角色'),(54,50,2,0,10000,'admin','Rbac','roleEditPost','','编辑角色提交','','编辑角色提交'),(55,50,2,0,10000,'admin','Rbac','roleDelete','','删除角色','','删除角色'),(56,50,1,0,10000,'admin','Rbac','authorize','','设置角色权限','','设置角色权限'),(57,50,2,0,10000,'admin','Rbac','authorizePost','','角色授权提交','','角色授权提交'),(58,0,1,0,10000,'admin','RecycleBin','index','','回收站','','回收站'),(59,58,2,0,10000,'admin','RecycleBin','restore','','回收站还原','','回收站还原'),(60,58,2,0,10000,'admin','RecycleBin','delete','','回收站彻底删除','','回收站彻底删除'),(61,6,1,1,10000,'admin','Route','index','','URL美化','','URL规则管理'),(62,61,1,0,10000,'admin','Route','add','','添加路由规则','','添加路由规则'),(63,61,2,0,10000,'admin','Route','addPost','','添加路由规则提交','','添加路由规则提交'),(64,61,1,0,10000,'admin','Route','edit','','路由规则编辑','','路由规则编辑'),(65,61,2,0,10000,'admin','Route','editPost','','路由规则编辑提交','','路由规则编辑提交'),(66,61,2,0,10000,'admin','Route','delete','','路由规则删除','','路由规则删除'),(67,61,2,0,10000,'admin','Route','ban','','路由规则禁用','','路由规则禁用'),(68,61,2,0,10000,'admin','Route','open','','路由规则启用','','路由规则启用'),(69,61,2,0,10000,'admin','Route','listOrder','','路由规则排序','','路由规则排序'),(70,61,1,0,10000,'admin','Route','select','','选择URL','','选择URL'),(71,6,1,0,0,'admin','Setting','site','','网站信息','','网站信息'),(72,71,2,0,10000,'admin','Setting','sitePost','','网站信息设置提交','','网站信息设置提交'),(73,6,1,0,10000,'admin','Setting','password','','密码修改','','密码修改'),(74,73,2,0,10000,'admin','Setting','passwordPost','','密码修改提交','','密码修改提交'),(75,6,1,1,10000,'admin','Setting','upload','','上传设置','','上传设置'),(76,75,2,0,10000,'admin','Setting','uploadPost','','上传设置提交','','上传设置提交'),(77,6,1,0,10000,'admin','Setting','clearCache','','清除缓存','','清除缓存'),(78,6,1,1,40,'admin','Slide','index','','幻灯片管理','','幻灯片管理'),(79,78,1,0,10000,'admin','Slide','add','','添加幻灯片','','添加幻灯片'),(80,78,2,0,10000,'admin','Slide','addPost','','添加幻灯片提交','','添加幻灯片提交'),(81,78,1,0,10000,'admin','Slide','edit','','编辑幻灯片','','编辑幻灯片'),(82,78,2,0,10000,'admin','Slide','editPost','','编辑幻灯片提交','','编辑幻灯片提交'),(83,78,2,0,10000,'admin','Slide','delete','','删除幻灯片','','删除幻灯片'),(84,78,1,0,10000,'admin','SlideItem','index','','幻灯片页面列表','','幻灯片页面列表'),(85,84,1,0,10000,'admin','SlideItem','add','','幻灯片页面添加','','幻灯片页面添加'),(86,84,2,0,10000,'admin','SlideItem','addPost','','幻灯片页面添加提交','','幻灯片页面添加提交'),(87,84,1,0,10000,'admin','SlideItem','edit','','幻灯片页面编辑','','幻灯片页面编辑'),(88,84,2,0,10000,'admin','SlideItem','editPost','','幻灯片页面编辑提交','','幻灯片页面编辑提交'),(89,84,2,0,10000,'admin','SlideItem','delete','','幻灯片页面删除','','幻灯片页面删除'),(90,84,2,0,10000,'admin','SlideItem','ban','','幻灯片页面隐藏','','幻灯片页面隐藏'),(91,84,2,0,10000,'admin','SlideItem','cancelBan','','幻灯片页面显示','','幻灯片页面显示'),(92,84,2,0,10000,'admin','SlideItem','listOrder','','幻灯片页面排序','','幻灯片页面排序'),(93,6,1,1,10000,'admin','Storage','index','','文件存储','','文件存储'),(94,93,2,0,10000,'admin','Storage','settingPost','','文件存储设置提交','','文件存储设置提交'),(95,6,1,1,20,'admin','Theme','index','','模板管理','','模板管理'),(96,95,1,0,10000,'admin','Theme','install','','安装模板','','安装模板'),(97,95,2,0,10000,'admin','Theme','uninstall','','卸载模板','','卸载模板'),(98,95,2,0,10000,'admin','Theme','installTheme','','模板安装','','模板安装'),(99,95,2,0,10000,'admin','Theme','update','','模板更新','','模板更新'),(100,95,2,0,10000,'admin','Theme','active','','启用模板','','启用模板'),(101,95,1,0,10000,'admin','Theme','files','','模板文件列表','','启用模板'),(102,95,1,0,10000,'admin','Theme','fileSetting','','模板文件设置','','模板文件设置'),(103,95,1,0,10000,'admin','Theme','fileArrayData','','模板文件数组数据列表','','模板文件数组数据列表'),(104,95,2,0,10000,'admin','Theme','fileArrayDataEdit','','模板文件数组数据添加编辑','','模板文件数组数据添加编辑'),(105,95,2,0,10000,'admin','Theme','fileArrayDataEditPost','','模板文件数组数据添加编辑提交保存','','模板文件数组数据添加编辑提交保存'),(106,95,2,0,10000,'admin','Theme','fileArrayDataDelete','','模板文件数组数据删除','','模板文件数组数据删除'),(107,95,2,0,10000,'admin','Theme','settingPost','','模板文件编辑提交保存','','模板文件编辑提交保存'),(108,95,1,0,10000,'admin','Theme','dataSource','','模板文件设置数据源','','模板文件设置数据源'),(109,95,1,0,10000,'admin','Theme','design','','模板设计','','模板设计'),(110,0,0,1,10,'user','AdminIndex','default','','用户管理','group','用户管理'),(111,49,1,1,10000,'admin','User','index','','管理员','','管理员管理'),(112,111,1,0,10000,'admin','User','add','','管理员添加','','管理员添加'),(113,111,2,0,10000,'admin','User','addPost','','管理员添加提交','','管理员添加提交'),(114,111,1,0,10000,'admin','User','edit','','管理员编辑','','管理员编辑'),(115,111,2,0,10000,'admin','User','editPost','','管理员编辑提交','','管理员编辑提交'),(116,111,1,0,10000,'admin','User','userInfo','','个人信息','','管理员个人信息修改'),(117,111,2,0,10000,'admin','User','userInfoPost','','管理员个人信息修改提交','','管理员个人信息修改提交'),(118,111,2,0,10000,'admin','User','delete','','管理员删除','','管理员删除'),(119,111,2,0,10000,'admin','User','ban','','停用管理员','','停用管理员'),(120,111,2,0,10000,'admin','User','cancelBan','','启用管理员','','启用管理员'),(121,0,1,0,10000,'user','AdminAsset','index','','资源管理','file','资源管理列表'),(122,121,2,0,10000,'user','AdminAsset','delete','','删除文件','','删除文件'),(123,110,0,1,10000,'user','AdminIndex','default1','','用户组','','用户组'),(124,123,1,1,10000,'user','AdminIndex','index','','系统管理员列表','','本站用户'),(125,124,2,0,10000,'user','AdminIndex','ban','','本站用户拉黑','','本站用户拉黑'),(126,124,2,0,10000,'user','AdminIndex','cancelBan','','本站用户启用','','本站用户启用'),(127,123,1,1,10000,'user','AdminOauth','index','','用户列表','','第三方用户'),(128,127,2,0,10000,'user','AdminOauth','delete','','删除第三方用户绑定','','删除第三方用户绑定'),(129,6,1,1,10000,'user','AdminUserAction','index','','用户操作管理','','用户操作管理'),(130,129,1,0,10000,'user','AdminUserAction','edit','','编辑用户操作','','编辑用户操作'),(131,129,2,0,10000,'user','AdminUserAction','editPost','','编辑用户操作提交','','编辑用户操作提交'),(132,129,1,0,10000,'user','AdminUserAction','sync','','同步用户操作','','同步用户操作'),(162,0,0,0,0,'plugin/Demo','AdminIndex','default','','演示插件','dashboard','演示插件入口'),(163,162,1,1,10000,'plugin/Demo','AdminIndex','index','','演示插件用户列表','','演示插件用户列表'),(164,163,1,0,10000,'plugin/Demo','AdminIndex','setting','','演示插件设置','','演示插件设置'),(165,110,1,1,10000,'admin','Member','index','','会员列表','',''),(166,0,0,1,10000,'admin','Course','default','','课程管理','',''),(167,166,1,1,10000,'admin','Course','index','','课程列表','',''),(168,166,1,1,10000,'admin','Order','index','','订单管理','',''),(169,166,1,1,10000,'admin','Subject','index','','学科列表','',''),(170,166,1,1,10000,'admin','Supplier','index','','供应商管理','',''),(171,166,1,1,10000,'admin','Age','index','','年龄段管理','','');

/*Table structure for table `qm_age_stage` */

DROP TABLE IF EXISTS `qm_age_stage`;

CREATE TABLE `qm_age_stage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '年龄段管理',
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '年龄段名称',
  `remark` text COLLATE utf8_unicode_ci COMMENT '备注',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qm_age_stage` */

insert  into `qm_age_stage`(`id`,`name`,`remark`,`add_time`) values (1,'0-3岁',NULL,'2020-06-15 14:19:56'),(2,'4-6岁',NULL,'2020-06-15 14:20:03'),(3,'7-12岁',NULL,'2020-06-15 14:20:08'),(4,'81-161岁','1\r\n2\r\n3\r\n3\r\n3\r\n3\r\n','2020-06-15 14:20:18');

/*Table structure for table `qm_article` */

DROP TABLE IF EXISTS `qm_article`;

CREATE TABLE `qm_article` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `type_id` int(11) NOT NULL COMMENT '文章类型',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '文章标题',
  `content` text NOT NULL COMMENT '文章内容',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序（从小到大）',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1=上线 2=下线',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`article_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `qm_article` */

/*Table structure for table `qm_article_type` */

DROP TABLE IF EXISTS `qm_article_type`;

CREATE TABLE `qm_article_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章类型ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '文章类型名称',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `qm_article_type` */

/*Table structure for table `qm_asset` */

DROP TABLE IF EXISTS `qm_asset`;

CREATE TABLE `qm_asset` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小,单位B',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `file_key` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `file_path` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件路径,相对于upload目录,可以为url',
  `file_md5` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `more` text COMMENT '其它详细信息,JSON格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

/*Data for the table `qm_asset` */

insert  into `qm_asset`(`id`,`user_id`,`file_size`,`create_time`,`status`,`download_times`,`file_key`,`filename`,`file_path`,`file_md5`,`file_sha1`,`suffix`,`more`) values (1,1,563,1592377335,1,0,'ec28037efd567aea9df807e29289a178a82c52257569f124aba57adffe1a5be0','navNewsIcon.png','default/20200617/c55c81b6db656f6e1ad8d376dd97b514.png','ec28037efd567aea9df807e29289a178','f92a624ca953bc157899f301dbe76d5a99a6e7a3','png',NULL),(2,1,4281,1592381710,1,0,'5e0a8f0510322da6ad9a8dd441d8e211ae9d7e246920b0a465fdb60cd35055eb','headImg_default - 副本.png','default/20200617/919ba64b750192e09a85e900a5aa68e6.png','5e0a8f0510322da6ad9a8dd441d8e211','40708c7a9f58d755c20a81ccb9999d55fe602a71','png',NULL),(3,1,4388,1592385789,1,0,'2a98b285a55136d25c480b2e96fde86a4a6675938016575173a8bf267cd2d440','indexLogo.png','default/20200617/7f20f70bf91aa270979d4aaf02736261.png','2a98b285a55136d25c480b2e96fde86a','7e9f72d595acf2835c57634ddbdd780031876d98','png',NULL),(4,1,817,1592386595,1,0,'cb2aaf8c29ce25fc8fc651fdfe197e101612f0c9b901b81a5f9a87bceddd52cc','navIndexIcon.png','default/20200617/c6d266a79a590ebf6af776ee29e4e425.png','cb2aaf8c29ce25fc8fc651fdfe197e10','5c51191beb0f4bf92ccd6affdb97f90b15547581','png',NULL),(5,1,215,1592386595,1,0,'4cede9350d94fa510906290e8c8468d340bc5b860229643f3ef89bebe5e1e3a6','navListIcon.png','default/20200617/1825706fd4b777fd697c529e10b2f529.png','4cede9350d94fa510906290e8c8468d3','1034962d5d9f0a65e61ce6ca6417bed5c04dd8a3','png',NULL);

/*Table structure for table `qm_auth_access` */

DROP TABLE IF EXISTS `qm_auth_access`;

CREATE TABLE `qm_auth_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类,请加应用前缀,如admin_',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限授权表';

/*Data for the table `qm_auth_access` */

/*Table structure for table `qm_auth_rule` */

DROP TABLE IF EXISTS `qm_auth_rule`;

CREATE TABLE `qm_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `app` varchar(40) NOT NULL DEFAULT '' COMMENT '规则所属app',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) NOT NULL DEFAULT '' COMMENT '额外url参数',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则描述',
  `condition` varchar(200) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `module` (`app`,`status`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COMMENT='权限规则表';

/*Data for the table `qm_auth_rule` */

insert  into `qm_auth_rule`(`id`,`status`,`app`,`type`,`name`,`param`,`title`,`condition`) values (1,1,'admin','admin_url','admin/Hook/index','','钩子管理',''),(2,1,'admin','admin_url','admin/Hook/plugins','','钩子插件管理',''),(3,1,'admin','admin_url','admin/Hook/pluginListOrder','','钩子插件排序',''),(4,1,'admin','admin_url','admin/Hook/sync','','同步钩子',''),(5,1,'admin','admin_url','admin/Link/index','','友情链接',''),(6,1,'admin','admin_url','admin/Link/add','','添加友情链接',''),(7,1,'admin','admin_url','admin/Link/addPost','','添加友情链接提交保存',''),(8,1,'admin','admin_url','admin/Link/edit','','编辑友情链接',''),(9,1,'admin','admin_url','admin/Link/editPost','','编辑友情链接提交保存',''),(10,1,'admin','admin_url','admin/Link/delete','','删除友情链接',''),(11,1,'admin','admin_url','admin/Link/listOrder','','友情链接排序',''),(12,1,'admin','admin_url','admin/Link/toggle','','友情链接显示隐藏',''),(13,1,'admin','admin_url','admin/Mailer/index','','邮箱配置',''),(14,1,'admin','admin_url','admin/Mailer/indexPost','','邮箱配置提交保存',''),(15,1,'admin','admin_url','admin/Mailer/template','','邮件模板',''),(16,1,'admin','admin_url','admin/Mailer/templatePost','','邮件模板提交',''),(17,1,'admin','admin_url','admin/Mailer/test','','邮件发送测试',''),(18,1,'admin','admin_url','admin/Menu/index','','后台菜单',''),(19,1,'admin','admin_url','admin/Menu/lists','','所有菜单',''),(20,1,'admin','admin_url','admin/Menu/add','','后台菜单添加',''),(21,1,'admin','admin_url','admin/Menu/addPost','','后台菜单添加提交保存',''),(22,1,'admin','admin_url','admin/Menu/edit','','后台菜单编辑',''),(23,1,'admin','admin_url','admin/Menu/editPost','','后台菜单编辑提交保存',''),(24,1,'admin','admin_url','admin/Menu/delete','','后台菜单删除',''),(25,1,'admin','admin_url','admin/Menu/listOrder','','后台菜单排序',''),(26,1,'admin','admin_url','admin/Menu/getActions','','导入新后台菜单',''),(27,1,'admin','admin_url','admin/Nav/index','','导航管理',''),(28,1,'admin','admin_url','admin/Nav/add','','添加导航',''),(29,1,'admin','admin_url','admin/Nav/addPost','','添加导航提交保存',''),(30,1,'admin','admin_url','admin/Nav/edit','','编辑导航',''),(31,1,'admin','admin_url','admin/Nav/editPost','','编辑导航提交保存',''),(32,1,'admin','admin_url','admin/Nav/delete','','删除导航',''),(33,1,'admin','admin_url','admin/NavMenu/index','','导航菜单',''),(34,1,'admin','admin_url','admin/NavMenu/add','','添加导航菜单',''),(35,1,'admin','admin_url','admin/NavMenu/addPost','','添加导航菜单提交保存',''),(36,1,'admin','admin_url','admin/NavMenu/edit','','编辑导航菜单',''),(37,1,'admin','admin_url','admin/NavMenu/editPost','','编辑导航菜单提交保存',''),(38,1,'admin','admin_url','admin/NavMenu/delete','','删除导航菜单',''),(39,1,'admin','admin_url','admin/NavMenu/listOrder','','导航菜单排序',''),(40,1,'admin','admin_url','admin/Plugin/default','','插件中心',''),(41,1,'admin','admin_url','admin/Plugin/index','','插件列表',''),(42,1,'admin','admin_url','admin/Plugin/toggle','','插件启用禁用',''),(43,1,'admin','admin_url','admin/Plugin/setting','','插件设置',''),(44,1,'admin','admin_url','admin/Plugin/settingPost','','插件设置提交',''),(45,1,'admin','admin_url','admin/Plugin/install','','插件安装',''),(46,1,'admin','admin_url','admin/Plugin/update','','插件更新',''),(47,1,'admin','admin_url','admin/Plugin/uninstall','','卸载插件',''),(48,1,'admin','admin_url','admin/Rbac/index','','角色管理',''),(49,1,'admin','admin_url','admin/Rbac/roleAdd','','添加角色',''),(50,1,'admin','admin_url','admin/Rbac/roleAddPost','','添加角色提交',''),(51,1,'admin','admin_url','admin/Rbac/roleEdit','','编辑角色',''),(52,1,'admin','admin_url','admin/Rbac/roleEditPost','','编辑角色提交',''),(53,1,'admin','admin_url','admin/Rbac/roleDelete','','删除角色',''),(54,1,'admin','admin_url','admin/Rbac/authorize','','设置角色权限',''),(55,1,'admin','admin_url','admin/Rbac/authorizePost','','角色授权提交',''),(56,1,'admin','admin_url','admin/RecycleBin/index','','回收站',''),(57,1,'admin','admin_url','admin/RecycleBin/restore','','回收站还原',''),(58,1,'admin','admin_url','admin/RecycleBin/delete','','回收站彻底删除',''),(59,1,'admin','admin_url','admin/Route/index','','URL美化',''),(60,1,'admin','admin_url','admin/Route/add','','添加路由规则',''),(61,1,'admin','admin_url','admin/Route/addPost','','添加路由规则提交',''),(62,1,'admin','admin_url','admin/Route/edit','','路由规则编辑',''),(63,1,'admin','admin_url','admin/Route/editPost','','路由规则编辑提交',''),(64,1,'admin','admin_url','admin/Route/delete','','路由规则删除',''),(65,1,'admin','admin_url','admin/Route/ban','','路由规则禁用',''),(66,1,'admin','admin_url','admin/Route/open','','路由规则启用',''),(67,1,'admin','admin_url','admin/Route/listOrder','','路由规则排序',''),(68,1,'admin','admin_url','admin/Route/select','','选择URL',''),(69,1,'admin','admin_url','admin/Setting/default','','设置',''),(70,1,'admin','admin_url','admin/Setting/site','','网站信息',''),(71,1,'admin','admin_url','admin/Setting/sitePost','','网站信息设置提交',''),(72,1,'admin','admin_url','admin/Setting/password','','密码修改',''),(73,1,'admin','admin_url','admin/Setting/passwordPost','','密码修改提交',''),(74,1,'admin','admin_url','admin/Setting/upload','','上传设置',''),(75,1,'admin','admin_url','admin/Setting/uploadPost','','上传设置提交',''),(76,1,'admin','admin_url','admin/Setting/clearCache','','清除缓存',''),(77,1,'admin','admin_url','admin/Slide/index','','幻灯片管理',''),(78,1,'admin','admin_url','admin/Slide/add','','添加幻灯片',''),(79,1,'admin','admin_url','admin/Slide/addPost','','添加幻灯片提交',''),(80,1,'admin','admin_url','admin/Slide/edit','','编辑幻灯片',''),(81,1,'admin','admin_url','admin/Slide/editPost','','编辑幻灯片提交',''),(82,1,'admin','admin_url','admin/Slide/delete','','删除幻灯片',''),(83,1,'admin','admin_url','admin/SlideItem/index','','幻灯片页面列表',''),(84,1,'admin','admin_url','admin/SlideItem/add','','幻灯片页面添加',''),(85,1,'admin','admin_url','admin/SlideItem/addPost','','幻灯片页面添加提交',''),(86,1,'admin','admin_url','admin/SlideItem/edit','','幻灯片页面编辑',''),(87,1,'admin','admin_url','admin/SlideItem/editPost','','幻灯片页面编辑提交',''),(88,1,'admin','admin_url','admin/SlideItem/delete','','幻灯片页面删除',''),(89,1,'admin','admin_url','admin/SlideItem/ban','','幻灯片页面隐藏',''),(90,1,'admin','admin_url','admin/SlideItem/cancelBan','','幻灯片页面显示',''),(91,1,'admin','admin_url','admin/SlideItem/listOrder','','幻灯片页面排序',''),(92,1,'admin','admin_url','admin/Storage/index','','文件存储',''),(93,1,'admin','admin_url','admin/Storage/settingPost','','文件存储设置提交',''),(94,1,'admin','admin_url','admin/Theme/index','','模板管理',''),(95,1,'admin','admin_url','admin/Theme/install','','安装模板',''),(96,1,'admin','admin_url','admin/Theme/uninstall','','卸载模板',''),(97,1,'admin','admin_url','admin/Theme/installTheme','','模板安装',''),(98,1,'admin','admin_url','admin/Theme/update','','模板更新',''),(99,1,'admin','admin_url','admin/Theme/active','','启用模板',''),(100,1,'admin','admin_url','admin/Theme/files','','模板文件列表',''),(101,1,'admin','admin_url','admin/Theme/fileSetting','','模板文件设置',''),(102,1,'admin','admin_url','admin/Theme/fileArrayData','','模板文件数组数据列表',''),(103,1,'admin','admin_url','admin/Theme/fileArrayDataEdit','','模板文件数组数据添加编辑',''),(104,1,'admin','admin_url','admin/Theme/fileArrayDataEditPost','','模板文件数组数据添加编辑提交保存',''),(105,1,'admin','admin_url','admin/Theme/fileArrayDataDelete','','模板文件数组数据删除',''),(106,1,'admin','admin_url','admin/Theme/settingPost','','模板文件编辑提交保存',''),(107,1,'admin','admin_url','admin/Theme/dataSource','','模板文件设置数据源',''),(108,1,'admin','admin_url','admin/Theme/design','','模板设计',''),(109,1,'admin','admin_url','admin/User/default','','管理组',''),(110,1,'admin','admin_url','admin/User/index','','管理员',''),(111,1,'admin','admin_url','admin/User/add','','管理员添加',''),(112,1,'admin','admin_url','admin/User/addPost','','管理员添加提交',''),(113,1,'admin','admin_url','admin/User/edit','','管理员编辑',''),(114,1,'admin','admin_url','admin/User/editPost','','管理员编辑提交',''),(115,1,'admin','admin_url','admin/User/userInfo','','个人信息',''),(116,1,'admin','admin_url','admin/User/userInfoPost','','管理员个人信息修改提交',''),(117,1,'admin','admin_url','admin/User/delete','','管理员删除',''),(118,1,'admin','admin_url','admin/User/ban','','停用管理员',''),(119,1,'admin','admin_url','admin/User/cancelBan','','启用管理员',''),(120,1,'user','admin_url','user/AdminAsset/index','','资源管理',''),(121,1,'user','admin_url','user/AdminAsset/delete','','删除文件',''),(122,1,'user','admin_url','user/AdminIndex/default','','用户管理',''),(123,1,'user','admin_url','user/AdminIndex/default1','','用户组',''),(124,1,'user','admin_url','user/AdminIndex/index','','系统管理员列表',''),(125,1,'user','admin_url','user/AdminIndex/ban','','本站用户拉黑',''),(126,1,'user','admin_url','user/AdminIndex/cancelBan','','本站用户启用',''),(127,1,'user','admin_url','user/AdminOauth/index','','用户列表',''),(128,1,'user','admin_url','user/AdminOauth/delete','','删除第三方用户绑定',''),(129,1,'user','admin_url','user/AdminUserAction/index','','用户操作管理',''),(130,1,'user','admin_url','user/AdminUserAction/edit','','编辑用户操作',''),(131,1,'user','admin_url','user/AdminUserAction/editPost','','编辑用户操作提交',''),(132,1,'user','admin_url','user/AdminUserAction/sync','','同步用户操作',''),(162,1,'plugin/Demo','admin_url','plugin/Demo/AdminIndex/default','','演示插件',''),(163,1,'plugin/Demo','plugin_url','plugin/Demo/AdminIndex/index','','演示插件用户列表',''),(164,1,'plugin/Demo','plugin_url','plugin/Demo/AdminIndex/setting','','演示插件设置',''),(165,1,'admin','admin_url','admin/Member/index','','会员列表',''),(166,1,'admin','admin_url','admin/Course/default','','课程管理',''),(167,1,'admin','admin_url','admin/Course/index','','课程列表',''),(168,1,'admin','admin_url','admin/Course/add','','课程上下架',''),(169,1,'admin','admin_url','admin/Order/index','','订单管理',''),(170,1,'admin','admin_url','admin/Subject/index','','学科列表',''),(171,1,'admin','admin_url','admin/Supplier/index','','供应商管理',''),(172,1,'admin','admin_url','admin/Age/index','','年龄段管理','');

/*Table structure for table `qm_comment` */

DROP TABLE IF EXISTS `qm_comment`;

CREATE TABLE `qm_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `dislike_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '不喜欢数',
  `floor` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼层数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:已审核,0:未审核',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '评论内容所在表，不带表前缀',
  `full_name` varchar(50) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  `url` text COMMENT '原文地址',
  `content` text CHARACTER SET utf8mb4 COMMENT '评论内容',
  `more` text CHARACTER SET utf8mb4 COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `table_id_status` (`table_name`,`object_id`,`status`),
  KEY `object_id` (`object_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

/*Data for the table `qm_comment` */

/*Table structure for table `qm_course` */

DROP TABLE IF EXISTS `qm_course`;

CREATE TABLE `qm_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '课程短标题',
  `long_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '课程标题',
  `sell_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '售价',
  `original_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '原价',
  `commission` int(11) NOT NULL DEFAULT '0' COMMENT '佣金比例:%',
  `inventory_number` int(11) NOT NULL DEFAULT '0' COMMENT '课程总量',
  `basic_number` int(11) NOT NULL DEFAULT '0' COMMENT '销量基数',
  `sales_number` int(11) NOT NULL DEFAULT '0' COMMENT '销量',
  `explain` text COLLATE utf8_unicode_ci COMMENT '课程说明',
  `attend_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '上课方式：1=手机 2=兑换码',
  `if_entity` tinyint(4) DEFAULT '1' COMMENT '是否实物：1=无 2=有',
  `activate_method` text COLLATE utf8_unicode_ci COMMENT '激活方法',
  `activate_time` text COLLATE utf8_unicode_ci COMMENT '激活时间',
  `refund` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '退货政策',
  `if_seckill` tinyint(4) DEFAULT '1' COMMENT '开启秒杀：1=不开启 2=开启',
  `tj_logo` varchar(128) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '课程推荐图',
  `zt_logo` text COLLATE utf8_unicode_ci COMMENT '课程主图{1.png, 2.png}',
  `xt_logo` text COLLATE utf8_unicode_ci COMMENT '课程小图',
  `js_logo` text COLLATE utf8_unicode_ci COMMENT '课程介绍图{1.png, 2.png}',
  `buy_notice` text COLLATE utf8_unicode_ci COMMENT '买课须知',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1=上架 2=下架',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qm_course` */

insert  into `qm_course`(`id`,`supplier_id`,`title`,`long_title`,`sell_money`,`original_money`,`commission`,`inventory_number`,`basic_number`,`sales_number`,`explain`,`attend_type`,`if_entity`,`activate_method`,`activate_time`,`refund`,`if_seckill`,`tj_logo`,`zt_logo`,`xt_logo`,`js_logo`,`buy_notice`,`start_time`,`end_time`,`status`,`add_time`) values (1,1,'第一篇文章','长标题','50.00','100.00',5,100,8888,0,'课程说明， 懂法守法水电费水电费水电费水电费水电费是的都是',2,2,'1','1','1',1,'a.jpg','a.jpg,b.jpg',NULL,NULL,'&lt;p&gt;dasdasdsfs&lt;img src=\'/upload/default/20200617/c55c81b6db656f6e1ad8d376dd97b514.png\' title=\'navNewsIcon.png\' alt=\'navNewsIcon.png\'/&gt;dfdsfsd&lt;/p&gt;','2020-06-16 16:00:11','2020-06-23 16:00:14',1,'2020-06-16 15:09:19'),(2,2,'测试啊','发生的方式','111.00','222.00',10,10111,1212,0,NULL,1,1,NULL,NULL,'',1,'',NULL,NULL,NULL,'1111aa','2020-06-15 16:07:49','2020-06-20 16:07:53',1,'2020-06-16 16:07:55'),(7,2,'11111','11188888888','11.00','100.00',5,100,8888,0,'ee',1,1,'eee','e','e',1,'default/20200617/919ba64b750192e09a85e900a5aa68e6.png','default/20200617/919ba64b750192e09a85e900a5aa68e6.png,default/20200617/919ba64b750192e09a85e900a5aa68e6.png','default/20200617/7f20f70bf91aa270979d4aaf02736261.png','default/20200617/c6d266a79a590ebf6af776ee29e4e425.png,default/20200617/c6d266a79a590ebf6af776ee29e4e425.png','&lt;p&gt;fgf&lt;/p&gt;','2020-06-05 10:02:00','2020-07-02 10:02:00',1,'2020-06-18 10:02:12'),(8,2,'啊1111111111111111111111111','11111','50.00','100.00',5,100,8888,0,'1',1,1,'1','1','1',1,'default/20200617/919ba64b750192e09a85e900a5aa68e6.png','[\"default\\/20200617\\/919ba64b750192e09a85e900a5aa68e6.png\",\"default\\/20200617\\/919ba64b750192e09a85e900a5aa68e6.png\"]','default/20200617/c6d266a79a590ebf6af776ee29e4e425.png','[\"default\\/20200617\\/c6d266a79a590ebf6af776ee29e4e425.png\",\"default\\/20200617\\/c6d266a79a590ebf6af776ee29e4e425.png\"]','&lt;p&gt;111&lt;/p&gt;','2020-06-18 10:06:00','2020-07-03 10:06:00',1,'2020-06-18 10:06:59'),(5,1,'1','长标题','50.00','100.00',5,100,8888,0,'eee',1,1,'eee','eee','eee',1,'default/20200617/c55c81b6db656f6e1ad8d376dd97b514.png','default/20200617/c55c81b6db656f6e1ad8d376dd97b514.png','default/20200617/c55c81b6db656f6e1ad8d376dd97b514.png','default/20200617/c55c81b6db656f6e1ad8d376dd97b514.png','&lt;p&gt;eee&lt;/p&gt;&lt;p&gt;ee&lt;/p&gt;&lt;p&gt;&lt;img src=\'/upload/default/20200617/c6d266a79a590ebf6af776ee29e4e425.png\' title=\'navIndexIcon.png\' alt=\'navIndexIcon.png\'/&gt;&lt;/p&gt;&lt;p&gt;eee&lt;/p&gt;','2020-06-17 19:01:00','2020-06-17 19:04:00',1,'2020-06-17 19:02:01'),(9,1,'111','1','50.00','100.00',5,100,8888,0,'2',1,1,'1','1','1',1,'default/20200617/919ba64b750192e09a85e900a5aa68e6.png','[\"default\\/20200617\\/c6d266a79a590ebf6af776ee29e4e425.png\",\"default\\/20200617\\/c6d266a79a590ebf6af776ee29e4e425.png\"]','default/20200617/c6d266a79a590ebf6af776ee29e4e425.png','[\"default\\/20200617\\/7f20f70bf91aa270979d4aaf02736261.png\",\"default\\/20200617\\/7f20f70bf91aa270979d4aaf02736261.png\"]','&lt;p&gt;121&lt;/p&gt;','2020-06-18 11:14:00','2020-06-18 14:14:00',1,'2020-06-18 10:14:40');

/*Table structure for table `qm_course_age_stage` */

DROP TABLE IF EXISTS `qm_course_age_stage`;

CREATE TABLE `qm_course_age_stage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL COMMENT '课程ID',
  `age_stage_id` int(11) DEFAULT NULL COMMENT '年龄段ID',
  `add_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qm_course_age_stage` */

insert  into `qm_course_age_stage`(`id`,`course_id`,`age_stage_id`,`add_time`) values (10,1,2,'2020-06-17 18:58:57'),(9,1,1,'2020-06-17 18:58:57'),(8,3,3,'2020-06-17 18:57:19'),(7,4,1,'2020-06-17 18:40:23'),(11,5,4,'2020-06-17 19:02:01'),(12,6,4,'2020-06-18 09:45:39'),(13,7,1,'2020-06-18 10:02:12'),(14,8,1,'2020-06-18 10:06:59'),(17,9,4,'2020-06-18 11:01:27');

/*Table structure for table `qm_course_label` */

DROP TABLE IF EXISTS `qm_course_label`;

CREATE TABLE `qm_course_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL COMMENT '课程ID',
  `label` varchar(64) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '课程标签',
  `add_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qm_course_label` */

insert  into `qm_course_label`(`id`,`course_id`,`label`,`add_time`) values (26,1,'放心','2020-06-17 18:58:57'),(24,1,'开心','2020-06-17 18:58:57'),(25,1,'舒心','2020-06-17 18:58:57'),(19,4,'d','2020-06-17 18:40:23'),(18,4,'c','2020-06-17 18:40:23'),(17,4,'b','2020-06-17 18:40:23'),(16,4,'a','2020-06-17 18:40:23'),(20,3,'1','2020-06-17 18:57:19'),(21,3,'1a','2020-06-17 18:57:19'),(22,3,'a','2020-06-17 18:57:19'),(23,3,'gg','2020-06-17 18:57:19'),(27,5,'开心','2020-06-17 19:02:01'),(28,5,'舒心','2020-06-17 19:02:01'),(29,5,'放心','2020-06-17 19:02:01'),(30,6,'1','2020-06-18 09:45:39'),(31,6,'8','2020-06-18 09:45:39'),(32,6,'9','2020-06-18 09:45:39'),(33,7,'开心','2020-06-18 10:02:12'),(34,7,'舒心','2020-06-18 10:02:12'),(35,7,'放心','2020-06-18 10:02:12'),(36,8,'开心','2020-06-18 10:06:59'),(37,8,'舒心','2020-06-18 10:06:59'),(38,8,'放心','2020-06-18 10:06:59'),(47,9,'1','2020-06-18 11:01:27'),(46,9,'2','2020-06-18 11:01:27'),(45,9,'3','2020-06-18 11:01:27');

/*Table structure for table `qm_course_subject` */

DROP TABLE IF EXISTS `qm_course_subject`;

CREATE TABLE `qm_course_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL COMMENT '课程ID',
  `subject_id` int(11) NOT NULL COMMENT '学科ID',
  `add_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qm_course_subject` */

insert  into `qm_course_subject`(`id`,`course_id`,`subject_id`,`add_time`) values (28,1,2,'2020-06-17 18:58:57'),(27,1,1,'2020-06-17 18:58:57'),(26,3,6,'2020-06-17 18:57:19'),(25,3,3,'2020-06-17 18:57:19'),(24,4,7,'2020-06-17 18:40:23'),(23,4,6,'2020-06-17 18:40:23'),(22,4,5,'2020-06-17 18:40:23'),(21,4,4,'2020-06-17 18:40:23'),(20,4,3,'2020-06-17 18:40:23'),(19,4,2,'2020-06-17 18:40:23'),(18,4,1,'2020-06-17 18:40:23'),(29,5,6,'2020-06-17 19:02:01'),(30,5,7,'2020-06-17 19:02:01'),(31,6,1,'2020-06-18 09:45:39'),(32,6,7,'2020-06-18 09:45:39'),(33,7,1,'2020-06-18 10:02:12'),(34,7,7,'2020-06-18 10:02:12'),(35,8,3,'2020-06-18 10:06:59'),(36,8,4,'2020-06-18 10:06:59'),(42,9,3,'2020-06-18 11:01:27'),(41,9,2,'2020-06-18 11:01:27');

/*Table structure for table `qm_hook` */

DROP TABLE IF EXISTS `qm_hook`;

CREATE TABLE `qm_hook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '钩子类型(1:系统钩子;2:应用钩子;3:模板钩子;4:后台模板钩子)',
  `once` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否只允许一个插件运行(0:多个;1:一个)',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子',
  `app` varchar(15) NOT NULL DEFAULT '' COMMENT '应用名(只有应用钩子才用)',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子表';

/*Data for the table `qm_hook` */

insert  into `qm_hook`(`id`,`type`,`once`,`name`,`hook`,`app`,`description`) values (2,1,0,'应用开始','app_begin','cmf','应用开始'),(3,1,0,'模块初始化','module_init','cmf','模块初始化'),(4,1,0,'控制器开始','action_begin','cmf','控制器开始'),(5,1,0,'视图输出过滤','view_filter','cmf','视图输出过滤'),(6,1,0,'应用结束','app_end','cmf','应用结束'),(7,1,0,'日志write方法','log_write','cmf','日志write方法'),(8,1,0,'输出结束','response_end','cmf','输出结束'),(9,1,0,'后台控制器初始化','admin_init','cmf','后台控制器初始化'),(10,1,0,'前台控制器初始化','home_init','cmf','前台控制器初始化'),(11,1,1,'发送手机验证码','send_mobile_verification_code','cmf','发送手机验证码'),(12,3,0,'模板 body标签开始','body_start','','模板 body标签开始'),(13,3,0,'模板 head标签结束前','before_head_end','','模板 head标签结束前'),(14,3,0,'模板底部开始','footer_start','','模板底部开始'),(15,3,0,'模板底部开始之前','before_footer','','模板底部开始之前'),(16,3,0,'模板底部结束之前','before_footer_end','','模板底部结束之前'),(17,3,0,'模板 body 标签结束之前','before_body_end','','模板 body 标签结束之前'),(18,3,0,'模板左边栏开始','left_sidebar_start','','模板左边栏开始'),(19,3,0,'模板左边栏结束之前','before_left_sidebar_end','','模板左边栏结束之前'),(20,3,0,'模板右边栏开始','right_sidebar_start','','模板右边栏开始'),(21,3,0,'模板右边栏结束之前','before_right_sidebar_end','','模板右边栏结束之前'),(22,3,1,'评论区','comment','','评论区'),(23,3,1,'留言区','guestbook','','留言区'),(24,2,0,'后台首页仪表盘','admin_dashboard','admin','后台首页仪表盘'),(25,4,0,'后台模板 head标签结束前','admin_before_head_end','','后台模板 head标签结束前'),(26,4,0,'后台模板 body 标签结束之前','admin_before_body_end','','后台模板 body 标签结束之前'),(27,2,0,'后台登录页面','admin_login','admin','后台登录页面'),(28,1,1,'前台模板切换','switch_theme','cmf','前台模板切换'),(29,3,0,'主要内容之后','after_content','','主要内容之后'),(32,2,1,'获取上传界面','fetch_upload_view','user','获取上传界面'),(33,3,0,'主要内容之前','before_content','cmf','主要内容之前'),(34,1,0,'日志写入完成','log_write_done','cmf','日志写入完成'),(35,1,1,'后台模板切换','switch_admin_theme','cmf','后台模板切换'),(36,1,1,'验证码图片','captcha_image','cmf','验证码图片'),(37,2,1,'后台模板设计界面','admin_theme_design_view','admin','后台模板设计界面'),(38,2,1,'后台设置网站信息界面','admin_setting_site_view','admin','后台设置网站信息界面'),(39,2,1,'后台清除缓存界面','admin_setting_clear_cache_view','admin','后台清除缓存界面'),(40,2,1,'后台导航管理界面','admin_nav_index_view','admin','后台导航管理界面'),(41,2,1,'后台友情链接管理界面','admin_link_index_view','admin','后台友情链接管理界面'),(42,2,1,'后台幻灯片管理界面','admin_slide_index_view','admin','后台幻灯片管理界面'),(43,2,1,'后台管理员列表界面','admin_user_index_view','admin','后台管理员列表界面'),(44,2,1,'后台角色管理界面','admin_rbac_index_view','admin','后台角色管理界面'),(49,2,1,'用户管理本站用户列表界面','user_admin_index_view','user','用户管理本站用户列表界面'),(50,2,1,'资源管理列表界面','user_admin_asset_index_view','user','资源管理列表界面'),(51,2,1,'用户管理第三方用户列表界面','user_admin_oauth_index_view','user','用户管理第三方用户列表界面'),(52,2,1,'后台首页界面','admin_index_index_view','admin','后台首页界面'),(53,2,1,'后台回收站界面','admin_recycle_bin_index_view','admin','后台回收站界面'),(54,2,1,'后台菜单管理界面','admin_menu_index_view','admin','后台菜单管理界面'),(55,2,1,'后台自定义登录是否开启钩子','admin_custom_login_open','admin','后台自定义登录是否开启钩子'),(64,2,1,'后台幻灯片页面列表界面','admin_slide_item_index_view','admin','后台幻灯片页面列表界面'),(65,2,1,'后台幻灯片页面添加界面','admin_slide_item_add_view','admin','后台幻灯片页面添加界面'),(66,2,1,'后台幻灯片页面编辑界面','admin_slide_item_edit_view','admin','后台幻灯片页面编辑界面'),(67,2,1,'后台管理员添加界面','admin_user_add_view','admin','后台管理员添加界面'),(68,2,1,'后台管理员编辑界面','admin_user_edit_view','admin','后台管理员编辑界面'),(69,2,1,'后台角色添加界面','admin_rbac_role_add_view','admin','后台角色添加界面'),(70,2,1,'后台角色编辑界面','admin_rbac_role_edit_view','admin','后台角色编辑界面'),(71,2,1,'后台角色授权界面','admin_rbac_authorize_view','admin','后台角色授权界面');

/*Table structure for table `qm_hook_plugin` */

DROP TABLE IF EXISTS `qm_hook_plugin`;

CREATE TABLE `qm_hook_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(50) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子插件表';

/*Data for the table `qm_hook_plugin` */

insert  into `qm_hook_plugin`(`id`,`list_order`,`status`,`hook`,`plugin`) values (1,10000,1,'footer_start','Demo');

/*Table structure for table `qm_link` */

DROP TABLE IF EXISTS `qm_link`;

CREATE TABLE `qm_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:不显示',
  `rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) NOT NULL DEFAULT '' COMMENT '链接与网站的关系',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='友情链接表';

/*Data for the table `qm_link` */

insert  into `qm_link`(`id`,`status`,`rating`,`list_order`,`description`,`url`,`name`,`image`,`target`,`rel`) values (1,1,1,8,'thinkcmf官网','http://www.thinkcmf.com','ThinkCMF','','_blank','');

/*Table structure for table `qm_member` */

DROP TABLE IF EXISTS `qm_member`;

CREATE TABLE `qm_member` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `open_id` varchar(64) NOT NULL DEFAULT '' COMMENT '微信open_id',
  `nickname` varchar(32) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号',
  `logo` varchar(200) NOT NULL DEFAULT '' COMMENT '用户头像url',
  `grade` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户等级: 1=合伙人',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户余额',
  `parent` varchar(6) NOT NULL DEFAULT '' COMMENT '邀请人',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1=正常 2=禁用',
  `login_time` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `login_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `add_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

/*Data for the table `qm_member` */

insert  into `qm_member`(`member_id`,`open_id`,`nickname`,`mobile`,`logo`,`grade`,`money`,`parent`,`status`,`login_time`,`login_ip`,`add_time`) values (1,'wwxwx','zzh','13588888888','',1,'520.00','007',1,NULL,'','2020-06-15 11:43:37'),(2,'ds','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:28'),(3,'fgd','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:30'),(4,'www','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:31'),(5,'ee','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:32'),(6,'rr','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:32'),(7,'t','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:33'),(8,'y','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:34'),(9,'u','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:34'),(10,'i','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:35'),(11,'o','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:36'),(12,'p','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:37'),(13,'1','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:38'),(14,'2','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:38'),(15,'3','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:39'),(16,'4','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:40'),(17,'5','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:40'),(18,'6','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:41'),(19,'7','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:43'),(20,'8','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:44'),(21,'9','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:45'),(22,'11','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:46'),(23,'22','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:47'),(24,'3','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:47'),(25,'4','','','',1,'0.00','0',2,NULL,'','2020-06-16 11:47:50'),(26,'5','','','',1,'0.00','0',1,NULL,'','2020-06-16 11:47:52');

/*Table structure for table `qm_nav` */

DROP TABLE IF EXISTS `qm_nav`;

CREATE TABLE `qm_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_main` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否为主导航;1:是;0:不是',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '导航位置名称',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航位置表';

/*Data for the table `qm_nav` */

insert  into `qm_nav`(`id`,`is_main`,`name`,`remark`) values (1,1,'主导航','主导航'),(2,0,'底部导航','');

/*Table structure for table `qm_nav_menu` */

DROP TABLE IF EXISTS `qm_nav_menu`;

CREATE TABLE `qm_nav_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_id` int(11) NOT NULL COMMENT '导航 id',
  `parent_id` int(11) NOT NULL COMMENT '父 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '打开方式',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航菜单表';

/*Data for the table `qm_nav_menu` */

insert  into `qm_nav_menu`(`id`,`nav_id`,`parent_id`,`status`,`list_order`,`name`,`target`,`href`,`icon`,`path`) values (1,1,0,1,0,'首页','','home','','0-1');

/*Table structure for table `qm_option` */

DROP TABLE IF EXISTS `qm_option`;

CREATE TABLE `qm_option` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoload` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否自动加载;1:自动加载;0:不自动加载',
  `option_name` varchar(64) NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='全站配置表';

/*Data for the table `qm_option` */

insert  into `qm_option`(`id`,`autoload`,`option_name`,`option_value`) values (1,1,'site_info','{\"site_name\":\"ThinkCMF\\u5185\\u5bb9\\u7ba1\\u7406\\u6846\\u67b6\",\"site_seo_title\":\"ThinkCMF\\u5185\\u5bb9\\u7ba1\\u7406\\u6846\\u67b6\",\"site_seo_keywords\":\"ThinkCMF,php,\\u5185\\u5bb9\\u7ba1\\u7406\\u6846\\u67b6,cmf,cms,\\u7b80\\u7ea6\\u98ce, simplewind,framework\",\"site_seo_description\":\"ThinkCMF\\u662f\\u7b80\\u7ea6\\u98ce\\u7f51\\u7edc\\u79d1\\u6280\\u53d1\\u5e03\\u7684\\u4e00\\u6b3e\\u7528\\u4e8e\\u5feb\\u901f\\u5f00\\u53d1\\u7684\\u5185\\u5bb9\\u7ba1\\u7406\\u6846\\u67b6\"}');

/*Table structure for table `qm_order` */

DROP TABLE IF EXISTS `qm_order`;

CREATE TABLE `qm_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_number` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '订单编号',
  `course_id` int(11) NOT NULL COMMENT '课程ID',
  `recipients` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '收件人',
  `mobile` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `site` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '收货详细地址',
  `pay_money` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '付款金额',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '付款时间',
  `pay_voucher` varchar(40) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '付款凭证',
  `dispatch_msg` varchar(40) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '发货信息',
  `activate_time` timestamp NULL DEFAULT NULL COMMENT '激活时间',
  `dispatch_time` timestamp NULL DEFAULT NULL COMMENT '发货时间',
  `delivery_time` timestamp NULL DEFAULT NULL COMMENT '收货时间',
  `refund_time` timestamp NULL DEFAULT NULL COMMENT '退货完成时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '订单状态：0=未付款 1=已付款 2=已发货 3=申请退款  4=已完成 5=已退款',
  `add_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qm_order` */

insert  into `qm_order`(`order_id`,`order_number`,`course_id`,`recipients`,`mobile`,`site`,`pay_money`,`pay_time`,`pay_voucher`,`dispatch_msg`,`activate_time`,`dispatch_time`,`delivery_time`,`refund_time`,`status`,`add_time`) values (1,'bianhao',9,'zzh','1356888989','湖南',100.00,'2020-06-18 14:30:38','','',NULL,NULL,NULL,NULL,1,'2020-06-18 11:41:00');

/*Table structure for table `qm_plugin` */

DROP TABLE IF EXISTS `qm_plugin`;

CREATE TABLE `qm_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) NOT NULL COMMENT '插件描述',
  `config` text COMMENT '插件配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='插件表';

/*Data for the table `qm_plugin` */

insert  into `qm_plugin`(`id`,`type`,`has_admin`,`status`,`create_time`,`name`,`title`,`demo_url`,`hooks`,`author`,`author_url`,`version`,`description`,`config`) values (1,1,1,1,0,'Demo','插件演示','http://demo.thinkcmf.com','','ThinkCMF','http://www.thinkcmf.com','1.0','插件演示','{\"custom_config\":\"0\",\"text\":\"hello,ThinkCMF!\",\"password\":\"\",\"number\":\"1.0\",\"select\":\"1\",\"checkbox\":1,\"radio\":\"1\",\"radio2\":\"1\",\"textarea\":\"\\u8fd9\\u91cc\\u662f\\u4f60\\u8981\\u586b\\u5199\\u7684\\u5185\\u5bb9\",\"date\":\"2017-05-20\",\"datetime\":\"2017-05-20\",\"color\":\"#103633\",\"image\":\"\",\"file\":\"\",\"location\":\"\"}');

/*Table structure for table `qm_recycle_bin` */

DROP TABLE IF EXISTS `qm_recycle_bin`;

CREATE TABLE `qm_recycle_bin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) DEFAULT '0' COMMENT '删除内容 id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(60) DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) DEFAULT '' COMMENT '删除内容名称',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=' 回收站';

/*Data for the table `qm_recycle_bin` */

/*Table structure for table `qm_role` */

DROP TABLE IF EXISTS `qm_role`;

CREATE TABLE `qm_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父角色ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

/*Data for the table `qm_role` */

insert  into `qm_role`(`id`,`parent_id`,`status`,`create_time`,`update_time`,`list_order`,`name`,`remark`) values (1,0,1,1329633709,1329633709,0,'超级管理员','拥有网站最高管理员权限！'),(2,0,1,1329633709,1329633709,0,'普通管理员','权限由最高管理员分配！');

/*Table structure for table `qm_role_user` */

DROP TABLE IF EXISTS `qm_role_user`;

CREATE TABLE `qm_role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色 id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

/*Data for the table `qm_role_user` */

/*Table structure for table `qm_route` */

DROP TABLE IF EXISTS `qm_route`;

CREATE TABLE `qm_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态;1:启用,0:不启用',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'URL规则类型;1:用户自定义;2:别名添加',
  `full_url` varchar(255) NOT NULL DEFAULT '' COMMENT '完整url',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '实际显示的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='url路由表';

/*Data for the table `qm_route` */

/*Table structure for table `qm_slide` */

DROP TABLE IF EXISTS `qm_slide`;

CREATE TABLE `qm_slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示,0不显示',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片分类',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分类备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';

/*Data for the table `qm_slide` */

/*Table structure for table `qm_slide_item` */

DROP TABLE IF EXISTS `qm_slide_item`;

CREATE TABLE `qm_slide_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) NOT NULL DEFAULT '0' COMMENT '幻灯片id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '幻灯片名称',
  `image` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片图片',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片链接',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '幻灯片描述',
  `content` text CHARACTER SET utf8 COMMENT '幻灯片内容',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `slide_id` (`slide_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片子项表';

/*Data for the table `qm_slide_item` */

/*Table structure for table `qm_subject` */

DROP TABLE IF EXISTS `qm_subject`;

CREATE TABLE `qm_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '学科类目',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '学科名称',
  `remark` text COLLATE utf8_unicode_ci COMMENT '备注',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qm_subject` */

insert  into `qm_subject`(`id`,`name`,`remark`,`add_time`) values (1,'语文',NULL,'2020-06-15 14:25:35'),(2,'数学',NULL,'2020-06-15 14:25:37'),(3,'英语',NULL,'2020-06-15 14:25:41'),(4,'地理',NULL,'2020-06-15 14:25:44'),(5,'政治',NULL,'2020-06-15 14:25:48'),(6,'天文学2222','2\r\n3\r\n3\r\n4\r\n4\r\n4\r\n4','2020-06-15 14:25:52'),(7,'武学1','12\r\n3\r\n4\r\n\r\n5','2020-06-15 14:26:13');

/*Table structure for table `qm_supplier` */

DROP TABLE IF EXISTS `qm_supplier`;

CREATE TABLE `qm_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商管理',
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '供应商名称',
  `company_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '公司名称',
  `linkman` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '联系人名称',
  `mobile` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `qq` varchar(40) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '微信/qq',
  `remark` text COLLATE utf8_unicode_ci COMMENT '备注',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qm_supplier` */

insert  into `qm_supplier`(`id`,`name`,`company_name`,`linkman`,`mobile`,`qq`,`remark`,`add_time`) values (1,'供应商111','粉创公司','樊登','135654654646','3213154646',NULL,'2020-06-15 14:42:59'),(2,'斗气宗师','呜呜呜呜开发公司','我是谁','188888888','46464646','阿萨\r\n阿萨ss \r\nss \r\n是\r\na \r\na\r\n ','2020-06-16 15:09:09');

/*Table structure for table `qm_theme` */

DROP TABLE IF EXISTS `qm_theme`;

CREATE TABLE `qm_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后升级时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模板状态,1:正在使用;0:未使用',
  `is_compiled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为已编译模板',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '主题目录名，用于主题的维一标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '主题版本号',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `author` varchar(20) NOT NULL DEFAULT '' COMMENT '主题作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT '支持语言',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '主题关键字',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '主题描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `qm_theme` */

insert  into `qm_theme`(`id`,`create_time`,`update_time`,`status`,`is_compiled`,`theme`,`name`,`version`,`demo_url`,`thumbnail`,`author`,`author_url`,`lang`,`keywords`,`description`) values (1,0,0,0,0,'default','default','1.0.0','http://demo.thinkcmf.com','','ThinkCMF','http://www.thinkcmf.com','zh-cn','ThinkCMF默认模板','ThinkCMF默认模板');

/*Table structure for table `qm_theme_file` */

DROP TABLE IF EXISTS `qm_theme_file`;

CREATE TABLE `qm_theme_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_public` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否公共的模板文件',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '模板名称',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '模板文件名',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作',
  `file` varchar(50) NOT NULL DEFAULT '' COMMENT '模板文件，相对于模板根目录，如Portal/index.html',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '模板文件描述',
  `more` text COMMENT '模板更多配置,用户自己后台设置的',
  `config_more` text COMMENT '模板更多配置,来源模板的配置文件',
  `draft_more` text COMMENT '模板更多配置,用户临时保存的配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qm_theme_file` */

/*Table structure for table `qm_third_party_user` */

DROP TABLE IF EXISTS `qm_third_party_user`;

CREATE TABLE `qm_third_party_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '本站用户id',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `login_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方唯一码',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='第三方用户表';

/*Data for the table `qm_third_party_user` */

/*Table structure for table `qm_user` */

DROP TABLE IF EXISTS `qm_user`;

CREATE TABLE `qm_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型;1:admin;2:会员',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `coin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '中国手机不带国家代码，国际手机号格式为：国家代码-手机号',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `user_login` (`user_login`),
  KEY `user_nickname` (`user_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

/*Data for the table `qm_user` */

insert  into `qm_user`(`id`,`user_type`,`sex`,`birthday`,`last_login_time`,`score`,`coin`,`balance`,`create_time`,`user_status`,`user_login`,`user_pass`,`user_nickname`,`user_email`,`user_url`,`avatar`,`signature`,`last_login_ip`,`user_activation_key`,`mobile`,`more`) values (1,1,0,0,1592356516,0,0,'0.00',1592273339,1,'admin','###f9d949381f4db94779ba3f41b27659ba','admin','464338930@qq.com','','','','127.0.0.1','','',NULL);

/*Table structure for table `qm_user_action` */

DROP TABLE IF EXISTS `qm_user_action`;

CREATE TABLE `qm_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  `reward_number` int(11) NOT NULL DEFAULT '0' COMMENT '奖励次数',
  `cycle_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '周期时间值',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COMMENT '执行操作的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户操作表';

/*Data for the table `qm_user_action` */

insert  into `qm_user_action`(`id`,`score`,`coin`,`reward_number`,`cycle_type`,`cycle_time`,`name`,`action`,`app`,`url`) values (1,1,1,1,2,1,'用户登录','login','user','');

/*Table structure for table `qm_user_action_log` */

DROP TABLE IF EXISTS `qm_user_action_log`;

CREATE TABLE `qm_user_action_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `object` varchar(100) NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user_id`,`object`,`action`),
  KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访问记录表';

/*Data for the table `qm_user_action_log` */

/*Table structure for table `qm_user_balance_log` */

DROP TABLE IF EXISTS `qm_user_balance_log`;

CREATE TABLE `qm_user_balance_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `change` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改余额',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改后余额',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户余额变更日志表';

/*Data for the table `qm_user_balance_log` */

/*Table structure for table `qm_user_favorite` */

DROP TABLE IF EXISTS `qm_user_favorite`;

CREATE TABLE `qm_user_favorite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，JSON格式',
  `description` text COMMENT '收藏内容的描述',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int(10) unsigned DEFAULT '0' COMMENT '收藏内容原来的主键id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户收藏表';

/*Data for the table `qm_user_favorite` */

/*Table structure for table `qm_user_like` */

DROP TABLE IF EXISTS `qm_user_like`;

CREATE TABLE `qm_user_like` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '内容原来的主键id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '内容以前所在表,不带前缀',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容的原文地址，不带域名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `description` text COMMENT '内容的描述',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户点赞表';

/*Data for the table `qm_user_like` */

/*Table structure for table `qm_user_login_attempt` */

DROP TABLE IF EXISTS `qm_user_login_attempt`;

CREATE TABLE `qm_user_login_attempt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login_attempts` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试次数',
  `attempt_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试登录时间',
  `locked_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户登录尝试表';

/*Data for the table `qm_user_login_attempt` */

/*Table structure for table `qm_user_score_log` */

DROP TABLE IF EXISTS `qm_user_score_log`;

CREATE TABLE `qm_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作积分等奖励日志表';

/*Data for the table `qm_user_score_log` */

/*Table structure for table `qm_user_token` */

DROP TABLE IF EXISTS `qm_user_token`;

CREATE TABLE `qm_user_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT ' 过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户客户端登录 token 表';

/*Data for the table `qm_user_token` */

insert  into `qm_user_token`(`id`,`user_id`,`expire_time`,`create_time`,`token`,`device_type`) values (1,1,1607825357,1592273357,'c130a8dfe79f328e78ca26e2d57153647d55b1de3cf2ffbe27134af9d1785531','web');

/*Table structure for table `qm_verification_code` */

DROP TABLE IF EXISTS `qm_verification_code`;

CREATE TABLE `qm_verification_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='手机邮箱数字验证码表';

/*Data for the table `qm_verification_code` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
