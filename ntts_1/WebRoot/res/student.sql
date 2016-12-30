/*
Navicat MySQL Data Transfer

Source Server         : com.mysql.jdbc.Driver
Source Server Version : 50626
Source Host           : localhost:3306
Source Database       : student

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2016-12-30 15:39:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for baoming_info
-- ----------------------------
DROP TABLE IF EXISTS `baoming_info`;
CREATE TABLE `baoming_info` (
  `idCard` varchar(255) NOT NULL,
  `firstKind` varchar(255) DEFAULT NULL,
  `secondKind` varchar(255) DEFAULT NULL,
  `whetherPay` varchar(255) DEFAULT NULL,
  `whetherInformation` varchar(255) DEFAULT NULL,
  `classInfo` varchar(255) DEFAULT NULL,
  `remarkInfo` varchar(255) DEFAULT NULL,
  `baomingdate` date DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pk_idCard` (`idCard`),
  CONSTRAINT `pk_idCard` FOREIGN KEY (`idCard`) REFERENCES `base_info` (`idCard`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of baoming_info
-- ----------------------------
INSERT INTO `baoming_info` VALUES ('310229199310151814', '100309', '100310', '1', '1', null, '', '2016-12-30', '11');

-- ----------------------------
-- Table structure for base_info
-- ----------------------------
DROP TABLE IF EXISTS `base_info`;
CREATE TABLE `base_info` (
  `idCard` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `birthdate` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `writedate` date DEFAULT NULL,
  PRIMARY KEY (`idCard`),
  KEY `idCard` (`idCard`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_info
-- ----------------------------
INSERT INTO `base_info` VALUES ('310229199310151814', '行', '23', '19931015', '1', '上海', '15000614376', '2016-12-30');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', '1', null);
