-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.27 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             8.0.0.4396
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table sandbox.admin_module
DROP TABLE IF EXISTS `admin_module`;
CREATE TABLE IF NOT EXISTS `admin_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Číslo modulu',
  `name` varchar(255) NOT NULL COMMENT 'Meno modulu',
  `table` varchar(255) NOT NULL COMMENT 'Tabuľka',
  `allow_export` enum('1','0') DEFAULT '1' COMMENT 'Povoliť export',
  `active` enum('1','0') DEFAULT '1' COMMENT 'Aktívny',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Dumping data for table sandbox.admin_module: ~3 rows (approximately)
DELETE FROM `admin_module`;
/*!40000 ALTER TABLE `admin_module` DISABLE KEYS */;
INSERT INTO `admin_module` (`id`, `name`, `table`, `allow_export`, `active`) VALUES
	(1, 'moduleList', 'admin_module', '1', '1'),
	(8, 'theme', 'theme', '1', '1'),
	(9, 'user', 'user', '1', '1');
/*!40000 ALTER TABLE `admin_module` ENABLE KEYS */;


-- Dumping structure for table sandbox.admin_module_column
DROP TABLE IF EXISTS `admin_module_column`;
CREATE TABLE IF NOT EXISTS `admin_module_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_module_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `replacement_table` varchar(255) DEFAULT NULL,
  `replacement_id_column` varchar(255) DEFAULT NULL,
  `replacement_name_column` varchar(255) DEFAULT NULL,
  `editable` enum('1','0') DEFAULT '0',
  `viewable` enum('1','0') DEFAULT '0',
  `active` enum('1','0') DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 3` (`admin_module_id`,`name`),
  KEY `FK_admin_module_column_admin_module` (`admin_module_id`),
  CONSTRAINT `FK_admin_module_column_admin_module` FOREIGN KEY (`admin_module_id`) REFERENCES `admin_module` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8;

-- Dumping data for table sandbox.admin_module_column: ~19 rows (approximately)
DELETE FROM `admin_module_column`;
/*!40000 ALTER TABLE `admin_module_column` DISABLE KEYS */;
INSERT INTO `admin_module_column` (`id`, `admin_module_id`, `name`, `replacement_table`, `replacement_id_column`, `replacement_name_column`, `editable`, `viewable`, `active`) VALUES
	(4, 1, 'name', NULL, NULL, NULL, '0', '1', '1'),
	(5, 1, 'table', NULL, NULL, NULL, '0', '1', '1'),
	(6, 1, 'allow_export', NULL, NULL, NULL, '0', '1', '1'),
	(7, 1, 'active', NULL, NULL, NULL, '0', '1', '1'),
	(10, 1, 'id', NULL, NULL, NULL, '0', '1', '1'),
	(245, 8, 'id', NULL, NULL, NULL, '0', '1', '1'),
	(246, 8, 'name', NULL, NULL, NULL, '1', '1', '1'),
	(247, 8, 'theme_folder', NULL, NULL, NULL, '1', '1', '1'),
	(248, 8, 'host', NULL, NULL, NULL, '1', '1', '1'),
	(249, 8, 'active', NULL, NULL, NULL, '1', '1', '1'),
	(250, 9, 'id', NULL, NULL, NULL, '0', '1', '1'),
	(251, 9, 'nickname', NULL, NULL, NULL, '0', '1', '1'),
	(252, 9, 'nickname_webalized', NULL, NULL, NULL, '0', '0', '1'),
	(253, 9, 'email', NULL, NULL, NULL, '0', '1', '1'),
	(254, 9, 'password', NULL, NULL, NULL, '0', '0', '1'),
	(255, 9, 'create_date', NULL, NULL, NULL, '0', '1', '1'),
	(256, 9, 'hash', NULL, NULL, NULL, '0', '0', '1'),
	(257, 9, 'role', NULL, NULL, NULL, '0', '1', '1'),
	(258, 9, 'active', NULL, NULL, NULL, '0', '1', '1');
/*!40000 ALTER TABLE `admin_module_column` ENABLE KEYS */;


-- Dumping structure for table sandbox.alt_google_links
DROP TABLE IF EXISTS `alt_google_links`;
CREATE TABLE IF NOT EXISTS `alt_google_links` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `link_table_name` varchar(100) COLLATE utf8_slovak_ci NOT NULL,
  `link_table_id` int(6) NOT NULL,
  `link_google_uri` text COLLATE utf8_slovak_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_table_name` (`link_table_name`,`link_table_id`),
  FULLTEXT KEY `link_google_uri` (`link_google_uri`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci;

-- Dumping data for table sandbox.alt_google_links: 0 rows
DELETE FROM `alt_google_links`;
/*!40000 ALTER TABLE `alt_google_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `alt_google_links` ENABLE KEYS */;


-- Dumping structure for table sandbox.alt_sections
DROP TABLE IF EXISTS `alt_sections`;
CREATE TABLE IF NOT EXISTS `alt_sections` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(120) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Name[*]',
  `meta_title` varchar(255) COLLATE utf8_slovak_ci NOT NULL COMMENT '<Title> html tag',
  `perex` text COLLATE utf8_slovak_ci NOT NULL COMMENT 'Perex',
  `text` text COLLATE utf8_slovak_ci NOT NULL COMMENT 'Text',
  `keywords` text COLLATE utf8_slovak_ci NOT NULL COMMENT 'META Keywords',
  `description` text COLLATE utf8_slovak_ci NOT NULL COMMENT 'META Description',
  `image` varchar(150) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Image',
  `type` enum('1','2','3','4') COLLATE utf8_slovak_ci NOT NULL COMMENT 'Type[*]',
  `item_order` int(4) NOT NULL DEFAULT '0',
  `forward_link` varchar(150) COLLATE utf8_slovak_ci NOT NULL COMMENT 'URL address',
  `google_uri` varchar(255) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Google address',
  `parent_id` int(4) NOT NULL DEFAULT '0',
  `active` enum('0','1') COLLATE utf8_slovak_ci NOT NULL DEFAULT '1' COMMENT 'Active',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci PACK_KEYS=0;

-- Dumping data for table sandbox.alt_sections: 0 rows
DELETE FROM `alt_sections`;
/*!40000 ALTER TABLE `alt_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `alt_sections` ENABLE KEYS */;


-- Dumping structure for table sandbox.theme
DROP TABLE IF EXISTS `theme`;
CREATE TABLE IF NOT EXISTS `theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `theme_folder` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `active` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table sandbox.theme: ~1 rows (approximately)
DELETE FROM `theme`;
/*!40000 ALTER TABLE `theme` DISABLE KEYS */;
INSERT INTO `theme` (`id`, `name`, `theme_folder`, `host`, `active`) VALUES
	(1, 'LocalHost', 'original', 'localhost', 1);
/*!40000 ALTER TABLE `theme` ENABLE KEYS */;


-- Dumping structure for table sandbox.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) NOT NULL,
  `nickname_webalized` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` char(60) NOT NULL,
  `create_date` datetime NOT NULL,
  `hash` varchar(20) NOT NULL,
  `role` varchar(255) NOT NULL,
  `active` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniquemail` (`email`),
  UNIQUE KEY `uniquelogin` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table sandbox.user: ~1 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `nickname`, `nickname_webalized`, `email`, `password`, `create_date`, `hash`, `role`, `active`) VALUES
	(1, 'roarbb', 'roarbb', 'roarbb@gmail.com', '$2a$07$$$$$$$$$$$$$$$$$$$$$$.mnEkB8o4j5Gx.R1.SZ8.4TXhYdmA7uK', '2013-07-05 06:55:01', '672z7ohwv7usddgbe6d4', 'admin', 1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
