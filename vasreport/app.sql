-- MySQL dump 10.16  Distrib 10.1.20-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.1.20-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cdr_20170221`
--

DROP TABLE IF EXISTS `cdr_20170221`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170221` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170221`
--

LOCK TABLES `cdr_20170221` WRITE;
/*!40000 ALTER TABLE `cdr_20170221` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdr_20170221` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr_20170222`
--

DROP TABLE IF EXISTS `cdr_20170222`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170222` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170222`
--

LOCK TABLES `cdr_20170222` WRITE;
/*!40000 ALTER TABLE `cdr_20170222` DISABLE KEYS */;
INSERT INTO `cdr_20170222` VALUES (13,'841225236968','PT1','841225236968_1487756821785','dc7e353815634e59a1231fc275c43da9','SMS',200,'','WCG-0000','2017-02-22 09:47:01',6,'2017-02-22 09:47:02','2017-02-22 09:47:02'),(14,'841225236968','PT1','841225236968_1487756970748','841225236968_1487756970281','CSKH',2000,'','WCG-0000','2017-02-22 09:49:30',6,'2017-02-22 09:49:31','2017-02-22 09:49:31');
/*!40000 ALTER TABLE `cdr_20170222` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr_20170223`
--

DROP TABLE IF EXISTS `cdr_20170223`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170223` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170223`
--

LOCK TABLES `cdr_20170223` WRITE;
/*!40000 ALTER TABLE `cdr_20170223` DISABLE KEYS */;
INSERT INTO `cdr_20170223` VALUES (3,'84936016833','PT1','84936016833_1487788640604','ae3057572ce04db5869039e423129ea8','SMS',200,'FALSE','WCG-0000','2017-02-22 18:28:58',7,'2017-02-22 18:37:20','2017-02-22 18:37:20'),(5,'84904692232','PT1','84904692232_1487788640842','56497cba5d67464c883b5dbfcee4ffcb','SMS',200,'FALSE','WCG-0000','2017-02-22 18:28:58',7,'2017-02-22 18:37:20','2017-02-22 18:37:20'),(8,'841225236968','PT1','841225236968_1487788640635','b4227144283a4122805075bf6fe67790','SMS',200,'FALSE','WCG-0000','2017-02-22 18:28:58',7,'2017-02-22 18:37:20','2017-02-22 18:37:20'),(10,'84936315768','PT1','84936315768_1487788640896','af37c8dd04e8423b89e6bfbe73416e18','SMS',200,'FALSE','WCG-0000','2017-02-22 18:28:59',7,'2017-02-22 18:37:20','2017-02-22 18:37:20'),(11,'84936315768','PT1','84936315768_1487822197291','7535b0b0b6684f8abe519c212c6ef806','SMS',200,'','WCG-0002','2017-02-23 03:56:37',6,'2017-02-23 03:56:37','2017-02-23 03:56:37'),(12,'84936315768','PT1','84936315768_1487822249586','f8f9c081945343cabc1d07af2048b1bd','SMS',200,'','WCG-0000','2017-02-23 03:57:29',6,'2017-02-23 03:57:29','2017-02-23 03:57:29'),(13,'84904320133','PT1','84904320133_1487822482304','8ffd1d51e52d4f94ab93e3ce64a0da62','SMS',0,'','WCG-0000','2017-02-23 04:01:22',1,'2017-02-23 04:01:22','2017-02-23 04:01:22'),(14,'84904320133','CT1','84904320133_1487823824449','abb80c6b1397466da204a67a383cc9e8','SMS',0,'','WCG-0000','2017-02-23 04:23:44',1,'2017-02-23 04:23:44','2017-02-23 04:23:44'),(15,'84936315768','PT1','84936315768_1487831128303','676f9baad4bc4e80a6db4ee961e80033','SMS',200,'','WCG-0000','2017-02-23 06:25:28',6,'2017-02-23 06:25:28','2017-02-23 06:25:28'),(16,'84936315768','PT1','84936315768_1487831198363','84936315768_1487831198083','CSKH',2000,'','WCG-0017','2017-02-23 06:26:38',9,'2017-02-23 06:26:38','2017-02-23 06:26:38'),(17,'84936315768','PT1','84936315768_1487832700761','2386232d80fd4d899f3903905787244c','SMS',200,'','WCG-0000','2017-02-23 06:51:40',6,'2017-02-23 06:51:40','2017-02-23 06:51:40'),(19,'84936315768','PT1','84936315768_1487833960949','340gjoirjgo3i4','CongTT',200,'FALSE','WCG-0000','2017-02-23 07:12:40',7,'2017-02-23 07:12:41','2017-02-23 07:12:41');
/*!40000 ALTER TABLE `cdr_20170223` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr_20170224`
--

DROP TABLE IF EXISTS `cdr_20170224`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170224` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170224`
--

LOCK TABLES `cdr_20170224` WRITE;
/*!40000 ALTER TABLE `cdr_20170224` DISABLE KEYS */;
INSERT INTO `cdr_20170224` VALUES (3,'841225236968','PT1','841225236968_1487874325492','9bc1c5a84b0a41e88f2cbfb40b10e312','CongTT',200,'FALSE','WCG-0000','2017-02-23 18:16:59',7,'2017-02-23 18:25:25','2017-02-23 18:25:25'),(6,'84904692232','PT1','84904692232_1487874325582','e2e622a2c5964f6b8439be1fed2823f1','CongTT',200,'FALSE','WCG-0000','2017-02-23 18:16:59',7,'2017-02-23 18:25:25','2017-02-23 18:25:25'),(7,'84936315768','PT1','84936315768_1487926768212','84936315768_1487926766740','CSKH',2000,'','WCG-0000','2017-02-24 08:59:26',9,'2017-02-24 08:59:28','2017-02-24 08:59:28');
/*!40000 ALTER TABLE `cdr_20170224` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr_20170225`
--

DROP TABLE IF EXISTS `cdr_20170225`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170225` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170225`
--

LOCK TABLES `cdr_20170225` WRITE;
/*!40000 ALTER TABLE `cdr_20170225` DISABLE KEYS */;
INSERT INTO `cdr_20170225` VALUES (3,'841225236968','PT1','841225236968_1487960363559','0c370d8c01b64b3bb631114cf1339bc2','CongTT',200,'FALSE','WCG-0000','2017-02-24 18:11:05',7,'2017-02-24 18:19:23','2017-02-24 18:19:23'),(6,'84904692232','PT1','84904692232_1487960363562','d7b250d895a04d6e85672cd03572c620','CongTT',200,'FALSE','WCG-0000','2017-02-24 18:11:05',7,'2017-02-24 18:19:23','2017-02-24 18:19:23');
/*!40000 ALTER TABLE `cdr_20170225` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr_20170226`
--

DROP TABLE IF EXISTS `cdr_20170226`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170226` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170226`
--

LOCK TABLES `cdr_20170226` WRITE;
/*!40000 ALTER TABLE `cdr_20170226` DISABLE KEYS */;
INSERT INTO `cdr_20170226` VALUES (3,'841225236968','PT1','841225236968_1488047010070','c69813fdc70b4e32b079c923a13798df','CongTT',200,'FALSE','WCG-0000','2017-02-25 18:15:03',7,'2017-02-25 18:23:30','2017-02-25 18:23:30'),(6,'84904692232','PT1','84904692232_1488047010073','eb62466859ae47f9b8b52a8adaef8549','CongTT',200,'FALSE','WCG-0000','2017-02-25 18:15:03',7,'2017-02-25 18:23:30','2017-02-25 18:23:30'),(8,'841225236968','PT1','841225236968_1488115929193','5f6f388f9ebf4002b10743d73c0209b5','SMS',200,'','WCG-0002','2017-02-26 13:32:09',6,'2017-02-26 13:32:09','2017-02-26 13:32:09'),(9,'841225236968','CT1','841225236968_1488115960491','9ddda99298324a088cde08d31b93bb4d','SMS',2000,'','WCG-0000','2017-02-26 13:32:40',6,'2017-02-26 13:32:40','2017-02-26 13:32:40'),(10,'841225236968','TC7','841225236968_1488115982979','0ff8b12d26df4b3eaf7d48c14adc36ef','SMS',0,'','WCG-0000','2017-02-26 13:33:02',1,'2017-02-26 13:33:02','2017-02-26 13:33:02');
/*!40000 ALTER TABLE `cdr_20170226` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr_20170227`
--

DROP TABLE IF EXISTS `cdr_20170227`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170227` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170227`
--

LOCK TABLES `cdr_20170227` WRITE;
/*!40000 ALTER TABLE `cdr_20170227` DISABLE KEYS */;
INSERT INTO `cdr_20170227` VALUES (3,'841225236968','PT1','841225236968_1488132747071','ba7f39bd5db240ffb6d69b7234b80860','CongTT',200,'FALSE','WCG-0000','2017-02-26 18:04:02',7,'2017-02-26 18:12:27','2017-02-26 18:12:27'),(5,'841225236968','CT1','841225236968_1488132747089','222e3ea2e8b84b178128107893dc7bba','CongTT',2000,'FALSE','WCG-0000','2017-02-26 18:04:02',7,'2017-02-26 18:12:27','2017-02-26 18:12:27'),(6,'841225236968','TC7','841225236968_1488132747076','f9112dabf3174ba8bd5c97e61c3ba411','CongTT',7000,'FALSE','WCG-0000','2017-02-26 18:04:02',7,'2017-02-26 18:12:27','2017-02-26 18:12:27'),(8,'84904692232','PT1','84904692232_1488132747094','49d2a8d1aa164d6e82973169cafdb16e','CongTT',200,'FALSE','WCG-0000','2017-02-26 18:04:03',7,'2017-02-26 18:12:27','2017-02-26 18:12:27'),(9,'84936016833','CT1','84936016833_1488160740820','84936016833_1488160739492','CSKH',0,'','WCG-0000','2017-02-27 01:58:59',9,'2017-02-27 01:59:00','2017-02-27 01:59:00'),(10,'84936016833','TC7','84936016833_1488160749713','84936016833_1488160749659','CSKH',0,'','WCG-0000','2017-02-27 01:59:09',9,'2017-02-27 01:59:09','2017-02-27 01:59:09'),(11,'84936016833','PT7','84936016833_1488160766092','84936016833_1488160766027','CSKH',0,'','WCG-0000','2017-02-27 01:59:26',9,'2017-02-27 01:59:26','2017-02-27 01:59:26'),(12,'84936016833','PT7','84936016833_1488160788126','84936016833_1488160787857','CSKH',7000,'','WCG-0000','2017-02-27 01:59:47',9,'2017-02-27 01:59:48','2017-02-27 01:59:48'),(13,'84936016833','CT7','84936016833_1488160830947','84936016833_1488160830849','CSKH',0,'','WCG-0000','2017-02-27 02:00:30',9,'2017-02-27 02:00:30','2017-02-27 02:00:30'),(14,'84936016833','CT7','84936016833_1488160845907','84936016833_1488160845734','CSKH',7000,'','WCG-0000','2017-02-27 02:00:45',9,'2017-02-27 02:00:45','2017-02-27 02:00:45'),(15,'84936016833','CT7','84936016833_1488161282145','84936016833_1488161280173','CSKH',7000,'','WCG-0000','2017-02-27 02:08:00',9,'2017-02-27 02:08:02','2017-02-27 02:08:02'),(16,'84936016833','TC7','84936016833_1488161292906','84936016833_1488161292634','CSKH',7000,'','WCG-0000','2017-02-27 02:08:12',9,'2017-02-27 02:08:12','2017-02-27 02:08:12'),(17,'84936016833','TC7','84936016833_1488161311609','84936016833_1488161310837','CSKH',7000,'','WCG-0000','2017-02-27 02:08:30',9,'2017-02-27 02:08:31','2017-02-27 02:08:31'),(18,'84904869369','PT1','84904869369_1488176067939','87ab6a55961a40a5ab34564269560bf0','SMS',0,'','WCG-0000','2017-02-27 06:14:27',1,'2017-02-27 06:14:27','2017-02-27 06:14:27'),(19,'84936016833','CT1','84936016833_1488184740138','84936016833_1488184738863','CSKH',2000,'','WCG-0000','2017-02-27 08:38:58',9,'2017-02-27 08:39:00','2017-02-27 08:39:00'),(20,'84936016833','CT1','84936016833_1488184756415','84936016833_1488184756140','CSKH',2000,'','WCG-0000','2017-02-27 08:39:16',9,'2017-02-27 08:39:16','2017-02-27 08:39:16');
/*!40000 ALTER TABLE `cdr_20170227` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr_20170228`
--

DROP TABLE IF EXISTS `cdr_20170228`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170228` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170228`
--

LOCK TABLES `cdr_20170228` WRITE;
/*!40000 ALTER TABLE `cdr_20170228` DISABLE KEYS */;
INSERT INTO `cdr_20170228` VALUES (13,'84936016833','PT1','84936016833_1488247841203','84936016833_1488247839725','CSKH',2000,'','WCG-0000','2017-02-28 02:10:39',9,'2017-02-28 02:10:41','2017-02-28 02:10:41'),(14,'84936016833','PT1','84936016833_1488247884460','84936016833_1488247883899','CSKH',2000,'','WCG-0000','2017-02-28 02:11:23',9,'2017-02-28 02:11:24','2017-02-28 02:11:24'),(21,'84904692232','PT1','84904692232_1488250687116','7ba4de3533244b13ac21e29ae1cc6b74','CongTT',200,'FALSE','WCG-0000','2017-02-27 17:58:40',7,'2017-02-28 02:58:07','2017-02-28 02:58:07'),(22,'841225236968','PT1','841225236968_1488250695647','8c673ce51f954e2aaf09afbb4a9bb3e2','CongTT',200,'FALSE','WCG-0000','2017-02-27 17:58:41',7,'2017-02-28 02:58:15','2017-02-28 02:58:15'),(23,'841225236968','CT1','841225236968_1488250702461','a1e93ea3486947ef8a6038b7b40385b9','CongTT',2000,'FALSE','WCG-0000','2017-02-27 17:58:42',7,'2017-02-28 02:58:22','2017-02-28 02:58:22'),(24,'84936016833','CT1','84936016833_1488250708621','6063434977704cf39ba71fbd904244ae','CongTT',2000,'FALSE','WCG-0005','2017-02-27 17:58:42',7,'2017-02-28 02:58:28','2017-02-28 02:58:28'),(25,'84936016833','CT1','84936016833_1488250716108','eca2f94c49444b6a84199a7bd6f038be','CongTT',2000,'FALSE','WCG-0005','2017-02-27 23:58:52',7,'2017-02-28 02:58:36','2017-02-28 02:58:36');
/*!40000 ALTER TABLE `cdr_20170228` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr_20170301`
--

DROP TABLE IF EXISTS `cdr_20170301`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_20170301` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `subCode` varchar(20) DEFAULT '' COMMENT 'id dịch vụ mà user dùng',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '',
  `price` int(11) DEFAULT '0' COMMENT 'số tiền cong TT tru cua KH',
  `isRetry` varchar(20) DEFAULT '' COMMENT 'FALSE: ko retry, TRUE: retry',
  `errorcode` varchar(100) DEFAULT '',
  `chargedTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'thời gian charge user',
  `type` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_20170301`
--

LOCK TABLES `cdr_20170301` WRITE;
/*!40000 ALTER TABLE `cdr_20170301` DISABLE KEYS */;
INSERT INTO `cdr_20170301` VALUES (3,'841225236968','CT1','841225236968_1488305831864','0dfba437039845ec8362a2acc8a13c72','CongTT',2000,'FALSE','WCG-0000','2017-02-28 18:08:50',7,'2017-02-28 18:17:12','2017-02-28 18:17:12'),(5,'84936016833','PT1','84936016833_1488305832127','2ac1dad1dfca44f8b34f675a6005b4c1','CongTT',200,'FALSE','WCG-0000','2017-02-28 18:08:51',7,'2017-02-28 18:17:12','2017-02-28 18:17:12'),(7,'841225236968','PT1','841225236968_1488305832158','9b5d9e2b7d474ad7bc71e49f005bfa3e','CongTT',200,'FALSE','WCG-0000','2017-02-28 18:09:51',7,'2017-02-28 18:17:12','2017-02-28 18:17:12'),(10,'84936016833','CT1','84936016833_1488305831899','c271ebf6bb4042a28f31484d84454e8b','CongTT',2000,'FALSE','WCG-0005','2017-02-28 18:08:53',7,'2017-02-28 18:17:12','2017-02-28 18:17:12'),(12,'84904692232','PT1','84904692232_1488305832170','f723b04de0fa4f3ca2793c321241ff75','CongTT',200,'FALSE','WCG-0000','2017-02-28 18:09:25',7,'2017-02-28 18:17:12','2017-02-28 18:17:12'),(14,'84936016833','CT1','84936016833_1488327463774','3770186edef4402bb9c83b6d3190b573','CongTT',2000,'FALSE','WCG-0005','2017-03-01 00:09:21',7,'2017-03-01 00:17:43','2017-03-01 00:17:43');
/*!40000 ALTER TABLE `cdr_20170301` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170221`
--

DROP TABLE IF EXISTS `history_20170221`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170221` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170221`
--

LOCK TABLES `history_20170221` WRITE;
/*!40000 ALTER TABLE `history_20170221` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_20170221` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170222`
--

DROP TABLE IF EXISTS `history_20170222`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170222` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170222`
--

LOCK TABLES `history_20170222` WRITE;
/*!40000 ALTER TABLE `history_20170222` DISABLE KEYS */;
INSERT INTO `history_20170222` VALUES (37,'841225236968','9432','841225236968_1487756799060','db4cb3a2f8054fce8698bb70a0e7592d','SMS','PT1','huy pt1','Quý khách đã hủy thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK PT1 gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-22 09:46:39','2017-02-22 09:46:39'),(39,'841225236968','9432','841225236968_1487756821785','dc7e353815634e59a1231fc275c43da9','SMS','PT1','dk pt1','(DK) Quý khách đã đăng ký thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Giá 200đ/ngày, tự động gia hạn hàng ngày, soạn HUY PT1 gửi 9432 để hủy dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',6,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-22 09:47:02','2017-02-22 09:47:02'),(40,'841225236968','9432','841225236968_1487756905067','841225236968_1487756904921','CSKH','PT1','','G&#243;i PT1 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-22 09:48:25','2017-02-22 09:48:25'),(42,'841225236968','9432','841225236968_1487756970748','841225236968_1487756970281','CSKH','PT1','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i PT1 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; 200&#273;/ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n h&#224;ng ng&#224;y, so&#7841;n HUY PT1 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',6,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-22 09:49:31','2017-02-22 09:49:31'),(43,'84904328201','9432','84904328201_1487781790181','351b1a29dae1423ba661c6c3ad919e9c','SMS','ON','ON MTEEN Duythai2001','Cu phap Quy khach thuc hien chua dung. Soan HD hoac truy cap http://phongthuynguhanh.com.vn de xem huong han. Tran trong cam on!',4,'WCG-0000','2017-02-22 16:43:10','2017-02-22 16:43:10','2017-02-22 16:43:10','2017-02-22 16:43:10'),(44,'84904328201','9432','84904328201_1487781852593','1cf18738a5734b2da90af828f7b565f6','SMS','ON','ON MTEEN KH','Cu phap Quy khach thuc hien chua dung. Soan HD hoac truy cap http://phongthuynguhanh.com.vn de xem huong han. Tran trong cam on!',4,'WCG-0000','2017-02-22 16:44:12','2017-02-22 16:44:12','2017-02-22 16:44:12','2017-02-22 16:44:13');
/*!40000 ALTER TABLE `history_20170222` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170223`
--

DROP TABLE IF EXISTS `history_20170223`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170223` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170223`
--

LOCK TABLES `history_20170223` WRITE;
/*!40000 ALTER TABLE `history_20170223` DISABLE KEYS */;
INSERT INTO `history_20170223` VALUES (3,'84936016833','9432','84936016833_1487788640604','ae3057572ce04db5869039e423129ea8','SMS','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-22 18:37:20','2017-02-22 18:37:20'),(5,'84904692232','9432','84904692232_1487788640842','56497cba5d67464c883b5dbfcee4ffcb','SMS','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-22 18:37:20','2017-02-22 18:37:20'),(8,'841225236968','9432','841225236968_1487788640635','b4227144283a4122805075bf6fe67790','SMS','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-22 18:37:20','2017-02-22 18:37:20'),(10,'84936315768','9432','84936315768_1487788640896','af37c8dd04e8423b89e6bfbe73416e18','SMS','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-22 18:37:20','2017-02-22 18:37:20'),(11,'84936315768','9432','84936315768_1487818688244','4324317c4dcb445f82efca5fc403fff5','SMS','PT','Pt','Cu phap Quy khach thuc hien chua dung. Soan HD hoac truy cap http://phongthuynguhanh.com.vn de xem huong han. Tran trong cam on!',4,'WCG-0000','2017-02-23 02:58:08','2017-02-23 02:58:08','2017-02-23 02:58:08','2017-02-23 02:58:08'),(12,'84936315768','9432','84936315768_1487820202578','bada4dc7a6264ccb8dd8de406dd9a8ab','SMS','MK','Mk','mat khau truy cap website http://phongthuynguhanh.com.vn cua quy khach la: 25ec54',4,'WCG-0000','2017-02-23 03:23:22','2017-02-23 03:23:22','2017-02-23 03:23:22','2017-02-23 03:23:22'),(13,'84936315768','9432','84936315768_1487820287479','282401e559c74b95aea6b92ae93f5890','SMS','MK','Mk','mat khau truy cap website http://phongthuynguhanh.com.vn cua quy khach la: 27e5ec',4,'WCG-0000','2017-02-23 03:24:47','2017-02-23 03:24:47','2017-02-23 03:24:47','2017-02-23 03:24:47'),(14,'84936315768','9432','84936315768_1487820346258','7a993161dd53421f8ca96b392d5e248f','SMS','MK','Mk','mat khau truy cap website http://phongthuynguhanh.com.vn cua quy khach la: 9d214c',4,'WCG-0000','2017-02-23 03:25:46','2017-02-23 03:25:46','2017-02-23 03:25:46','2017-02-23 03:25:46'),(15,'84936315768','9432','84936315768_1487822139068','a8edcab71efc4d2ba6228340f82a395b','SMS','MK','Mk','mat khau truy cap website http://phongthuynguhanh.com.vn cua quy khach la: d85196',4,'WCG-0000','2017-02-23 03:55:39','2017-02-23 03:55:39','2017-02-23 03:55:39','2017-02-23 03:55:39'),(17,'84936315768','9432','84936315768_1487822197291','7535b0b0b6684f8abe519c212c6ef806','SMS','PT1','Pt','(DK) Đăng ký không thành công do Quý khách đang sử dụng gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Chi tiet lien he. Trân trọng cảm ơn!',6,'WCG-0002','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 03:56:37','2017-02-23 03:56:37'),(18,'84936315768','9432','84936315768_1487822222504','10951e357ffc4d2da9aa3a0154e4cfbe','SMS','PT1','Huy pt1','Quý khách đã hủy thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK PT1 gửi 9432 hoặc PT gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 03:57:02','2017-02-23 03:57:02'),(20,'84936315768','9432','84936315768_1487822249586','f8f9c081945343cabc1d07af2048b1bd','SMS','PT1','Pt','(DK) Quý khách đã đăng ký thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Giá 200đ/ngày, tự động gia hạn hàng ngày, soạn HUY PT1 gửi 9432 để hủy dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',6,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 03:57:29','2017-02-23 03:57:29'),(21,'84904320133','9432','84904320133_1487822482304','8ffd1d51e52d4f94ab93e3ce64a0da62','SMS','PT1','Pt','(DK) Chúc mừng quý khách đã đăng ký thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành và được MIỄN PHÍ 1 ngày sử dụng dịch vụ. Gói cước sẽ tự động gia hạn ngay sau khi hết thời gian miễn phí, cước sử dụng là 200đ/ngày. Soạn HUY PT1 gửi 9432 để hủy dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',1,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 04:01:22','2017-02-23 04:01:22'),(23,'84904320133','9432','84904320133_1487822562244','fb30090861ce432b97241fed2081d53e','SMS','PT1','Huy pt1','Quý khách đã hủy thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK PT1 gửi 9432 hoặc PT gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 04:02:42','2017-02-23 04:02:42'),(25,'84936016833','9432','84936016833_1487823789681','c93d4f262ef64c11b3a5f63ec87f9237','SMS','PT1','Huy pt1','Quý khách đã hủy thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK PT1 gửi 9432 hoặc PT gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 04:23:09','2017-02-23 04:23:09'),(26,'84904320133','9432','84904320133_1487823824449','abb80c6b1397466da204a67a383cc9e8','SMS','CT1','Dk ct1','(DK) Chúc mừng quý khách đã đăng ký thành công gói CT1 dịch vụ DV Phong Thủy Ngũ Hành và được MIỄN PHÍ 1 ngày sử dụng dịch vụ. Gói cước sẽ tự động gia hạn ngay sau khi hết thời gian miễn phí, cước sử dụng là 2.000đ/ngày. Soạn HUY CT1 gửi 9432 để hủy dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',1,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 04:23:44','2017-02-23 04:23:44'),(28,'84904320133','9432','84904320133_1487823872024','13f0a7cac45848288acc6ac822b06122','SMS','CT1','Huy ct1','Quý khách đã hủy thành công gói CT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK CT1 gửi 9432 hoặc CT gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 04:24:32','2017-02-23 04:24:32'),(29,'84936315768','9432','84936315768_1487831028225','9347a6a85522473ab7e148c1e476345d','SMS','DKDJDJP','Dkdjdjp','Cu phap Quy khach thuc hien chua dung. Soan HD hoac truy cap http://phongthuynguhanh.com.vn de xem huong han. Tran trong cam on!',3,'WCG-0000','2017-02-23 06:23:48','2017-02-23 06:23:48','2017-02-23 06:23:48','2017-02-23 06:23:48'),(30,'84936315768','9432','84936315768_1487831044008','8ccca5b93a0a4ffa94c02f93528397eb','SMS','MK','Mk','mat khau truy cap website http://phongthuynguhanh.com.vn cua quy khach la: f6cfd9',3,'WCG-0000','2017-02-23 06:24:04','2017-02-23 06:24:04','2017-02-23 06:24:04','2017-02-23 06:24:04'),(31,'84936315768','9432','84936315768_1487831054654','ea42c0a8c3aa45f8aa1b2c1b22bf6811','SMS','HD','Hd','Chao mung Quy khach den voi su tro giup cua dich vu Phong thuy ngu hanh. De dang ky dich vu, Quy khach vui long soan: DK PT gui 9432 de dang ky Phong thuy; Soan DK CT gui 9432 de dang ky Chiem tinh hoc; Soan DK TC gui 9432 de dang ky Tra Chanh 360;Soan DK VIP gui 9432 de dang ky dich vu Phong Thuy Ngu Hanh VIP. Neu Quy khach quen mat khau, soan MK gui 9432. Truy cap dia chi http://phongthuynguhanh.com.vn  de duoc huong dan cai dat ung dung. Chi tiet lien he <DT CSKH> (cuoc goi co dinh). Tran trong!',3,'WCG-0000','2017-02-23 06:24:14','2017-02-23 06:24:14','2017-02-23 06:24:14','2017-02-23 06:24:14'),(32,'84936315768','9432','84936315768_1487831080245','1f3c433abf1547bc99d6afd79a89b9ce','SMS','TG','Tg','nhan tin : Moi ban truy cap http://phongthuynguhanh.com.vn Soan DK PT gui 9432 de dang ky Phong thuy; Soan DK CT gui 9432 de dang ky Chiem tinh hoc; Soan DK TC gui 9432 de dang ky Tra Chanh 360; Soan DK VIP gui 9432 de dang ky dich vu Phong Thuy Ngu Hanh VIP. Soan MK de lay lai mat khau truy cap. Chi tiet <dt cskh>',3,'WCG-0000','2017-02-23 06:24:40','2017-02-23 06:24:40','2017-02-23 06:24:40','2017-02-23 06:24:40'),(33,'84936315768','9432','84936315768_1487831103526','7dcdae7befbb4c67a0aaf50a8942a962','SMS','PT1','Huy pt1','Quý khách đã hủy thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK PT1 gửi 9432 hoặc PT gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 06:25:03','2017-02-23 06:25:03'),(35,'84936315768','9432','84936315768_1487831128303','676f9baad4bc4e80a6db4ee961e80033','SMS','PT1','Pt','(DK) Quý khách đã đăng ký thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Giá 200đ/ngày, tự động gia hạn hàng ngày, soạn HUY PT1 gửi 9432 để hủy dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',6,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 06:25:28','2017-02-23 06:25:28'),(36,'84936315768','9432','84936315768_1487831198363','84936315768_1487831198083','CSKH','PT1','','(DK) &#272;&#259;ng k&#253; kh&#244;ng th&#224;nh c&#244;ng do Qu&#253; kh&#225;ch &#273;ang s&#7917; d&#7909;ng g&#243;i PT1 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0017','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 06:26:38','2017-02-23 06:26:38'),(37,'84936315768','9432','84936315768_1487832674157','fe99bda455164764b0830f1c12993e80','SMS','PT1','Huy pt1','Quý khách đã hủy thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK PT1 gửi 9432 hoặc PT gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 06:51:14','2017-02-23 06:51:14'),(39,'84936315768','9432','84936315768_1487832700761','2386232d80fd4d899f3903905787244c','SMS','PT1','Pt','(DK) Quý khách đã đăng ký thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Giá 200đ/ngày, tự động gia hạn hàng ngày, soạn HUY PT1 gửi 9432 để hủy dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',6,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 06:51:40','2017-02-23 06:51:40'),(41,'84936315768','9432','84936315768_1487833960949','340gjoirjgo3i4','CongTT','PT1','Gia han dich vu','\"\"',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 07:12:41','2017-02-23 07:12:41'),(42,'84936315768','9432','84936315768_1487843090612','7ce6f9f7327f46469b24bfd733f33551','SMS','PT1','Huy pt1','Quý khách đã hủy thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK PT1 gửi 9432 hoặc PT gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 09:44:50','2017-02-23 09:44:50'),(44,'84936315768','9432','84936315768_1487843121602','0.56865000 1487843116','WEB','PT1','','ĐK trên website http://phongthuynguhanh.com.vn',6,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 09:45:21','2017-02-23 09:45:21');
/*!40000 ALTER TABLE `history_20170223` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170224`
--

DROP TABLE IF EXISTS `history_20170224`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170224` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170224`
--

LOCK TABLES `history_20170224` WRITE;
/*!40000 ALTER TABLE `history_20170224` DISABLE KEYS */;
INSERT INTO `history_20170224` VALUES (3,'841225236968','9432','841225236968_1487874325492','9bc1c5a84b0a41e88f2cbfb40b10e312','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 18:25:25','2017-02-23 18:25:25'),(6,'84904692232','9432','84904692232_1487874325582','e2e622a2c5964f6b8439be1fed2823f1','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-23 18:25:25','2017-02-23 18:25:25'),(7,'84933270686','9432','84933270686_1487894829919','1685145582074b92b51997abeb6274ba','SMS','HUY','Huy gnt','Cu phap Quy khach thuc hien chua dung. Soan HD hoac truy cap http://phongthuynguhanh.com.vn de xem huong han. Tran trong cam on!',3,'WCG-0000','2017-02-24 00:07:10','2017-02-24 00:07:10','2017-02-24 00:07:09','2017-02-24 00:07:10'),(9,'84936315768','9432','84936315768_1487926761102','84936315768_1487926761012','CSKH','PT1','','G&#243;i PT1 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-24 08:59:21','2017-02-24 08:59:21'),(11,'84936315768','9432','84936315768_1487926768212','84936315768_1487926766740','CSKH','PT1','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i PT1 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; 200&#273;/ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n h&#224;ng ng&#224;y, so&#7841;n HUY PT1 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-24 08:59:28','2017-02-24 08:59:28'),(12,'84936315768','9432','84936315768_1487926791444','84936315768_1487926791383','CSKH','PT1','','G&#243;i PT1 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-24 08:59:51','2017-02-24 08:59:51');
/*!40000 ALTER TABLE `history_20170224` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170225`
--

DROP TABLE IF EXISTS `history_20170225`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170225` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170225`
--

LOCK TABLES `history_20170225` WRITE;
/*!40000 ALTER TABLE `history_20170225` DISABLE KEYS */;
INSERT INTO `history_20170225` VALUES (3,'841225236968','9432','841225236968_1487960363559','0c370d8c01b64b3bb631114cf1339bc2','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-24 18:19:23','2017-02-24 18:19:23'),(6,'84904692232','9432','84904692232_1487960363562','d7b250d895a04d6e85672cd03572c620','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-24 18:19:23','2017-02-24 18:19:23');
/*!40000 ALTER TABLE `history_20170225` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170226`
--

DROP TABLE IF EXISTS `history_20170226`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170226` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170226`
--

LOCK TABLES `history_20170226` WRITE;
/*!40000 ALTER TABLE `history_20170226` DISABLE KEYS */;
INSERT INTO `history_20170226` VALUES (3,'841225236968','9432','841225236968_1488047010070','c69813fdc70b4e32b079c923a13798df','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-25 18:23:30','2017-02-25 18:23:30'),(6,'84904692232','9432','84904692232_1488047010073','eb62466859ae47f9b8b52a8adaef8549','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-25 18:23:30','2017-02-25 18:23:30'),(8,'841212594601','9432','841212594601_1488115702741','659ae3fdb1d04a79ae79430f8866340e','SMS','Y','Y 8000','Cu phap Quy khach thuc hien chua dung. Soan HD hoac truy cap http://phongthuynguhanh.com.vn de xem huong han. Tran trong cam on!',3,'WCG-0000','2017-02-26 13:28:22','2017-02-26 13:28:23','2017-02-26 13:28:22','2017-02-26 13:28:23'),(9,'841212594601','9432','841212594601_1488115767371','7104b54fba104c3daf1bd938c2a14bb0','SMS','Y','Y','Cu phap Quy khach thuc hien chua dung. Soan HD hoac truy cap http://phongthuynguhanh.com.vn de xem huong han. Tran trong cam on!',3,'WCG-0000','2017-02-26 13:29:27','2017-02-26 13:29:27','2017-02-26 13:29:27','2017-02-26 13:29:27'),(10,'841225236968','9432','841225236968_1488115929193','5f6f388f9ebf4002b10743d73c0209b5','SMS','PT1','dk pt7','(DK) Đăng ký không thành công do Quý khách đang sử dụng gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Chi tiet lien he. Trân trọng cảm ơn!',6,'WCG-0002','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-26 13:32:09','2017-02-26 13:32:09'),(11,'841225236968','9432','841225236968_1488115960491','9ddda99298324a088cde08d31b93bb4d','SMS','CT1','dk ct1','(DK) Quý khách đã đăng ký thành công gói CT1 dịch vụ DV Phong Thủy Ngũ Hành. Giá 2.000đ/ngày, tự động gia hạn hàng ngày, soạn HUY CT1 gửi 9432 để hủy dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',6,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-26 13:32:40','2017-02-26 13:32:40'),(12,'841225236968','9432','841225236968_1488115982979','0ff8b12d26df4b3eaf7d48c14adc36ef','SMS','TC7','dk tc7','(DK) Chúc mừng Quý khách đã đăng ký thành công gói TC7 dịch vụ DV Phong Thủy Ngũ Hành và được MIỄN PHÍ 1 ngày sử dụng dịch vụ. Gói sẽ được tự động gia hạn ngay sau khi hết thời gian miễn phí, cước sử dụng là: 7.000đ/7ngày. Soạn HUY TC7 gửi 9432 để hủy dịch vụ. Trân trọng cảm ơn!',1,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-26 13:33:02','2017-02-26 13:33:02');
/*!40000 ALTER TABLE `history_20170226` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170227`
--

DROP TABLE IF EXISTS `history_20170227`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170227` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170227`
--

LOCK TABLES `history_20170227` WRITE;
/*!40000 ALTER TABLE `history_20170227` DISABLE KEYS */;
INSERT INTO `history_20170227` VALUES (3,'841225236968','9432','841225236968_1488132747071','ba7f39bd5db240ffb6d69b7234b80860','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-26 18:12:27','2017-02-26 18:12:27'),(6,'841225236968','9432','841225236968_1488132747076','f9112dabf3174ba8bd5c97e61c3ba411','CongTT','TC7','he thong tu dong gia han','(GH) B&#7841;n &#273;&#227; gia h&#7841;n th&#224;nh c&#244;ng g&#243;i c&#432;&#7899;c TC7 D&#7883;ch v&#7909;: DV Phong Th&#7911;y Ng&#361; H&#224;nh S&#7889; ti&#7873;n: 7.000 VN&#272; N&#7897;i dung: Giao d&#7883;ch gia h&#7841;n g&#243;i c&#432;&#7899;c th&#224;nh c&#244;ng.',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-26 18:12:27','2017-02-26 18:12:27'),(7,'841225236968','9432','841225236968_1488132747089','222e3ea2e8b84b178128107893dc7bba','CongTT','CT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-26 18:12:27','2017-02-26 18:12:27'),(8,'84904692232','9432','84904692232_1488132747094','49d2a8d1aa164d6e82973169cafdb16e','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-26 18:12:27','2017-02-26 18:12:27'),(9,'841225236968','9432','841225236968_1488157638167','','CongTT','TC7','','(GH) Bạn đã gia hạn thành công gói cước TC7 Dịch vụ: DV Phong Thủy Ngũ Hành Số tiền: 7.000 VNĐ Nội dung: Giao dịch gia hạn gói cước thành công.',4,'','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 01:07:18','2017-02-27 01:07:18'),(11,'84936016833','9432','84936016833_1488160740820','84936016833_1488160739492','CSKH','CT1','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i CT1 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; 2.000&#273;/ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n h&#224;ng ng&#224;y, so&#7841;n HUY CT1 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 01:59:00','2017-02-27 01:59:00'),(12,'84936016833','9432','84936016833_1488160749713','84936016833_1488160749659','CSKH','TC7','','(DK) Ch&#250;c m&#7915;ng Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i TC7 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh v&#224; &#273;&#432;&#7907;c MI&#7876;N PH&#205; 1 ng&#224;y s&#7917; d&#7909;ng d&#7883;ch v&#7909;. G&#243;i s&#7869; &#273;&#432;&#7907;c t&#7921; &#273;&#7897;ng gia h&#7841;n ngay sau khi h&#7871;t th&#7901;i gian mi&#7877;n ph&#237;, c&#432;&#7899;c s&#7917; d&#7909;ng l&#224;: 7.000&#273;/7ng&#224;y. So&#7841;n HUY TC7 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 01:59:09','2017-02-27 01:59:09'),(13,'84936016833','9432','84936016833_1488160756580','84936016833_1488160756521','CSKH','TC7','','G&#243;i TC7 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 01:59:16','2017-02-27 01:59:16'),(15,'84936016833','9432','84936016833_1488160766092','84936016833_1488160766027','CSKH','PT7','','(DK) Ch&#250;c m&#7915;ng Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i PT7 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh v&#224; &#273;&#432;&#7907;c MI&#7876;N PH&#205; 1 ng&#224;y s&#7917; d&#7909;ng d&#7883;ch v&#7909;. G&#243;i s&#7869; &#273;&#432;&#7907;c t&#7921; &#273;&#7897;ng gia h&#7841;n ngay sau khi h&#7871;t th&#7901;i gian mi&#7877;n ph&#237;, c&#432;&#7899;c s&#7917; d&#7909;ng l&#224;: 7.000&#273;/7ng&#224;y. So&#7841;n HUY PT7 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 01:59:26','2017-02-27 01:59:26'),(16,'84936016833','9432','84936016833_1488160777746','84936016833_1488160777687','CSKH','PT7','','G&#243;i PT7 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 01:59:37','2017-02-27 01:59:37'),(18,'84936016833','9432','84936016833_1488160788126','84936016833_1488160787857','CSKH','PT7','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i PT7 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; c&#432;&#7899;c 7.000&#273;/7ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n, so&#7841;n HUY PT7 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 01:59:48','2017-02-27 01:59:48'),(19,'84936016833','9432','84936016833_1488160820797','84936016833_1488160820749','CSKH','CT1','','G&#243;i CT1 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:00:20','2017-02-27 02:00:20'),(21,'84936016833','9432','84936016833_1488160830947','84936016833_1488160830849','CSKH','CT7','','(DK) Ch&#250;c m&#7915;ng Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i CT7 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh v&#224; &#273;&#432;&#7907;c MI&#7876;N PH&#205; 1 ng&#224;y s&#7917; d&#7909;ng d&#7883;ch v&#7909;. G&#243;i s&#7869; &#273;&#432;&#7907;c t&#7921; &#273;&#7897;ng gia h&#7841;n ngay sau khi h&#7871;t th&#7901;i gian mi&#7877;n ph&#237;, c&#432;&#7899;c s&#7917; d&#7909;ng l&#224;: 7.000&#273;/7ng&#224;y. So&#7841;n HUY CT7 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:00:30','2017-02-27 02:00:30'),(22,'84936016833','9432','84936016833_1488160837525','84936016833_1488160837480','CSKH','CT7','','G&#243;i CT7 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:00:37','2017-02-27 02:00:37'),(24,'84936016833','9432','84936016833_1488160845907','84936016833_1488160845734','CSKH','CT7','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i CT7 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; c&#432;&#7899;c 7.000&#273;/7ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n, so&#7841;n HUY CT7 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:00:45','2017-02-27 02:00:45'),(25,'84936016833','9432','84936016833_1488161273984','84936016833_1488161273925','CSKH','CT7','','G&#243;i CT7 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:07:53','2017-02-27 02:07:53'),(27,'84936016833','9432','84936016833_1488161282145','84936016833_1488161280173','CSKH','CT7','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i CT7 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; c&#432;&#7899;c 7.000&#273;/7ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n, so&#7841;n HUY CT7 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:08:02','2017-02-27 02:08:02'),(28,'84936016833','9432','84936016833_1488161292906','84936016833_1488161292634','CSKH','TC7','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i TC7 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; c&#432;&#7899;c 7.000&#273;/7ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n, so&#7841;n HUY TC7 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:08:12','2017-02-27 02:08:12'),(30,'84936016833','9432','84936016833_1488161305676','84936016833_1488161305637','CSKH','TC7','','G&#243;i TC7 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:08:25','2017-02-27 02:08:25'),(31,'84936016833','9432','84936016833_1488161311609','84936016833_1488161310837','CSKH','TC7','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i TC7 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; c&#432;&#7899;c 7.000&#273;/7ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n, so&#7841;n HUY TC7 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 02:08:31','2017-02-27 02:08:31'),(32,'84904869369','9432','84904869369_1488176067939','87ab6a55961a40a5ab34564269560bf0','SMS','PT1','Dk pt1','(DK) Chúc mừng quý khách đã đăng ký thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành và được MIỄN PHÍ 1 ngày sử dụng dịch vụ. Gói cước sẽ tự động gia hạn ngay sau khi hết thời gian miễn phí, cước sử dụng là 200đ/ngày. Soạn HUY PT1 gửi 9432 để hủy dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',1,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 06:14:27','2017-02-27 06:14:27'),(33,'84904869369','9432','84904869369_1488176103458','bd6782c798e64a9794d14c7f977acc2c','SMS','PT1','Huy pt1','Quý khách đã hủy thành công gói PT1 dịch vụ DV Phong Thủy Ngũ Hành. Để đăng ký lại soạn DK PT1 gửi 9432 hoặc PT gửi 9432. Cảm ơn Quý khách đã sử dụng dịch vụ. Chi tiet lien he. Trân trọng cảm ơn!',5,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 06:15:03','2017-02-27 06:15:03'),(34,'84936016833','9432','84936016833_1488184724006','84936016833_1488184723826','CSKH','TC7','','G&#243;i TC7 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 08:38:44','2017-02-27 08:38:44'),(35,'84936016833','9432','84936016833_1488184729665','84936016833_1488184729627','CSKH','CT7','','G&#243;i CT7 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 08:38:49','2017-02-27 08:38:49'),(37,'84936016833','9432','84936016833_1488184740138','84936016833_1488184738863','CSKH','CT1','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i CT1 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; 2.000&#273;/ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n h&#224;ng ng&#224;y, so&#7841;n HUY CT1 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 08:39:00','2017-02-27 08:39:00'),(38,'84936016833','9432','84936016833_1488184749490','84936016833_1488184749446','CSKH','CT1','','G&#243;i CT1 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 08:39:09','2017-02-27 08:39:09'),(40,'84936016833','9432','84936016833_1488184756415','84936016833_1488184756140','CSKH','CT1','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i CT1 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; 2.000&#273;/ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n h&#224;ng ng&#224;y, so&#7841;n HUY CT1 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 08:39:16','2017-02-27 08:39:16');
/*!40000 ALTER TABLE `history_20170227` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170228`
--

DROP TABLE IF EXISTS `history_20170228`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170228` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170228`
--

LOCK TABLES `history_20170228` WRITE;
/*!40000 ALTER TABLE `history_20170228` DISABLE KEYS */;
INSERT INTO `history_20170228` VALUES (3,'84904692232','9432','84904692232_1488218823826','7ba4de3533244b13ac21e29ae1cc6b74','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 18:07:04','2017-02-27 18:07:04'),(5,'841225236968','9432','841225236968_1488218824086','a1e93ea3486947ef8a6038b7b40385b9','CongTT','CT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 18:07:04','2017-02-27 18:07:04'),(8,'841225236968','9432','841225236968_1488218823866','8c673ce51f954e2aaf09afbb4a9bb3e2','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 18:07:04','2017-02-27 18:07:04'),(10,'84936016833','9432','84936016833_1488218824155','6063434977704cf39ba71fbd904244ae','CongTT','CT1','he thong tu dong gia han','',7,'WCG-0005','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-27 18:07:04','2017-02-27 18:07:04'),(11,'84936016833','9432','84936016833_1488240438001','eca2f94c49444b6a84199a7bd6f038be','CongTT','CT1','he thong tu dong gia han','',7,'WCG-0005','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 00:07:18','2017-02-28 00:07:18'),(13,'84936016833','9432','84936016833_1488247841203','84936016833_1488247839725','CSKH','PT1','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i PT1 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; 200&#273;/ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n h&#224;ng ng&#224;y, so&#7841;n HUY PT1 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 02:10:41','2017-02-28 02:10:41'),(15,'84936016833','9432','84936016833_1488247865303','84936016833_1488247865192','CSKH','PT1','','G&#243;i PT1 d&#7883;ch v&#7909; PTNH &#273;&#227; &#273;&#432;&#7907;c h&#7911;y theo y&#234;u c&#7847;u c&#7911;a qu&#253; kh&#225;ch. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',2,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 02:11:05','2017-02-28 02:11:05'),(16,'84936016833','9432','84936016833_1488247884460','84936016833_1488247883899','CSKH','PT1','','(DK) Qu&#253; kh&#225;ch &#273;&#227; &#273;&#259;ng k&#253; th&#224;nh c&#244;ng g&#243;i PT1 d&#7883;ch v&#7909; DV Phong Th&#7911;y Ng&#361; H&#224;nh. Gi&#225; 200&#273;/ng&#224;y, t&#7921; &#273;&#7897;ng gia h&#7841;n h&#224;ng ng&#224;y, so&#7841;n HUY PT1 g&#7917;i 9432 &#273;&#7875; h&#7911;y d&#7883;ch v&#7909;. Chi tiet lien he. Tr&#226;n tr&#7885;ng c&#7843;m &#417;n!',9,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 02:11:24','2017-02-28 02:11:24'),(29,'84936315768','9432','84936315768_1488269871502','64ef7b925a0744248892925fe0ad9246','SMS','ML','Ml','Cu phap Quy khach thuc hien chua dung. Soan HD hoac truy cap http://phongthuynguhanh.com.vn de xem huong han. Tran trong cam on!',3,'WCG-0000','2017-02-28 08:17:51','2017-02-28 08:17:51','2017-02-28 08:17:51','2017-02-28 08:17:51'),(31,'84936315768','9432','84936315768_1488269900639','f5763f45543145be875f63d6853d84ad','SMS','MK','Mk','mat khau truy cap website http://phongthuynguhanh.com.vn cua quy khach la: 41a586',3,'WCG-0000','2017-02-28 08:18:20','2017-02-28 08:18:20','2017-02-28 08:18:20','2017-02-28 08:18:20'),(33,'84936315768','9432','84936315768_1488270692249','56e4421a379d4b258cdc77c6a5c11f11','SMS','HD','Hd','Chao mung Quy khach den voi su tro giup cua dich vu Phong thuy ngu hanh. De dang ky dich vu, Quy khach vui long soan: DK PT gui 9432 de dang ky Phong thuy; Soan DK CT gui 9432 de dang ky Chiem tinh hoc; Soan DK TC gui 9432 de dang ky Tra Chanh 360;Soan DK VIP gui 9432 de dang ky dich vu Phong Thuy Ngu Hanh VIP. Neu Quy khach quen mat khau, soan MK gui 9432. Truy cap dia chi http://phongthuynguhanh.com.vn  de duoc huong dan cai dat ung dung. Chi tiet lien he <DT CSKH> (cuoc goi co dinh). Tran trong!',3,'WCG-0000','2017-02-28 08:31:32','2017-02-28 08:31:32','2017-02-28 08:31:32','2017-02-28 08:31:32'),(35,'84936315768','9432','84936315768_1488277090119','0.02866900 1488277087','WEB','PT1','','ĐK trên website http://phongthuynguhanh.com.vn',6,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 10:18:10','2017-02-28 10:18:10');
/*!40000 ALTER TABLE `history_20170228` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_20170301`
--

DROP TABLE IF EXISTS `history_20170301`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_20170301` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `source` varchar(100) DEFAULT '' COMMENT 'Gui MT tu kenh nao ?',
  `subCode` varchar(20) DEFAULT '' COMMENT 'chinh la subCode cong TT sync sang, nếu ko match với serviceID nào thì để = FORWARD',
  `mo` varchar(500) DEFAULT '' COMMENT 'msg user gui cho he thong - neu msg tu he thong gui thi MO = empty',
  `mt` varchar(1000) DEFAULT '' COMMENT 'msg hệ thống gửi cho user',
  `type` int(11) DEFAULT NULL,
  `errorcode` varchar(100) DEFAULT '',
  `sntdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'send date to smsc',
  `ack` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Ack Value recieve from SMSC',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionid` (`transactionid`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_20170301`
--

LOCK TABLES `history_20170301` WRITE;
/*!40000 ALTER TABLE `history_20170301` DISABLE KEYS */;
INSERT INTO `history_20170301` VALUES (3,'841225236968','9432','841225236968_1488305831864','0dfba437039845ec8362a2acc8a13c72','CongTT','CT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 18:17:12','2017-02-28 18:17:12'),(5,'84936016833','9432','84936016833_1488305832127','2ac1dad1dfca44f8b34f675a6005b4c1','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 18:17:12','2017-02-28 18:17:12'),(7,'841225236968','9432','841225236968_1488305832158','9b5d9e2b7d474ad7bc71e49f005bfa3e','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 18:17:12','2017-02-28 18:17:12'),(10,'84936016833','9432','84936016833_1488305831899','c271ebf6bb4042a28f31484d84454e8b','CongTT','CT1','he thong tu dong gia han','',7,'WCG-0005','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 18:17:12','2017-02-28 18:17:12'),(12,'84904692232','9432','84904692232_1488305832170','f723b04de0fa4f3ca2793c321241ff75','CongTT','PT1','he thong tu dong gia han','',7,'WCG-0000','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-02-28 18:17:12','2017-02-28 18:17:12'),(14,'84936016833','9432','84936016833_1488327463774','3770186edef4402bb9c83b6d3190b573','CongTT','CT1','he thong tu dong gia han','',7,'WCG-0005','0000-00-00 00:00:00','0000-00-00 00:00:00','2017-03-01 00:17:43','2017-03-01 00:17:43');
/*!40000 ALTER TABLE `history_20170301` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serviceCode` varchar(50) DEFAULT '' COMMENT 'mã dịch vụ / nội dung - cổng TT sẽ define',
  `subCode` varchar(50) DEFAULT '' COMMENT 'mã gói cước - cổng TT define',
  `subkeywork` varchar(50) DEFAULT '' COMMENT 'subkeywork khi đk dịch vụ',
  `contentid` varchar(20) DEFAULT NULL COMMENT 'contentID cua dich vu, dung cho day file CDR',
  `cateid` varchar(20) DEFAULT NULL COMMENT 'cateID cua dich vu, dung cho day file CDR',
  `amount` int(11) DEFAULT '0' COMMENT 'số tiền gói dịch vụ cung cấp, amount=0 là free',
  `status` int(11) DEFAULT '0' COMMENT 'trạng thái dịch vụ, 0 là disable, 1 là enable',
  `type` int(4) DEFAULT '0' COMMENT 'kiểu dịch vụ- 0 - daily, 1- weekly, null là ko có kiểu.',
  `circle` int(4) DEFAULT '1' COMMENT 'so ngay su dung dich vu',
  `msg` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serviceCode_subCode` (`serviceCode`,`subCode`),
  KEY `id` (`id`,`subCode`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'PhongThuyNgay','PT1','PT,PHONGTHUY,NGUHANH, PHONG,THUY','000001','000001',2000,1,0,1,''),(2,'ChiemTinhNgay','CT1','TUVI,XEM,CHIEMTINH,LS,TV','000002','000001',2000,1,0,1,''),(3,'TraChanhNgay','TC1','TRACHANH,TC360,HAI,TRA,TC','000003','000001',2000,1,0,1,''),(5,'Vip','VIP','VIP7,D7,VP7','000005','000001',3000,1,0,1,''),(6,'MK','MK','',NULL,NULL,0,1,NULL,1,'Moi ban truy cap http://phongthuynguhanh.com.vn de su dung DV <ten goi>, user truy cap: <msisdn>, mat khau: <password>. Chi tiet <dt cskh>'),(7,'TG','TG','',NULL,NULL,0,1,0,1,'nhan tin : Moi ban truy cap http://phongthuynguhanh.com.vn Soan DK PT gui 9432 de dang ky Phong thuy; Soan DK CT gui 9432 de dang ky Chiem tinh hoc; Soan DK TC gui 9432 de dang ky Tra Chanh 360; Soan DK VIP gui 9432 de dang ky dich vu Phong Thuy Ngu Hanh VIP. Soan MK de lay lai mat khau truy cap. Chi tiet <dt cskh>'),(8,'HD','HD','',NULL,NULL,0,0,0,1,'Chao mung Quy khach den voi su tro giup cua dich vu Phong thuy ngu hanh. De dang ky dich vu, Quy khach vui long soan: DK PT gui 9432 de dang ky Phong thuy; Soan DK CT gui 9432 de dang ky Chiem tinh hoc; Soan DK TC gui 9432 de dang ky Tra Chanh 360;Soan DK VIP gui 9432 de dang ky dich vu Phong Thuy Ngu Hanh VIP. Neu Quy khach quen mat khau, soan MK gui 9432. Truy cap dia chi http://phongthuynguhanh.com.vn  de duoc huong dan cai dat ung dung. Chi tiet lien he <DT CSKH> (cuoc goi co dinh). Tran trong!'),(9,'WRONG','WRONG','',NULL,NULL,0,0,0,1,'Cu phap Quy khach thuc hien chua dung. Xem huong dan soan HD gui 9432. Chi tiet truy cap http://phongthuynguhanh.com.vn  hoac lien he <DT CSKH> (c uoc goi co dinh). Tran trong cam on!'),(10,'UNREG','UNREG','',NULL,NULL,0,0,0,1,'Quy khach chua dang ky dich vu Phong Thủy Ngũ Hành. Moi ban truy cap dia chi http://phongthuynguhanh.com.vn va lam theo huong dan. Chi tiet lien he <DT CSKH> (cuoc goi co dinh). Tran trong cam on!'),(11,'PhongThuyTuan','PT7','','000004','000001',7000,1,1,7,''),(12,'ChiemTinhTuan','CT7','','000006','000001',7000,1,1,7,''),(13,'TraChanhTuan','TC7','','000007','000001',7000,1,1,7,'');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userbases`
--

DROP TABLE IF EXISTS `userbases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userbases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT '' COMMENT 'số đt của user',
  `requestid` varchar(50) DEFAULT '' COMMENT 'auto gen',
  `transactionid` varchar(100) DEFAULT '' COMMENT 'transactionID từ cổng TT',
  `shortcode` varchar(20) DEFAULT '9432' COMMENT 'đầu số của dịch vụ',
  `subCode` varchar(20) DEFAULT '' COMMENT 'subCode tu cong TT, la dịch vụ mà user dùng',
  `errorCode` varchar(100) DEFAULT 'WCG-0000' COMMENT 'mã lỗi khi cổng TT xử lý request từ client, default là thành công',
  `source` varchar(100) DEFAULT '' COMMENT 'user đăng ký từ kênh nào - tu cong TT la SMS, tu WEB, tu CSKH',
  `trialdays` int(11) DEFAULT '1' COMMENT 'số ngày dùng thử',
  `type` int(11) DEFAULT '0' COMMENT 'truong nay de sau',
  `status` int(11) DEFAULT '0' COMMENT '1 - dang ky moi, 2 - dang ky lai, 3 - huy',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ngày user đăng ký dịch vụ',
  `lastchargedate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'ngày cuối cùng renew user',
  `enddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'ngay het han cua user',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `msisdn_subCode` (`msisdn`,`subCode`),
  KEY `id` (`id`,`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userbases`
--

LOCK TABLES `userbases` WRITE;
/*!40000 ALTER TABLE `userbases` DISABLE KEYS */;
INSERT INTO `userbases` VALUES (21,'841225236968','841225236968_1488305832158','9b5d9e2b7d474ad7bc71e49f005bfa3e','9432','PT1','WCG-0000','CongTT',1,0,4,'2017-02-22 09:46:39','2017-02-28 18:09:51','2017-03-01 18:09:51','2017-02-28 18:17:12'),(26,'84936315768','84936315768_1487926791444','84936315768_1487926791383','9432','PT1','WCG-0000','CSKH',1,0,3,'2017-02-23 03:57:02','2017-02-24 08:59:28','2017-02-25 08:59:22','2017-03-01 02:23:09'),(27,'84904320133','84904320133_1487822562244','fb30090861ce432b97241fed2081d53e','9432','PT1','WCG-0000','SMS',1,0,3,'2017-02-23 04:01:22','2017-02-23 04:01:22','2017-02-24 04:01:22','2017-03-01 02:20:25'),(31,'84936016833','84936016833_1488305832127','2ac1dad1dfca44f8b34f675a6005b4c1','9432','PT1','WCG-0000','CongTT',1,0,4,'2017-02-23 04:23:09','2017-02-28 18:08:51','2017-03-01 18:08:51','2017-02-28 18:17:12'),(32,'84904320133','84904320133_1487823872024','13f0a7cac45848288acc6ac822b06122','9432','CT1','WCG-0000','SMS',1,0,3,'2017-02-23 04:23:44','2017-02-23 04:01:22','2017-02-24 04:01:22','2017-03-01 02:21:34'),(40,'84904692232','84904692232_1488305832170','f723b04de0fa4f3ca2793c321241ff75','9432','PT1','WCG-0000','CongTT',1,0,4,'2017-02-23 18:25:25','2017-02-28 18:09:25','2017-03-01 18:09:25','2017-02-28 18:17:12'),(51,'841225236968','841225236968_1488305831864','0dfba437039845ec8362a2acc8a13c72','9432','CT1','WCG-0000','CongTT',1,0,4,'2017-02-26 13:32:40','2017-02-28 18:08:50','2017-03-01 18:08:50','2017-02-28 18:17:12'),(52,'841225236968','841225236968_1488132747076','f9112dabf3174ba8bd5c97e61c3ba411','9432','TC7','WCG-0000','CongTT',1,0,4,'2017-02-26 13:33:02','2017-02-26 18:12:27','2017-03-05 18:12:27','2017-03-01 03:16:32'),(57,'84936016833','84936016833_1488327463774','3770186edef4402bb9c83b6d3190b573','9432','CT1','WCG-0005','CongTT',1,0,4,'2017-02-27 01:59:00','2017-02-27 08:39:16','2017-02-28 08:39:27','2017-03-01 03:17:36'),(58,'84936016833','84936016833_1488184724006','84936016833_1488184723826','9432','TC7','WCG-0000','CSKH',1,0,3,'2017-02-27 01:59:09','2017-02-27 02:08:31','2017-03-06 02:08:27','2017-03-01 03:18:14'),(61,'84936016833','84936016833_1488160788126','84936016833_1488160787857','9432','PT7','WCG-0000','CSKH',1,0,2,'2017-02-27 01:59:26','2017-02-27 01:59:48','2017-03-06 01:59:27','2017-03-01 03:18:35'),(65,'84936016833','84936016833_1488184729665','84936016833_1488184729627','9432','CT7','WCG-0000','CSKH',1,0,3,'2017-02-27 02:00:30','2017-02-27 02:08:02','2017-03-06 02:08:27','2017-03-01 03:18:51'),(74,'84904869369','84904869369_1488176103458','bd6782c798e64a9794d14c7f977acc2c','9432','PT1','WCG-0000','SMS',1,0,3,'2017-02-27 06:14:27','2017-02-27 06:14:27','2017-02-28 06:14:27','2017-03-01 03:19:28');
/*!40000 ALTER TABLE `userbases` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-01 10:28:30
