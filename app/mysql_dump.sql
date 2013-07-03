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
(1, 'Local Server', 'original', 'localhost', 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table sandbox.user: ~3 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `nickname`, `nickname_webalized`, `email`, `password`, `create_date`, `hash`, `role`, `active`) VALUES
(1, 'admin', '', 'admin@altamira.sk', '$2a$07$$$$$$$$$$$$$$$$$$$$$$.9HtHO1j5P16O6kyrKLlZ2iwOVgDsKba', '0000-00-00 00:00:00', '', 'admin', 0),
(2, 'editor', '', 'editor@altamira.sk', '$2a$07$$$$$$$$$$$$$$$$$$$$$$.wKglPz/fv9aAUxHKooBp3A.Gp0veDCa', '0000-00-00 00:00:00', '', 'editor', 0),
(3, 'matej', 'matej', 'roarbb@gmail.com', '$2a$07$$$$$$$$$$$$$$$$$$$$$$.9HtHO1j5P16O6kyrKLlZ2iwOVgDsKba', '2013-07-03 00:36:07', 'rkqsat8xmrja4nq7c3o3', 'user', 1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
