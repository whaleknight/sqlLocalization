-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        10.4.10-MariaDB - mariadb.org binary distribution
-- 服务器OS:                        Win64
-- HeidiSQL 版本:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for test
CREATE DATABASE IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `test`;

-- Dumping structure for table test.exporthistorydbset
CREATE TABLE IF NOT EXISTS `exporthistorydbset` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Exported` datetime(6) NOT NULL,
  `Reason` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table test.exporthistorydbset: ~0 rows (大约)
/*!40000 ALTER TABLE `exporthistorydbset` DISABLE KEYS */;
/*!40000 ALTER TABLE `exporthistorydbset` ENABLE KEYS */;

-- Dumping structure for table test.importhistorydbset
CREATE TABLE IF NOT EXISTS `importhistorydbset` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Imported` datetime(6) NOT NULL,
  `Information` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table test.importhistorydbset: ~0 rows (大约)
/*!40000 ALTER TABLE `importhistorydbset` DISABLE KEYS */;
/*!40000 ALTER TABLE `importhistorydbset` ENABLE KEYS */;

-- Dumping structure for table test.localizationrecords
CREATE TABLE IF NOT EXISTS `localizationrecords` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Key` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `Text` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  `LocalizationCulture` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `ResourceKey` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `UpdatedTimestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `AK_LocalizationRecords_Key_LocalizationCulture_ResourceKey` (`Key`,`LocalizationCulture`,`ResourceKey`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table test.localizationrecords: ~0 rows (大约)
/*!40000 ALTER TABLE `localizationrecords` DISABLE KEYS */;
INSERT INTO `localizationrecords` (`Id`, `Key`, `Text`, `LocalizationCulture`, `ResourceKey`, `UpdatedTimestamp`) VALUES
	(2, 'Greet', 'Hello', 'en-US', 'GreetingController', '2019-12-10 09:17:07.095002'),
	(3, 'Greet', '你好', 'zh-CHS', 'GreetingController', '2019-12-10 09:17:53.034540'),
	(5, 'Greet', 'Halo', 'ms-MY', 'GreetingController', '2019-12-10 09:18:08.749474'),
	(6, 'Greet', 'สวัสดี', 'th-TH', 'GreetingController', '2019-12-10 09:18:20.653501'),
	(7, 'Greet', '\r\nこんにちは', 'ja-JP', 'GreetingController', '2019-12-10 09:21:09.259331');
/*!40000 ALTER TABLE `localizationrecords` ENABLE KEYS */;

-- Dumping structure for table test.__efmigrationshistory
CREATE TABLE IF NOT EXISTS `__efmigrationshistory` (
  `MigrationId` varchar(95) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table test.__efmigrationshistory: ~1 rows (大约)
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` (`MigrationId`, `ProductVersion`) VALUES
	('20191210032324_localization', '3.1.0');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
