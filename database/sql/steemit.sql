/*
 Navicat MySQL Data Transfer

 Source Server         : LocalHost
 Source Server Type    : MySQL
 Source Server Version : 50635
 Source Host           : 127.0.0.1
 Source Database       : steemit-db

 Target Server Type    : MySQL
 Target Server Version : 50635
 File Encoding         : utf-8

 Date: 01/09/2018 08:44:27 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `admin_menu`
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `uri` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `admin_menu`
-- ----------------------------
BEGIN;
INSERT INTO `admin_menu` VALUES ('1', '0', '1', 'Index', 'fa-bar-chart', '/', null, null), ('2', '0', '2', 'Admin', 'fa-tasks', '', null, null), ('3', '2', '3', 'Users', 'fa-users', 'auth/users', null, null), ('4', '2', '4', 'Roles', 'fa-user', 'auth/roles', null, null), ('5', '2', '5', 'Permission', 'fa-ban', 'auth/permissions', null, null), ('6', '2', '6', 'Menu', 'fa-bars', 'auth/menu', null, null), ('7', '2', '7', 'Operation log', 'fa-history', 'auth/logs', null, null), ('8', '10', '9', '新闻情报', 'fa-file-text-o', 'intelligence', '2017-11-14 09:01:50', '2017-11-22 10:29:27'), ('9', '10', '10', '帮助文档', 'fa-book', 'help-doc', '2017-11-16 10:16:16', '2017-11-22 10:29:27'), ('10', '0', '8', '公告帮助', 'fa-copy', null, '2017-11-22 10:28:37', '2017-11-22 10:29:27');
COMMIT;

-- ----------------------------
--  Table structure for `admin_operation_log`
-- ----------------------------
DROP TABLE IF EXISTS `admin_operation_log`;
CREATE TABLE `admin_operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `input` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_operation_log_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `admin_operation_log`
-- ----------------------------
BEGIN;
INSERT INTO `admin_operation_log` VALUES ('1', '1', 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-11-23 06:46:32', '2017-11-23 06:46:32'), ('2', '1', 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-11-23 06:46:32', '2017-11-23 06:46:32'), ('3', '1', 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-11-23 06:46:37', '2017-11-23 06:46:37'), ('4', '2', 'admin', 'GET', '::1', '[]', '2017-11-23 06:46:45', '2017-11-23 06:46:45'), ('5', '1', 'admin', 'GET', '::1', '[]', '2017-12-22 08:18:00', '2017-12-22 08:18:00'), ('6', '1', 'admin/intelligence', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-12-22 08:18:06', '2017-12-22 08:18:06'), ('7', '1', 'admin/help-doc', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-12-22 08:18:07', '2017-12-22 08:18:07'), ('8', '1', 'admin', 'GET', '::1', '{\"_pjax\":\"%23pjax-container\"}', '2017-12-22 08:18:09', '2017-12-22 08:18:09'), ('9', '1', 'admin/intelligence', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-12-22 08:18:11', '2017-12-22 08:18:11');
COMMIT;

-- ----------------------------
--  Table structure for `admin_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `http_method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `http_path` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `admin_permissions`
-- ----------------------------
BEGIN;
INSERT INTO `admin_permissions` VALUES ('1', 'All permission', '*', '', '*', null, null), ('2', 'Dashboard', 'dashboard', 'GET', '/', null, null), ('3', 'Login', 'auth.login', '', '/auth/login\r\n/auth/logout', null, null), ('4', 'User setting', 'auth.setting', 'GET,PUT', '/auth/setting', null, null), ('5', 'Auth management', 'auth.management', '', '/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs', null, null), ('6', '新闻情报', 'intelligence', '', '/intelligence\r\n/intelligence/*', '2017-11-15 09:19:53', '2017-11-22 10:29:59'), ('7', '帮助文档', 'help-doc', '', '/help-doc\r\n/help-doc/*', '2017-11-16 10:15:10', '2017-11-16 10:15:10');
COMMIT;

-- ----------------------------
--  Table structure for `admin_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `admin_role_menu`
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_menu` VALUES ('1', '2', null, null), ('1', '8', null, null), ('2', '8', null, null), ('1', '9', null, null), ('2', '9', null, null), ('1', '10', null, null), ('2', '10', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `admin_role_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `admin_role_permissions`
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_permissions` VALUES ('1', '1', null, null), ('2', '3', null, null), ('2', '2', null, null), ('2', '4', null, null), ('2', '6', null, null), ('2', '7', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `admin_role_users`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_users`;
CREATE TABLE `admin_role_users` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_users_role_id_user_id_index` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `admin_role_users`
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_users` VALUES ('1', '1', null, null), ('2', '2', null, null), ('2', '3', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `admin_roles`
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `admin_roles`
-- ----------------------------
BEGIN;
INSERT INTO `admin_roles` VALUES ('1', 'Administrator', 'administrator', '2017-11-14 07:39:59', '2017-11-14 07:39:59'), ('2', 'PM', 'project manager', '2017-11-15 09:18:10', '2017-11-15 09:18:10');
COMMIT;

-- ----------------------------
--  Table structure for `admin_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_permissions`;
CREATE TABLE `admin_user_permissions` (
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `admin_users`
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `admin_users`
-- ----------------------------
BEGIN;
INSERT INTO `admin_users` VALUES ('1', 'admin', '$2y$10$EJ7Cy34vDC2/wvJ31vrK6umnlnCSMY7EPxovVMRKtQKANCtDOIC/y', 'Administrator', null, '5jPVeIUhSau2uORSAtsk0XOTxQtZouAOYGWguMxP25BnbHyrmpT9S6yvkzja', '2017-11-14 07:39:59', '2017-11-14 08:08:26'), ('2', 'manager', '$2y$10$DWNpB0whICVQrqI02lseReSb2anr4XeM0205SsOFImLtsuOP.RzzK', 'manager', '', 'bIlOmHfR0QqS1othrNPGyDjIP6ahs8RQ0UbvkI5TyBLsW69vwJBByajw1RtG', '2017-11-15 09:15:19', '2017-11-22 10:25:24');
COMMIT;

-- ----------------------------
--  Table structure for `article_comments`
-- ----------------------------
DROP TABLE IF EXISTS `article_comments`;
CREATE TABLE `article_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `article_likes`
-- ----------------------------
DROP TABLE IF EXISTS `article_likes`;
CREATE TABLE `article_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ids` (`user_id`,`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `article_tags`
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `articles`
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` longtext,
  `content_html` longtext,
  `main_tag` varchar(255) DEFAULT NULL COMMENT '用于分类的主tag',
  `tag` varchar(255) DEFAULT NULL,
  `first_img_url` text,
  `author_id` int(11) DEFAULT NULL,
  `txid` varchar(64) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `help_docs`
-- ----------------------------
DROP TABLE IF EXISTS `help_docs`;
CREATE TABLE `help_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `focus_img_url` varchar(255) DEFAULT NULL,
  `summary` text,
  `content` longtext,
  `author` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `intelligences`
-- ----------------------------
DROP TABLE IF EXISTS `intelligences`;
CREATE TABLE `intelligences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `focus_img_url` varchar(255) DEFAULT NULL,
  `summary` text,
  `content` longtext,
  `author` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `migrations`
-- ----------------------------
BEGIN;
INSERT INTO `migrations` VALUES ('1', '2014_10_12_000000_create_users_table', '1'), ('2', '2014_10_12_100000_create_password_resets_table', '1'), ('3', '2016_01_04_173148_create_admin_tables', '1'), ('4', '2016_06_01_000001_create_oauth_auth_codes_table', '2'), ('5', '2016_06_01_000002_create_oauth_access_tokens_table', '2'), ('6', '2016_06_01_000003_create_oauth_refresh_tokens_table', '2'), ('7', '2016_06_01_000004_create_oauth_clients_table', '2'), ('8', '2016_06_01_000005_create_oauth_personal_access_clients_table', '2');
COMMIT;

-- ----------------------------
--  Table structure for `oauth_access_tokens`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `oauth_access_tokens`
-- ----------------------------
BEGIN;
INSERT INTO `oauth_access_tokens` VALUES ('03261cd943ab513159a9cd155820e9ab8b25794b621eab0bd3ee20ac7e9753217cc74317b78e4f8b', '1', '2', null, '[]', '0', '2017-12-25 02:48:20', '2017-12-25 02:48:20', '2018-01-09 02:48:20'), ('0708c2e4398bcb974bf32cc8eafbd2f3a238abad4c7e697d32aa4b371898137d93cc370ffae255c2', '1', '2', null, '[]', '1', '2018-01-08 14:05:46', '2018-01-08 14:05:46', '2018-01-09 14:05:46'), ('07a836b04375be1e0b47140aebb7e7ed761ed884d6f467aa8d84073e469ad4d8a89ed2b477311140', '1', '2', null, '[]', '0', '2017-12-24 13:13:39', '2017-12-24 13:13:39', '2018-01-08 13:13:39'), ('099daba4e6b676ec237f4ec8588544da21dd04f230bdeb569889621a5a9d85de9950225b54d8f74d', '1', '2', null, '[]', '1', '2017-12-28 07:12:42', '2017-12-28 07:12:42', '2017-12-29 07:12:41'), ('0ccafe5bf25742dd8ac5a020a82e924cf678c79e484bac7a9e57b5c17e0262945aca138927cc508e', '1', '2', null, '[]', '1', '2018-01-05 05:42:49', '2018-01-05 05:42:49', '2018-01-06 05:42:49'), ('0de7d16bbd38baf5d3d7eac2513c523b122bbd5036f5ed33d81fba1eba464a11500b40e66c174da0', '21', '2', null, '[]', '1', '2018-01-08 10:52:45', '2018-01-08 10:52:45', '2018-01-09 10:52:45'), ('1338e2f363a0be72e3a1cd14db13e991fc6254762cde3d813967cce172ad78a954f071ec4103d960', '1', '2', null, '[]', '1', '2018-01-04 07:37:11', '2018-01-04 07:37:11', '2018-01-05 07:37:11'), ('1617919819a5624c14cff1557906f9922464ce343a800ea30959f0eedb692b05f6777cb27d775097', '1', '2', null, '[]', '0', '2017-12-24 13:13:06', '2017-12-24 13:13:06', '2018-01-08 13:13:06'), ('187563a1c7a63c2ccba412d472905889a73eb7fc79f4942518c092bfd115e43e4da1d5a2f6717fd3', '1', '2', null, '[]', '0', '2018-01-03 04:08:06', '2018-01-03 04:08:06', '2018-01-04 04:08:05'), ('1892a04450b0314348d50911064e395baea88710dd5ee2defb8e5dedbd96bf95c8e596fc8d4e82d7', '1', '2', null, '[]', '1', '2017-12-26 06:41:05', '2017-12-26 06:41:05', '2017-12-27 06:41:05'), ('1fd97965e2cd9f3caefdeb0d12302c50843f83f55d70b00873e531e4b37729556b6edcc0b2bb6ed1', '16', '2', null, '[]', '1', '2018-01-05 15:05:27', '2018-01-05 15:05:27', '2018-01-06 15:05:27'), ('21f3bb995323a927ccb567dd9f364d0efde2b1041db3b6d3e80faacc050e053bb99af13b07f7aa0a', '1', '2', null, '[]', '1', '2018-01-01 07:38:09', '2018-01-01 07:38:09', '2018-01-02 07:38:09'), ('24af5eb4f096c122b51233e297077318545efc555704b343a62b6a9b49c1bd0384b6f9dc1089dc5c', '21', '2', null, '[]', '1', '2018-01-08 14:50:04', '2018-01-08 14:50:04', '2018-01-09 14:50:04'), ('289d1ea6e8dbdd0c829fdd274528b44710be77b83071a84b557b8645711e8272517bfe6e1875a8e7', '1', '2', null, '[]', '1', '2018-01-01 07:32:26', '2018-01-01 07:32:26', '2018-01-02 07:32:26'), ('2a3746523d68c62ac76c4eb1b5acda5c845b2790932516822b1a7fbfc37db7ce726f0b1822ca3dca', '1', '2', null, '[]', '0', '2017-12-25 13:22:59', '2017-12-25 13:22:59', '2017-12-26 13:22:59'), ('2a9ede2db55ee932b6b24e2b495d9dd46dcd89610695bb6f321c94884f977b61cc7c8afa09a150d5', '1', '2', null, '[]', '1', '2018-01-04 07:58:42', '2018-01-04 07:58:42', '2018-01-05 07:58:42'), ('2b871b293de73c1655289a310a940331250062114a7183a434e29aeebbb0fbd99a440ba738bc3d7d', '1', '2', null, '[]', '1', '2018-01-05 05:38:45', '2018-01-05 05:38:45', '2018-01-06 05:38:45'), ('2be8afaad68911385a8ed16ebb176ec86ec24b41fb7aacb032b6580a02a0f71f52e6b1dc7487b0af', '1', '2', null, '[]', '1', '2017-12-28 06:29:12', '2017-12-28 06:29:12', '2017-12-29 06:29:12'), ('2e51c17d40601f2cf4676745e45a5d2ed1b7f494afee43812b613da8b15df666e7f8833c09df44b6', '1', '2', null, '[]', '1', '2018-01-08 10:48:24', '2018-01-08 10:48:24', '2018-01-09 10:48:24'), ('306cbb44267c5f037cbdfc1d0c1573c1ad2ea0388eb5d413fd96fd2e888d7bf227f6dc7a5480fef1', '1', '2', null, '[]', '0', '2017-12-24 14:06:57', '2017-12-24 14:06:57', '2018-01-08 14:06:57'), ('3563a23493bc07241b75d98c54f944bf328d627d08da63eec23b2c12a87d9055f71ce66d43c8004b', '1', '2', null, '[]', '1', '2017-12-28 11:32:31', '2017-12-28 11:32:31', '2017-12-29 11:32:31'), ('357731be17050cf0c49b938bcef7d96a0e02eea5104718e64ff1c405533b24be645a6ab51b803562', '1', '2', null, '[]', '1', '2017-12-28 11:16:21', '2017-12-28 11:16:21', '2017-12-29 11:16:21'), ('361c132e06e83923961e962fe0258ed703c8ddf8a6f963c2c70ab19d145775b6e06bbd5f1cf230a4', '1', '2', null, '[]', '1', '2017-12-26 02:53:49', '2017-12-26 02:53:49', '2017-12-27 02:53:49'), ('38ca41b049bb11112778ac524c5aff0f9d2ab163536c6d188e468945cd9f8eadcc97e3be3fdcebba', '15', '2', null, '[]', '1', '2018-01-05 11:00:59', '2018-01-05 11:00:59', '2018-01-06 11:00:59'), ('39a1799d2fc1eb572d5d249c0ee9bcf962978881984705c9005f270fd457bfba565661265ec60d88', '1', '2', null, '[]', '0', '2017-12-25 10:16:00', '2017-12-25 10:16:00', '2017-12-26 10:16:00'), ('3a3ac661c974790747e4f4021f9fa90da329bb45268c69af5da8c8809ebf313a2dbe410b70090484', '1', '2', null, '[]', '1', '2017-12-28 01:46:51', '2017-12-28 01:46:51', '2017-12-29 01:46:51'), ('4172168af7be7969b99b916e0a2d80fe4ec6c5ea459214768bec2ec754b50db40ea1bac2f09420f7', '1', '2', null, '[]', '0', '2017-12-24 13:12:16', '2017-12-24 13:12:16', '2018-01-08 13:12:16'), ('41f91988e9ea02b0929ab776c52595da69203747a706d6093d361561fe57c5abbdf89340d7840823', '1', '2', null, '[]', '0', '2018-01-03 04:08:04', '2018-01-03 04:08:04', '2018-01-04 04:08:04'), ('4c2b1a821b2124ca27fd4ed7616fd8bb0ae450aec146901216f15842449f6a3db9cc134e876ea220', '21', '2', null, '[]', '1', '2018-01-08 14:15:13', '2018-01-08 14:15:13', '2018-01-09 14:15:13'), ('4ced3e9a127ba8be8a80b55076da94d6c3384c5e97536c471faeed19e2d165d9bcb14f74672b50ff', '1', '2', null, '[]', '0', '2017-12-29 06:46:29', '2017-12-29 06:46:29', '2017-12-30 06:46:29'), ('4d0b47e2cc3b439a38543502949b22c5a206f861ad4ba321f95c4aef996ef929e83e49c340c6cd95', '14', '2', null, '[]', '1', '2018-01-05 10:10:05', '2018-01-05 10:10:05', '2018-01-06 10:10:05'), ('529786f62bac7b2a4afa423a1263e30fa74ef275cc4f7311923df6b1c8fb0dc4038a25be407cd932', '1', '2', null, '[]', '1', '2018-01-04 08:01:32', '2018-01-04 08:01:32', '2018-01-05 08:01:32'), ('530c36b67d5fa325a5c999053d4fe6ba561c3209f3ab363630431ddd0c70fc6a0856a4916ecdcc62', '18', '2', null, '[]', '1', '2018-01-08 10:51:48', '2018-01-08 10:51:48', '2018-01-09 10:51:48'), ('532e178477762b873d03c08324c35909fb371d05d3b52c08e1a64be82a0e708137610d656fae767e', '1', '2', null, '[]', '0', '2017-12-24 13:15:05', '2017-12-24 13:15:05', '2018-01-08 13:15:05'), ('5cc2a4d201b99f8e2cdaffaf3e4d0e68351e821d699bee991eb507d885badc4a42a3fed66ee172c6', '1', '2', null, '[]', '1', '2018-01-05 06:36:23', '2018-01-05 06:36:23', '2018-01-06 06:36:23'), ('60ce695e122ab5c9c159a5f802d65149b1ecddce6e8177142a41a478db710d1670ecdfd1bd118c0c', '1', '2', null, '[]', '1', '2018-01-04 08:02:39', '2018-01-04 08:02:39', '2018-01-05 08:02:39'), ('62f727d21435e972a3aae3296d869d793611db4ff3943e76c6f19921e92631c519e2e640bd41e98c', '1', '2', null, '[]', '1', '2018-01-06 06:48:59', '2018-01-06 06:48:59', '2018-01-07 06:48:59'), ('66160a6c92e6b65fb06df424551763f7fd76df9160ff02265e6b9e3172de52b970d15866385ee967', '1', '2', null, '[]', '0', '2017-12-24 14:16:01', '2017-12-24 14:16:01', '2018-01-08 14:16:01'), ('67424e81ea666070e8d00292d3a4922dd9217cc0fcc8d1eab65c1345bd294cb6a2ebd6b5c707a44a', '1', '2', null, '[]', '1', '2017-12-27 05:23:55', '2017-12-27 05:23:55', '2017-12-28 05:23:55'), ('694dfce615335d7028f3d303629e85c7a27ccb647151dbe86696ac43df6b8c961e13c078dbec42d4', '1', '2', null, '[]', '0', '2017-12-25 02:43:22', '2017-12-25 02:43:22', '2018-01-09 02:43:22'), ('6b60da4aae259823c2887232c49060690bc7d3e923d35aa37298b7584055ab09d1a778b742ecb8f7', '1', '2', null, '[]', '1', '2017-12-26 03:22:12', '2017-12-26 03:22:12', '2017-12-27 03:22:12'), ('6b95cbd87882c88a511e8500d07feddae0a6b1343f9119dbed1b35e9893b803fc444a64cf9a80671', '1', '2', null, '[]', '1', '2017-12-25 13:23:00', '2017-12-25 13:23:00', '2017-12-26 13:23:00'), ('6de476678ab44ae22b5eb7f15de88ce2bd332bf89cc68512c117191c5dba9e062ee2ac77beae470c', '1', '2', null, '[]', '0', '2017-12-24 13:12:17', '2017-12-24 13:12:17', '2018-01-08 13:12:17'), ('6e88fee2d0c78c10df640449702cd973234e479b1be90eebb3681d93e266cd831b7dc6bfb1b76059', '21', '2', null, '[]', '1', '2018-01-08 14:06:10', '2018-01-08 14:06:10', '2018-01-09 14:06:10'), ('70c019b263dc7bfac8e1080079b4e87a3358f21372254df47a894fee1eea356e8fe8fbfd67ff208d', '21', '2', null, '[]', '0', '2018-01-08 14:57:50', '2018-01-08 14:57:50', '2018-01-09 14:57:50'), ('7107b3802ec3af57ddb3fbea0f7df0bc368f3878a727d9f312a4c8de565a8fc4282207d67ef0ce8d', '1', '2', null, '[]', '0', '2017-12-25 02:31:49', '2017-12-25 02:31:49', '2018-01-09 02:31:49'), ('728528f99daf27296d38873ce2c6e981f2cf2e63f5e3a07db211f34e9297738cf1623361f6a3c861', '1', '2', null, '[]', '1', '2017-12-28 06:41:29', '2017-12-28 06:41:29', '2017-12-29 06:41:29'), ('75e594dde7dd870925ff5e639a10b16d1e550876be4fc7eee1b85eea66cbae9a2f39d2a7d1809917', '1', '2', null, '[]', '1', '2017-12-26 02:28:10', '2017-12-26 02:28:10', '2017-12-27 02:28:10'), ('77991857a7ed1ecf2c7ca4c890a44b9fc33953f8aef42027e5e6abc5d27a4a76f598464c2a33e689', '1', '2', null, '[]', '0', '2018-01-02 03:52:33', '2018-01-02 03:52:33', '2018-01-03 03:52:33'), ('782c344f1deb952e06475ca3b71926637d1a991150a264a219a3777bd8c7d546d50484c4348a1a97', '1', '2', null, '[]', '0', '2017-12-24 10:44:15', '2017-12-24 10:44:15', '2018-01-08 10:44:14'), ('7e7ffaadd4724e6ac5cb5a66985bf89d51ff0b50805538e8135b9c58fdeb31347b6062ce431fbfb4', '21', '2', null, '[]', '1', '2018-01-08 14:32:01', '2018-01-08 14:32:01', '2018-01-09 14:32:01'), ('81e634c943c64d7d0752d50f4f7adddf693d8f23a75d19105653fa90ef36a0b8e34448f9b0dfc273', '21', '2', null, '[]', '1', '2018-01-08 10:52:05', '2018-01-08 10:52:05', '2018-01-09 10:52:05'), ('839993072235ce61969bb4e62742c885f7aa02f44cd057cc08242b29173261c36cc0afc7370cd9d5', '1', '2', null, '[]', '0', '2017-12-24 14:14:39', '2017-12-24 14:14:39', '2018-01-08 14:14:39'), ('85e8515df9af8a24c29604ca091f7710745e7db6a573bedde09fd3c9aab5d88beb503a37751e3cfb', '1', '2', null, '[]', '1', '2017-12-28 06:31:12', '2017-12-28 06:31:12', '2017-12-29 06:31:11'), ('86afd9003a9c5af3cc40e90fa1622ee2f52147a08423a012a7e08a1184968bf3c8ad0fbcfbe42352', '1', '2', null, '[]', '1', '2017-12-26 06:56:07', '2017-12-26 06:56:07', '2017-12-27 06:56:07'), ('87778d612bb8c06461d2b21ef3f442ebbf425ed585f984c1f44c38a3bcb63ea1566b4c448cfffa79', '1', '2', null, '[]', '0', '2017-12-24 13:15:26', '2017-12-24 13:15:26', '2018-01-08 13:15:26'), ('87b04bf51079ad36cf56ffbdfadb3a39f0ffcb2849fb1a20a66bba06bbc6fc8248eb587cc4437e81', '1', '2', null, '[]', '1', '2018-01-04 07:55:07', '2018-01-04 07:55:07', '2018-01-05 07:55:07'), ('924383d62c992445427434cbc2f3c85a7a49180aeca052156a3086f2c29d82e07fbc473a8ea91680', '18', '2', null, '[]', '1', '2018-01-06 06:53:28', '2018-01-06 06:53:28', '2018-01-07 06:53:28'), ('92a45e8fd9a7ab2ffef7051d8fb41b377a44fe2bdc041656cb723033ced797d9337130c18afe7345', '2', '2', null, '[]', '1', '2017-12-27 05:14:58', '2017-12-27 05:14:58', '2017-12-28 05:14:58'), ('92e0fa29dfc4662c39e6799d2febfb20221aa89cc5fe337c6bfeda7335853c25da454bfab2405690', '1', '2', null, '[]', '0', '2017-12-24 13:16:06', '2017-12-24 13:16:06', '2018-01-08 13:16:06'), ('99adc2d847334a42834ea8e73b46505916868a6c0497fc94d7d029a5d6c81a610ecbb6c79d63dfdb', '21', '2', null, '[]', '1', '2018-01-08 14:31:09', '2018-01-08 14:31:09', '2018-01-09 14:31:09'), ('9a0ac13c17c08fb179cc5e6f380a17140f13a9997a5f035fad173ae7d774bc3cc20b648021ce683b', '1', '2', null, '[]', '0', '2018-01-02 03:59:12', '2018-01-02 03:59:12', '2018-01-03 03:59:12'), ('9ba6211d0b5f45278d1e284056f8dd3945a288ff830187b6b47bda56d25c8dafd0c1712c1ff50029', '21', '2', null, '[]', '1', '2018-01-08 10:50:27', '2018-01-08 10:50:27', '2018-01-09 10:50:27'), ('9fb118905b2ae80b8149584e78248eed20f4972b9854f5e386d2feb8f0c40d4c3ff2519483e27559', '1', '2', null, '[]', '1', '2017-12-26 02:55:23', '2017-12-26 02:55:23', '2017-12-27 02:55:23'), ('a4466bc8966c97e4c5c23f4233a87ee7297d568b47a930c981b63a81d258121444440123b402638e', '1', '2', null, '[]', '1', '2017-12-29 06:12:15', '2017-12-29 06:12:15', '2017-12-30 06:12:15'), ('adc9139e96817af009fc6c8d5260d65a695a6885b2bb5e967e51b0c1075b2ed653c8d4c9304d0fe9', '1', '2', null, '[]', '1', '2018-01-06 06:37:09', '2018-01-06 06:37:09', '2018-01-07 06:37:09'), ('affa71119a54493b72c80c39eb0fc7d760c0f789617d271a58556f4fe95562598b1dc0b110ed2eec', '1', '2', null, '[]', '1', '2017-12-26 07:09:18', '2017-12-26 07:09:18', '2017-12-27 07:09:18'), ('b102d4e0418419b7c8eae08c9a2a1a45571aa8e7445bd8037de123037924e19dd4c7ba6854590179', '1', '2', null, '[]', '0', '2017-12-24 14:11:25', '2017-12-24 14:11:25', '2018-01-08 14:11:25'), ('b4e5e3e6ab5faafd0d728fb16f84d090f59a0e187399a89bac7c022f2c909729c30bbff6187cb18f', '20', '2', null, '[]', '1', '2018-01-08 06:49:17', '2018-01-08 06:49:17', '2018-01-09 06:49:17'), ('ba3f2c7cad0e7a4ed1da3f280d9ef0e5d8ce727613ffad7fd749a6b407f1157ca7ae148370fbdf3d', '1', '2', null, '[]', '1', '2018-01-04 04:15:14', '2018-01-04 04:15:14', '2018-01-05 04:15:14'), ('babd87a42af754fa21f45c5fa06eb7bea9cb73bc784b60b05c326d8cce75c09b2465b3317f44d016', '21', '2', null, '[]', '1', '2018-01-08 14:33:29', '2018-01-08 14:33:29', '2018-01-09 14:33:29'), ('be9baa103fd013a87a5ce6810c7a69c7d0abbc114b179129f2606591d16db1f0d70ee4836b366e1b', '1', '2', null, '[]', '1', '2018-01-04 07:59:54', '2018-01-04 07:59:54', '2018-01-05 07:59:54'), ('c333e5ccdf118b30592b68d1914164137342fdb5afb26942a9ad13b6e18ed258d2835b26db29715c', '1', '2', null, '[]', '1', '2018-01-04 07:59:14', '2018-01-04 07:59:14', '2018-01-05 07:59:14'), ('c6d21b3f1efaa6518404ded95f2c45ca9a16b95d897ce9c26b4f6354f9a7f5e709f70234f589a080', '1', '2', null, '[]', '0', '2017-12-24 10:48:15', '2017-12-24 10:48:15', '2018-01-08 10:48:15'), ('ca35230c822a7d0f0d90fdec76c907e138bb82917bcf28b17ac356f2e66366ee6c89d0f8bc42dc29', '1', '2', null, '[]', '1', '2018-01-04 07:57:32', '2018-01-04 07:57:32', '2018-01-05 07:57:32'), ('ca6f5ef9190ad534ddbb50fb5fdf3604db9ef7376875618deb1660edd41637cacb9399fb8c8a9d37', '19', '2', null, '[]', '0', '2018-01-06 07:11:09', '2018-01-06 07:11:09', '2018-01-07 07:11:09'), ('cc4a83ee2a277002b8879f48cb5fffaab5928a7bd220f7f5502c4901214ddcb0838bfe33e7078beb', '1', '2', null, '[]', '1', '2017-12-25 02:51:19', '2017-12-25 02:51:19', '2018-01-09 02:51:19'), ('cebd2d2166b807f137dc37e1225a4b145a4222b224301213552bb4b35838a4dafe2cfe1923b325a0', '1', '2', null, '[]', '0', '2017-12-25 02:42:51', '2017-12-25 02:42:51', '2018-01-09 02:42:51'), ('d19652af744c317106671ab8a5db7a934986581ace1901805527432cb23d61d1075f2362508efa46', '1', '2', null, '[]', '1', '2017-12-25 13:10:15', '2017-12-25 13:10:15', '2017-12-26 13:10:15'), ('d8ab05439ac1676f6c57a0d3426c698e6cdf9dd3ee1a9c3e4793d5f5570d709e11df80019682b2b9', '1', '2', null, '[]', '1', '2018-01-05 14:46:36', '2018-01-05 14:46:36', '2018-01-06 14:46:36'), ('d94c676c5b63e1dc25d83d7824d08c8269108657a9c68538acccc3264cfc500e8d069ab7bc844b1d', '1', '2', null, '[]', '1', '2018-01-08 06:42:07', '2018-01-08 06:42:07', '2018-01-09 06:42:07'), ('dbb7a08641dcb338998bdbc22e0201a0c28a44944247f24d4a5ba43d5e370e2513312904f1e0afb1', '1', '2', null, '[]', '0', '2017-12-31 06:13:16', '2017-12-31 06:13:16', '2018-01-01 06:13:16'), ('deb297909234fabe67de94e6702e0c61fb509d28dc5be7c59476d26144cdbf1b51aced16fee074ae', '1', '2', null, '[]', '0', '2017-12-24 13:25:13', '2017-12-24 13:25:13', '2018-01-08 13:25:13'), ('e3453f4cd07314a74a5b854e21bdeaafefd35608026a08be4d9c0d9f541f23aa3937087708e7786a', '19', '2', null, '[]', '0', '2018-01-06 07:11:08', '2018-01-06 07:11:08', '2018-01-07 07:11:08'), ('ea40ed5cadb0184cf5c36dae830156dfb3682873d226dcbe32faddee270948c45a1c687e58ab7465', '1', '2', null, '[]', '1', '2017-12-27 08:23:35', '2017-12-27 08:23:35', '2017-12-28 08:23:34'), ('ea7d94e65f56cf9d06035370dd3971eaa6a4994609c65de505f33a04e05322855ed1337b99a403ca', '1', '2', null, '[]', '1', '2017-12-27 14:53:01', '2017-12-27 14:53:01', '2017-12-28 14:53:01'), ('ec831beeb24a795c662b712a39df4a2e06285892c2a18fdcfb22dea88d3ae8f380c0e3a4e79ea532', '1', '2', null, '[]', '0', '2017-12-24 10:44:03', '2017-12-24 10:44:03', '2018-01-08 10:44:02'), ('ecc338625f5c7494bbcbd778b9cc08084ec1c8ba91528fe7be1b8ac99a4615d29cf1dbb9abb4440f', '1', '2', null, '[]', '1', '2017-12-27 05:49:31', '2017-12-27 05:49:31', '2017-12-28 05:49:31'), ('ee7b8d372ad6a39a0fcb527931b279fd9585e902b8711dad9ac3b8de7e04b53f9497ebfb40e7005e', '1', '2', null, '[]', '1', '2018-01-04 07:58:17', '2018-01-04 07:58:17', '2018-01-05 07:58:17'), ('fb38459baecf4c245680e8769a7595727eeceb87ce57fe7f172ad96e83898428b48be32c12b63cfb', '1', '2', null, '[]', '1', '2017-12-25 10:53:11', '2017-12-25 10:53:11', '2017-12-26 10:53:11'), ('fbefe9867cadacfbd6907b987095de74893f5ec324017af94a6dcbbc4c98bac138c39f9f11883256', '20', '2', null, '[]', '1', '2018-01-08 10:52:29', '2018-01-08 10:52:29', '2018-01-09 10:52:29'), ('ff08c4eae4eb017abdd8eece880a8cf1488c5dc42a8dbf9adee79dc85ac242c52f2a74242fb848ae', '1', '2', null, '[]', '1', '2018-01-04 07:35:33', '2018-01-04 07:35:33', '2018-01-05 07:35:33');
COMMIT;

-- ----------------------------
--  Table structure for `oauth_auth_codes`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `oauth_clients`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `oauth_clients`
-- ----------------------------
BEGIN;
INSERT INTO `oauth_clients` VALUES ('1', null, 'Laravel Personal Access Client', 'vGQPHRxJ9C0EfQPJ1uZqgjmXo6Q9fTMWRJhCI5HL', 'http://localhost', '1', '0', '0', '2017-12-24 10:28:53', '2017-12-24 10:28:53'), ('2', null, 'Laravel Password Grant Client', 'pXTSUxQ3hLgpUKNoTKzYOyigPoDe568qntmdJ5IS', 'http://localhost', '0', '1', '0', '2017-12-24 10:28:53', '2017-12-24 10:28:53');
COMMIT;

-- ----------------------------
--  Table structure for `oauth_personal_access_clients`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `oauth_personal_access_clients`
-- ----------------------------
BEGIN;
INSERT INTO `oauth_personal_access_clients` VALUES ('1', '1', '2017-12-24 10:28:53', '2017-12-24 10:28:53');
COMMIT;

-- ----------------------------
--  Table structure for `oauth_refresh_tokens`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `oauth_refresh_tokens`
-- ----------------------------
BEGIN;
INSERT INTO `oauth_refresh_tokens` VALUES ('00276f93590a68e292145a9295923cff0775dafd6fc1691ff120892e41bf01e9788da5f4f52fe60a', '306cbb44267c5f037cbdfc1d0c1573c1ad2ea0388eb5d413fd96fd2e888d7bf227f6dc7a5480fef1', '0', '2018-01-23 14:06:57'), ('03a8ee6164bb34a2a4b01943d83f3cb0260c8846e018e10a6e993ec79b7aa9b70373109aa418a6a9', '92e0fa29dfc4662c39e6799d2febfb20221aa89cc5fe337c6bfeda7335853c25da454bfab2405690', '0', '2018-01-23 13:16:06'), ('06207d9470cef4bb32f6f24c7da340b6b8f699867144f41642f708125541454dbd91f225a2cc070e', '66160a6c92e6b65fb06df424551763f7fd76df9160ff02265e6b9e3172de52b970d15866385ee967', '0', '2018-01-23 14:16:01'), ('0838e0090f3fd304c851b13c3a2a6b0bb552837d4d09f1944bb03e4042651dea31dbd44d92c38750', 'cebd2d2166b807f137dc37e1225a4b145a4222b224301213552bb4b35838a4dafe2cfe1923b325a0', '0', '2018-01-24 02:42:51'), ('0853679a59fdbd035e5e0f9ffd0fab5a9eacdb2a78ada89c5dfda3432ab86fc49c150c6ca972bd96', 'ea40ed5cadb0184cf5c36dae830156dfb3682873d226dcbe32faddee270948c45a1c687e58ab7465', '1', '2018-01-26 08:23:34'), ('0e1c245b6b8ba70849bc4858cb067e3f9e77cf55e9dd3f3ff6990d9531980f1a17b486c85da17fc4', 'ea7d94e65f56cf9d06035370dd3971eaa6a4994609c65de505f33a04e05322855ed1337b99a403ca', '1', '2018-01-26 14:53:01'), ('0e7c9f70ff5305737d0690097cfd6fa7c938ad884f1f3c1f117f48b75e00488d1ed868b98a2e6a42', 'ee7b8d372ad6a39a0fcb527931b279fd9585e902b8711dad9ac3b8de7e04b53f9497ebfb40e7005e', '1', '2018-02-03 07:58:17'), ('0f3131bacd9caa46c3894a1e87cb0d1e54f73d22de66bd660311516bae18c66dee35b0b4011b9357', '6e88fee2d0c78c10df640449702cd973234e479b1be90eebb3681d93e266cd831b7dc6bfb1b76059', '1', '2018-02-07 14:06:10'), ('12c2cdf25b81c12c5654fcb9b551a109fa3d9dd8fbeea165f9944fefb37e4efd1a75e7d732e6da74', '87b04bf51079ad36cf56ffbdfadb3a39f0ffcb2849fb1a20a66bba06bbc6fc8248eb587cc4437e81', '1', '2018-02-03 07:55:07'), ('1335b51ae5e74b9ab2a30162c5dd30ae2161f00e0fdc44102d8306258eeff482925f8c34b22e81d1', 'ff08c4eae4eb017abdd8eece880a8cf1488c5dc42a8dbf9adee79dc85ac242c52f2a74242fb848ae', '1', '2018-02-03 07:35:33'), ('1370ab4c4091f63595985c41a0cff71a51cb078567c0fd88778a20fab744d6d0a6477c7d17865b90', '1892a04450b0314348d50911064e395baea88710dd5ee2defb8e5dedbd96bf95c8e596fc8d4e82d7', '1', '2018-01-25 06:41:05'), ('184f0beced29e45f4f4301d75c62e2969613c4d7a3695e6b841cfd01cb2fc88d60d78ff0c695124e', 'cc4a83ee2a277002b8879f48cb5fffaab5928a7bd220f7f5502c4901214ddcb0838bfe33e7078beb', '1', '2018-01-24 02:51:19'), ('1c48079c6a211c0b8af90a42680c33f383a7f19c8ee4af12d3fce6d442f615a05929223ff90a4472', '839993072235ce61969bb4e62742c885f7aa02f44cd057cc08242b29173261c36cc0afc7370cd9d5', '0', '2018-01-23 14:14:39'), ('1cc28346a5aff5ee86e70efec46083d6b25e1792dd5fd2f343ec8f27b0ba41bffb1e89c01c45dfd6', 'ec831beeb24a795c662b712a39df4a2e06285892c2a18fdcfb22dea88d3ae8f380c0e3a4e79ea532', '0', '2018-01-23 10:44:03'), ('1d55097c208e43e54ac0b19d8a09dd93eb7113e705f5c25f0d6b292ca287461d87bbcd15b08dd1b0', '4ced3e9a127ba8be8a80b55076da94d6c3384c5e97536c471faeed19e2d165d9bcb14f74672b50ff', '0', '2018-01-28 06:46:29'), ('1fea450001d2ec77ce2a7d38c1a48557f229e60ff7b63d1eb87c7ccaf8bda0956002817cb45d6f8c', 'a4466bc8966c97e4c5c23f4233a87ee7297d568b47a930c981b63a81d258121444440123b402638e', '1', '2018-01-28 06:12:15'), ('2062761e36ce6ba568992edcc10ed2f4fde9c1594f65139df3174961292ab0e0a6246b9ae16c63f0', '4172168af7be7969b99b916e0a2d80fe4ec6c5ea459214768bec2ec754b50db40ea1bac2f09420f7', '0', '2018-01-23 13:12:16'), ('288910d4e16db9d24720d3d72a7357b1c1b79cd380296911884abd3b6a2d99624c64c527b8528156', '6de476678ab44ae22b5eb7f15de88ce2bd332bf89cc68512c117191c5dba9e062ee2ac77beae470c', '0', '2018-01-23 13:12:17'), ('2b08e6078f68861bb93de0ac47392f39912e81fb362d694e1244fc5796c12fd554d3c083f52a2dd1', 'dbb7a08641dcb338998bdbc22e0201a0c28a44944247f24d4a5ba43d5e370e2513312904f1e0afb1', '0', '2018-01-30 06:13:16'), ('2bf555f34bae3d077dee03c9fc45e36d3a63d3f17c34f18353587526be24803af395deb1378933b0', '9fb118905b2ae80b8149584e78248eed20f4972b9854f5e386d2feb8f0c40d4c3ff2519483e27559', '1', '2018-01-25 02:55:23'), ('2c76a5d08ede98a8f8c986a85ab426574d45fad283fbe33399c75f5ea34d459dbde0f9f506af87be', '2e51c17d40601f2cf4676745e45a5d2ed1b7f494afee43812b613da8b15df666e7f8833c09df44b6', '1', '2018-02-07 10:48:24'), ('2cd867b6ca6fd275bd31ba986390e0ba05619dfd6c62eb261ce4ec070dfcca2c547ba191b0703699', '38ca41b049bb11112778ac524c5aff0f9d2ab163536c6d188e468945cd9f8eadcc97e3be3fdcebba', '1', '2018-02-04 11:00:59'), ('2dc8f5a6ae274840d3dad3923070dbe64e9e8450ddde7f64e2939f6576006bbbd49d6fe6864f07b1', '99adc2d847334a42834ea8e73b46505916868a6c0497fc94d7d029a5d6c81a610ecbb6c79d63dfdb', '1', '2018-02-07 14:31:09'), ('2fc918ba53cc121f2c48e3dc7781be85a6099360e2b8fa142587ac84780b07de8b2264ababbaec3a', 'd94c676c5b63e1dc25d83d7824d08c8269108657a9c68538acccc3264cfc500e8d069ab7bc844b1d', '1', '2018-02-07 06:42:07'), ('34f36d6f65c3e90035dfd771e988c73bd24d3526a9ef2ef75cb8e510b0532f2da4c3f37a7eee0590', '92a45e8fd9a7ab2ffef7051d8fb41b377a44fe2bdc041656cb723033ced797d9337130c18afe7345', '1', '2018-01-26 05:14:58'), ('3a55be6c5b1e4ae6979843e29667e94cfbdddf7bb12202734e3393527210566de2bde610e85107f2', 'fbefe9867cadacfbd6907b987095de74893f5ec324017af94a6dcbbc4c98bac138c39f9f11883256', '1', '2018-02-07 10:52:29'), ('3be8bb3b0d50e075cf6b8193afbb25ddde081e462d74d1c00423546d6bf2e5f0e5f5d7235438b0db', 'ca6f5ef9190ad534ddbb50fb5fdf3604db9ef7376875618deb1660edd41637cacb9399fb8c8a9d37', '0', '2018-02-05 07:11:09'), ('3cc6032131d577b9ead5b30f8d97793e3e21c204b18f8b4c6d08be917fec8d650435581d33ef26ce', '1fd97965e2cd9f3caefdeb0d12302c50843f83f55d70b00873e531e4b37729556b6edcc0b2bb6ed1', '1', '2018-02-04 15:05:27'), ('3e367a9cd43ff363492edfd6864afc70d5837b3ab793038303e8cf220130dfac41714aabf5c061c8', '3563a23493bc07241b75d98c54f944bf328d627d08da63eec23b2c12a87d9055f71ce66d43c8004b', '1', '2018-01-27 11:32:31'), ('40253e74ac60f7ea7aecb7040da7c2d65e4008deae802866b424fd17ea2843e0df7149a1a1bf8002', 'b4e5e3e6ab5faafd0d728fb16f84d090f59a0e187399a89bac7c022f2c909729c30bbff6187cb18f', '1', '2018-02-07 06:49:17'), ('40fa3d4c2d1059bd4cb5b5b33748f9772ea45f633036107cdbd22f7e391631d90bd9a323257c3b28', '60ce695e122ab5c9c159a5f802d65149b1ecddce6e8177142a41a478db710d1670ecdfd1bd118c0c', '1', '2018-02-03 08:02:39'), ('4282afa75b6639cb958eb152cf684c5045503bf463f9e70173c69359976d337e41ab1f89c47c9250', 'c333e5ccdf118b30592b68d1914164137342fdb5afb26942a9ad13b6e18ed258d2835b26db29715c', '1', '2018-02-03 07:59:14'), ('42849a59eee6470fbf39a6abf71bf64c4e94a65ff5631bb21f9f086411cecc689a3785a5e26dd7d6', 'ecc338625f5c7494bbcbd778b9cc08084ec1c8ba91528fe7be1b8ac99a4615d29cf1dbb9abb4440f', '1', '2018-01-26 05:49:31'), ('435532ae57d999bd4e18c3b49380fb32e5247005324435c8702406013a5217126da0c39706e70b87', 'b102d4e0418419b7c8eae08c9a2a1a45571aa8e7445bd8037de123037924e19dd4c7ba6854590179', '0', '2018-01-23 14:11:25'), ('43bb836697ce52b685cfb9f65382c28a047a63547e3cb5fb42a79681934f9ec7df6943c14ad9145d', '9a0ac13c17c08fb179cc5e6f380a17140f13a9997a5f035fad173ae7d774bc3cc20b648021ce683b', '0', '2018-02-01 03:59:12'), ('4a0955eebd8cecca7498916c3ab9dec117295f305c9d329728bee50bcfd0433779116acc22daa029', '0708c2e4398bcb974bf32cc8eafbd2f3a238abad4c7e697d32aa4b371898137d93cc370ffae255c2', '1', '2018-02-07 14:05:46'), ('541979ee206db237c348490ca6e16742bef9d7744aa7ef569033156e31202cf952721c2d54d3d5a8', '62f727d21435e972a3aae3296d869d793611db4ff3943e76c6f19921e92631c519e2e640bd41e98c', '1', '2018-02-05 06:48:59'), ('591bfd603b2dbfbd9c899ba58dca2fccc09e9707057c41da2c88f2838a823e6a1a2b5384697cd9ef', '6b60da4aae259823c2887232c49060690bc7d3e923d35aa37298b7584055ab09d1a778b742ecb8f7', '1', '2018-01-25 03:22:12'), ('5b8681c275ce57cdd69bf21cc936fb6ab17de1818583eac5f1b03bd31845dd625349b40fa52cedbd', '6b95cbd87882c88a511e8500d07feddae0a6b1343f9119dbed1b35e9893b803fc444a64cf9a80671', '1', '2018-01-24 13:23:00'), ('5babd29c91ad3ee807511e427b9a5109ba2d52449f8bafc607837f950c25b453546bc673564462aa', '03261cd943ab513159a9cd155820e9ab8b25794b621eab0bd3ee20ac7e9753217cc74317b78e4f8b', '0', '2018-01-24 02:48:20'), ('6c86311fc2563312736ad3a0664fdaaa1ec87cc7fc35c93a3dce72f84c13a7f44609f38e9b5ccac3', '87778d612bb8c06461d2b21ef3f442ebbf425ed585f984c1f44c38a3bcb63ea1566b4c448cfffa79', '0', '2018-01-23 13:15:26'), ('6daae314bd7e2efc440671fbd2e662a7cbc737dd1b570d40468ff10aca144bb91f51ad7034b9ae1f', 'adc9139e96817af009fc6c8d5260d65a695a6885b2bb5e967e51b0c1075b2ed653c8d4c9304d0fe9', '1', '2018-02-05 06:37:09'), ('73787d3a479f463bedde79368585839dc437901f3a8b358a7f75fd4f912e720188a5ab0e920381fa', '5cc2a4d201b99f8e2cdaffaf3e4d0e68351e821d699bee991eb507d885badc4a42a3fed66ee172c6', '1', '2018-02-04 06:36:23'), ('74f1a378307c61413fc84e1c9204126422584c75cfac5d5c268f07176b7087ef273c3ff658947290', '24af5eb4f096c122b51233e297077318545efc555704b343a62b6a9b49c1bd0384b6f9dc1089dc5c', '1', '2018-02-07 14:50:04'), ('7c028582181ff30bf849a7a532da34b963d5505fd73c7ac7c2ae5569102ee08a0bf6cfc1c37aa457', '2a9ede2db55ee932b6b24e2b495d9dd46dcd89610695bb6f321c94884f977b61cc7c8afa09a150d5', '1', '2018-02-03 07:58:42'), ('7f3c4dc188b16aeef62f7185651d56e31b86bd68bc29d816b542444a09b25f8bf5e0395d60c6c146', 'd19652af744c317106671ab8a5db7a934986581ace1901805527432cb23d61d1075f2362508efa46', '1', '2018-01-24 13:10:15'), ('818b24fc4480eb1105449a7ed32a62f0600638e957ba7f58a052fde78673c5764cb4c9b359205830', '4d0b47e2cc3b439a38543502949b22c5a206f861ad4ba321f95c4aef996ef929e83e49c340c6cd95', '1', '2018-02-04 10:10:05'), ('832a306cc1890c996398767462f35d2be59d4bc30396522c83118244cafb73dd7a22de2d7c82ca71', '782c344f1deb952e06475ca3b71926637d1a991150a264a219a3777bd8c7d546d50484c4348a1a97', '0', '2018-01-23 10:44:15'), ('8628cf79cb8953d5e85e77acd557fe9857c29e72f69be1ff56b09991ddc9d66ad9991685058b0416', '2b871b293de73c1655289a310a940331250062114a7183a434e29aeebbb0fbd99a440ba738bc3d7d', '1', '2018-02-04 05:38:45'), ('86a0705587f45b6f474405eb45b6a1ec7cbfae6be36d69bcd0074127dbc16ab6828479e13fe470d6', '4c2b1a821b2124ca27fd4ed7616fd8bb0ae450aec146901216f15842449f6a3db9cc134e876ea220', '1', '2018-02-07 14:15:13'), ('87aa52865c15fc33284adde5388436a8ead167ac481fe26554788dafbd6c8cdeb485637930fa6d06', '187563a1c7a63c2ccba412d472905889a73eb7fc79f4942518c092bfd115e43e4da1d5a2f6717fd3', '0', '2018-02-02 04:08:06'), ('87e7337adcf7e91b7db9bc5992fdccfee08ffb25677cc325cc832e4807b277f9f8e3227ea2c2ca38', '85e8515df9af8a24c29604ca091f7710745e7db6a573bedde09fd3c9aab5d88beb503a37751e3cfb', '1', '2018-01-27 06:31:12'), ('89ad53d18589986b605c6fc4f90d5aa3d28b09934c2b62e27513b71a267be2c676f8621ef468a35e', '9ba6211d0b5f45278d1e284056f8dd3945a288ff830187b6b47bda56d25c8dafd0c1712c1ff50029', '1', '2018-02-07 10:50:27'), ('89c7d0fd83e854924721b028b846377969e72b16435d08af34ff04324f1e04e82826502e3dde02df', 'ca35230c822a7d0f0d90fdec76c907e138bb82917bcf28b17ac356f2e66366ee6c89d0f8bc42dc29', '1', '2018-02-03 07:57:32'), ('89f04dfca741b7f405d9267b37d9886b45c6e398cc3027452b240ee5c0e5ba25b7f17853c70e149f', '75e594dde7dd870925ff5e639a10b16d1e550876be4fc7eee1b85eea66cbae9a2f39d2a7d1809917', '1', '2018-01-25 02:28:10'), ('9ac11dc63f59b2b4f767a511bba2421e44ae627bfcef1f764914db1515471948fe8093be0d4ff1ac', '77991857a7ed1ecf2c7ca4c890a44b9fc33953f8aef42027e5e6abc5d27a4a76f598464c2a33e689', '0', '2018-02-01 03:52:33'), ('9f6184b693d496b251116516ee703d715c35a2b1771dcd1a83bbaaea146f5c47a47c301475eb2d1e', 'be9baa103fd013a87a5ce6810c7a69c7d0abbc114b179129f2606591d16db1f0d70ee4836b366e1b', '1', '2018-02-03 07:59:54'), ('a0ecc5617e3f49fc7974d0c72acf0862058687ac533d909a84e1a5ee25f7b30e2528cd3410b7e7f6', '1338e2f363a0be72e3a1cd14db13e991fc6254762cde3d813967cce172ad78a954f071ec4103d960', '1', '2018-02-03 07:37:11'), ('a1b58118777efe779fbe606924691914349261ed1f84d9956029c8ff6efd8cf4d64d53064e39ac66', '529786f62bac7b2a4afa423a1263e30fa74ef275cc4f7311923df6b1c8fb0dc4038a25be407cd932', '1', '2018-02-03 08:01:32'), ('a5a890cdab273a5a733551f8761377051109e0840d5e4a973d85246398fff1a8884229f1de8b996c', '7e7ffaadd4724e6ac5cb5a66985bf89d51ff0b50805538e8135b9c58fdeb31347b6062ce431fbfb4', '1', '2018-02-07 14:32:01'), ('ab3f6f9bfe6020f510e9cbd79fc7fb71af324aaf0625b1fd981a76141651b7a382b5a85448c019b2', '289d1ea6e8dbdd0c829fdd274528b44710be77b83071a84b557b8645711e8272517bfe6e1875a8e7', '1', '2018-01-31 07:32:26'), ('af44b48756bf9d84d460443142ee04e0f3cd4111a7b1ca50b7f522a30ed47a3d5f3fb6023bac3df3', '530c36b67d5fa325a5c999053d4fe6ba561c3209f3ab363630431ddd0c70fc6a0856a4916ecdcc62', '1', '2018-02-07 10:51:48'), ('b1096d6f97fa76f5dc057d86aa2672df06fd9eea1a28b1d339dd4c110947eb496c07db822e6cc6f3', '361c132e06e83923961e962fe0258ed703c8ddf8a6f963c2c70ab19d145775b6e06bbd5f1cf230a4', '1', '2018-01-25 02:53:49'), ('b419fc57b13639a6eab8bf66cc349a5ad662aa4607f758888c95fa4c716f2f427536553a1d77317e', '1617919819a5624c14cff1557906f9922464ce343a800ea30959f0eedb692b05f6777cb27d775097', '0', '2018-01-23 13:13:06'), ('b8e55ea5239b350ccfb31db0a36c196fb7776a8e3167e7c0e6e6f795fd65d4c0c3fac6a175b83721', '41f91988e9ea02b0929ab776c52595da69203747a706d6093d361561fe57c5abbdf89340d7840823', '0', '2018-02-02 04:08:04'), ('ba3f06af6668175a8a5b19bbe505e1a088f49b9eb486f6b769ead1f0474bed5675e54b65e004ac37', '3a3ac661c974790747e4f4021f9fa90da329bb45268c69af5da8c8809ebf313a2dbe410b70090484', '1', '2018-01-27 01:46:51'), ('c06a2acd62d4ea5f890c2e81280b357d11cc6199a4970edd16501e33a65e6e48c42818769d73b6aa', '2be8afaad68911385a8ed16ebb176ec86ec24b41fb7aacb032b6580a02a0f71f52e6b1dc7487b0af', '1', '2018-01-27 06:29:12'), ('c3e9be78e86e6effd1dcc85ebc55899392bf2d21c20111d7e3513b18f6251e119462494228195ca2', 'affa71119a54493b72c80c39eb0fc7d760c0f789617d271a58556f4fe95562598b1dc0b110ed2eec', '1', '2018-01-25 07:09:18'), ('c46cbf4438a918765a7814541d4edcbfdc910b0bdc3ce9bedf8860e2fba9f6ddd0fd7f391a43c456', 'fb38459baecf4c245680e8769a7595727eeceb87ce57fe7f172ad96e83898428b48be32c12b63cfb', '1', '2018-01-24 10:53:11'), ('c5cefb2f74ea53d4f6cd0056371d12ff342373b54751595ebfdb2766f031b82dc2feda4c6c0922fb', '86afd9003a9c5af3cc40e90fa1622ee2f52147a08423a012a7e08a1184968bf3c8ad0fbcfbe42352', '1', '2018-01-25 06:56:07'), ('c82b2de52588e5698199aea3603d4b8b2c70233240e64e2261b7367cae1ec91fb876d822d9cf171e', '924383d62c992445427434cbc2f3c85a7a49180aeca052156a3086f2c29d82e07fbc473a8ea91680', '1', '2018-02-05 06:53:28'), ('caa204f853c3d2749cafffbb11eefff1a211238d0429cdf24ce670a47ca1057ad21d18e3f43d23a9', '357731be17050cf0c49b938bcef7d96a0e02eea5104718e64ff1c405533b24be645a6ab51b803562', '1', '2018-01-27 11:16:21'), ('cbbc092b3d6c741a0b4293d68d3a2b269ab433b4400c1f15175513490a7cd7c72baeb57fc2506205', '21f3bb995323a927ccb567dd9f364d0efde2b1041db3b6d3e80faacc050e053bb99af13b07f7aa0a', '1', '2018-01-31 07:38:09'), ('d26d4995b2c4f970327d3ccf350104e2f8531de6bf03cd277864df08398be34baf870e85f7abc119', '0ccafe5bf25742dd8ac5a020a82e924cf678c79e484bac7a9e57b5c17e0262945aca138927cc508e', '1', '2018-02-04 05:42:49'), ('d2c344cb03cdc98d22c723104393288695068af2d20ac93fd125a1978afc64e3a862d63f1139fff5', '67424e81ea666070e8d00292d3a4922dd9217cc0fcc8d1eab65c1345bd294cb6a2ebd6b5c707a44a', '1', '2018-01-26 05:23:55'), ('d433237fd5cf7aa05e936d3a400b777adb2a80693876d5b8ba0179b9bb3d1b35465adc26b379e5d7', '728528f99daf27296d38873ce2c6e981f2cf2e63f5e3a07db211f34e9297738cf1623361f6a3c861', '1', '2018-01-27 06:41:29'), ('d438a15ad1a0d29ebecc29340cbe97b6ce4300c21534a279997ad060883c317a9e918a0c0bfd3e98', '099daba4e6b676ec237f4ec8588544da21dd04f230bdeb569889621a5a9d85de9950225b54d8f74d', '1', '2018-01-27 07:12:41'), ('db2a3ef21e16f697629c2e7893e8471f1303ac12bdba18b01f408e994b8bb3ab7596dce7c94d86db', '81e634c943c64d7d0752d50f4f7adddf693d8f23a75d19105653fa90ef36a0b8e34448f9b0dfc273', '1', '2018-02-07 10:52:05'), ('deb5cbf7d0a4c7861dd4c4510231dbaa4a604b63d8fc5fd3d304bedb49b7ed308a96be094d398c5a', 'e3453f4cd07314a74a5b854e21bdeaafefd35608026a08be4d9c0d9f541f23aa3937087708e7786a', '0', '2018-02-05 07:11:08'), ('e4ef0795dc1b160692e4a622592f4c75544d9e1a91e2ad33ea9a8f6fb02d6df7b0c698eff3c15e2c', '70c019b263dc7bfac8e1080079b4e87a3358f21372254df47a894fee1eea356e8fe8fbfd67ff208d', '0', '2018-02-07 14:57:50'), ('e59f4810b1441d437e92faef573ede1b0297997e109e7ab591fd6e71bd45253501ff1e0f7758bf30', '7107b3802ec3af57ddb3fbea0f7df0bc368f3878a727d9f312a4c8de565a8fc4282207d67ef0ce8d', '0', '2018-01-24 02:31:49'), ('e968744664ad45e632bce35888d498b946ddc9921b803f63c6bbd9133cfb36811d1e28b441b914ac', 'd8ab05439ac1676f6c57a0d3426c698e6cdf9dd3ee1a9c3e4793d5f5570d709e11df80019682b2b9', '1', '2018-02-04 14:46:36'), ('edec9a8b67347070da84db87ab3349013bd735dbe082164017da944b2bb6b248d2591a7ac8ffe191', '07a836b04375be1e0b47140aebb7e7ed761ed884d6f467aa8d84073e469ad4d8a89ed2b477311140', '0', '2018-01-23 13:13:39'), ('ef520d8cac375da4c91132e52297bd6acf4f53a9a241ee5c5e1e32697f3cf868d0ee778d947fc14e', 'ba3f2c7cad0e7a4ed1da3f280d9ef0e5d8ce727613ffad7fd749a6b407f1157ca7ae148370fbdf3d', '1', '2018-02-03 04:15:14'), ('f0378537bd41adaf169cebe5ac1e3c269ce9e34e84e318ece770c0bba0130773812384014b790c77', '2a3746523d68c62ac76c4eb1b5acda5c845b2790932516822b1a7fbfc37db7ce726f0b1822ca3dca', '0', '2018-01-24 13:22:59'), ('f05376cea3f1352da57259955b577c4cd7cdcdaebd26e1a1852e6e90f7f760b018753e29104ca344', '39a1799d2fc1eb572d5d249c0ee9bcf962978881984705c9005f270fd457bfba565661265ec60d88', '0', '2018-01-24 10:16:00'), ('f9e05b18335f2b73f5ffb585ee817fe4bbf329885b605a24badd46f6eba1eb2ead78825eac9cc264', 'deb297909234fabe67de94e6702e0c61fb509d28dc5be7c59476d26144cdbf1b51aced16fee074ae', '0', '2018-01-23 13:25:13'), ('faa066097a410b51eebf75074c974f188684c3f53b2fd2b52ecf51417b5ea9687dbde76fcc921c12', '0de7d16bbd38baf5d3d7eac2513c523b122bbd5036f5ed33d81fba1eba464a11500b40e66c174da0', '1', '2018-02-07 10:52:45'), ('fbbc9d7dfc04a284567fe22a41418f83f75a780d91acab1d9cfeef5ce176f1d6e964f613944874ca', 'c6d21b3f1efaa6518404ded95f2c45ca9a16b95d897ce9c26b4f6354f9a7f5e709f70234f589a080', '0', '2018-01-23 10:48:15'), ('fbec6e3229b6f851eb9ff411d3a447d865a87b0c946c1d5ce5caf76fe5279fdc9e7da46df84a9681', '694dfce615335d7028f3d303629e85c7a27ccb647151dbe86696ac43df6b8c961e13c078dbec42d4', '0', '2018-01-24 02:43:22'), ('feac024af700bfc175d271f3342d9953a63f171c68198e4d847df360298c2f69dfb468a7440c5663', '532e178477762b873d03c08324c35909fb371d05d3b52c08e1a64be82a0e708137610d656fae767e', '0', '2018-01-23 13:15:05'), ('ffc9fbb59086d800551a7f3db4cc3ac5ce1129bfbccd6085c22ae9bd4dab732721e3c1ebd71f4387', 'babd87a42af754fa21f45c5fa06eb7bea9cb73bc784b60b05c326d8cce75c09b2465b3317f44d016', '1', '2018-02-07 14:33:29');
COMMIT;

-- ----------------------------
--  Table structure for `password_resets`
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '0' COMMENT '是否邮箱已验证',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`name`),
  UNIQUE KEY `users_email_unique` (`email`,`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
