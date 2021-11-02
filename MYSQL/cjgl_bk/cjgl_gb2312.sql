-- MySQL dump 10.10
--
-- Host: localhost    Database: cjgl
-- ------------------------------------------------------
-- Server version	5.0.22-community-nt

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
-- Table structure for table `cj`
--

DROP TABLE IF EXISTS `cj`;
CREATE TABLE `cj` (
  `学号` char(6) NOT NULL,
  `课程号` char(3) NOT NULL,
  `成绩` decimal(3,1) default NULL,
  PRIMARY KEY  (`学号`,`课程号`),
  KEY `fk_kch` (`课程号`),
  CONSTRAINT `fk_kch` FOREIGN KEY (`课程号`) REFERENCES `kc` (`课程号`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xh` FOREIGN KEY (`学号`) REFERENCES `xs` (`学号`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

--
-- Dumping data for table `cj`
--


/*!40000 ALTER TABLE `cj` DISABLE KEYS */;
LOCK TABLES `cj` WRITE;
INSERT INTO `cj` VALUES ('001101','101','80.0'),('001101','102','78.0'),('001101','206','76.0'),('001102','102','78.0'),('001102','206','78.0'),('001103','101','62.0'),('001103','102','70.0'),('001103','206','81.0'),('001104','101','65.0'),('001104','102','84.0'),('001104','206','65.0'),('001104','301','78.0'),('001106','101','65.0'),('001106','102','71.0'),('001106','206','80.0'),('001107','101','78.0'),('001107','102','80.0'),('001107','206','68.0'),('001108','101','85.0'),('001108','102','64.0'),('001108','206','44.0'),('001109','101','66.0'),('001109','102','83.0'),('001109','206','70.0'),('001110','101','95.0'),('001110','102','95.0'),('001113','102','79.0'),('001210','206','76.0'),('001221','101','63.0'),('001409','206','60.0'),('001505','101','98.0'),('001505','208','85.0');
UNLOCK TABLES;
/*!40000 ALTER TABLE `cj` ENABLE KEYS */;

--
-- Table structure for table `kc`
--

DROP TABLE IF EXISTS `kc`;
CREATE TABLE `kc` (
  `课程号` char(3) NOT NULL,
  `课程名` varchar(20) NOT NULL,
  `开课学期` tinyint(3) unsigned NOT NULL default '1',
  `学分` tinyint(3) unsigned default NULL,
  PRIMARY KEY  (`课程号`),
  UNIQUE KEY `课程名` (`课程名`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

--
-- Dumping data for table `kc`
--


/*!40000 ALTER TABLE `kc` DISABLE KEYS */;
LOCK TABLES `kc` WRITE;
INSERT INTO `kc` VALUES ('101','计算机基础',1,3),('102','c语言',1,3),('206','高等数学',3,3),('208','数据结构',5,6),('209','操作系统',6,3),('210','计算机组装',4,4),('212','ORACLE数据库',6,5),('301','计算机网络',2,4),('302','软件工程',6,2);
UNLOCK TABLES;
/*!40000 ALTER TABLE `kc` ENABLE KEYS */;

--
-- Table structure for table `xs`
--

DROP TABLE IF EXISTS `xs`;
CREATE TABLE `xs` (
  `学号` char(6) NOT NULL,
  `姓名` char(8) NOT NULL,
  `专业名` varchar(20) default NULL,
  `性别` char(2) NOT NULL default '男',
  `出生时间` date default NULL,
  `总学分` smallint(6) default NULL,
  `备注` text,
  PRIMARY KEY  (`学号`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

--
-- Dumping data for table `xs`
--


/*!40000 ALTER TABLE `xs` DISABLE KEYS */;
LOCK TABLES `xs` WRITE;
INSERT INTO `xs` VALUES ('001101','王金华','软件技术','男','1990-02-10',NULL,NULL),('001102','程周杰','软件技术','男','1991-02-01',NULL,NULL),('001103','王元','软件技术','男','1989-10-06',NULL,NULL),('001104','严蔚敏','信息管理','女','1990-08-26',NULL,NULL),('001106','李伟','软件技术','男','1988-09-07',NULL,NULL),('001107','刘超','软件技术','男','1983-01-01',NULL,NULL),('001108','李明','软件技术','男','1990-05-01',NULL,NULL),('001109','张飞','软件技术','女','1989-08-11',NULL,NULL),('001110','张晓晖','软件技术','女','1991-07-22',NULL,'三好学生'),('001111','胡恒','软件技术','男','1990-03-18',NULL,NULL),('001113','马妮啦','软件技术','女','1989-08-11',NULL,'有一门课不及格'),('001201','王稼祥','网络技术','男','1988-06-10',NULL,NULL),('001210','李长江','网络技术','男','1989-05-01',NULL,'已提前修完一门课'),('001216','孙楠楠','网络技术','女','1988-03-09',NULL,NULL),('001218','廖成','网络技术','男','1980-01-02',NULL,NULL),('001220','吴莉丽','建筑智能','女','1989-11-12',NULL,NULL),('001221','刘敏','建筑智能','女','1990-03-18',NULL,NULL),('001409','李天飞','软件技术','男','1987-03-02',NULL,NULL),('001505','白天东','信息管理','男','1999-01-03',NULL,NULL),('001601','高真理','建筑智能','男','1993-02-05',NULL,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `xs` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

