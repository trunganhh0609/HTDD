-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.21-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for attendance
CREATE DATABASE IF NOT EXISTS `attendance` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `attendance`;

-- Dumping structure for table attendance.attendance
CREATE TABLE IF NOT EXISTS `attendance` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `CLASS_ID` int(11) DEFAULT NULL,
  `LESSON` int(11) DEFAULT NULL,
  `DEVICE_ID` varchar(100) DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `CREATED_DATE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_attendance_comm_code` (`STATUS`),
  KEY `FK_attendance_user` (`USER_ID`),
  KEY `FK_attendance_class` (`CLASS_ID`),
  CONSTRAINT `FK_attendance_class` FOREIGN KEY (`CLASS_ID`) REFERENCES `class` (`CLASS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_attendance_comm_code` FOREIGN KEY (`STATUS`) REFERENCES `comm_code` (`COMM_CODE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_attendance_user` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table attendance.attendance: ~0 rows (approximately)
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;

-- Dumping structure for table attendance.class
CREATE TABLE IF NOT EXISTS `class` (
  `CLASS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CLASS_CODE` varchar(50) DEFAULT NULL,
  `CLASS_NAME` varchar(50) DEFAULT NULL,
  `START_DATE` datetime DEFAULT NULL,
  `END_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`CLASS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table attendance.class: ~1 rows (approximately)
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` (`CLASS_ID`, `CLASS_CODE`, `CLASS_NAME`, `START_DATE`, `END_DATE`) VALUES
	(1, 'LTHDT1', 'Lập trình hướng đối tượng', '2023-10-10 19:49:35', '2024-01-10 19:49:46'),
	(2, 'LTNC', 'Lập trình nâng cao', '2023-10-10 20:09:46', '2024-01-11 20:09:50');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;

-- Dumping structure for table attendance.comm_code
CREATE TABLE IF NOT EXISTS `comm_code` (
  `COMM_CODE` varchar(10) NOT NULL,
  `COMM_NAME` varchar(100) DEFAULT NULL,
  `PARENT` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`COMM_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table attendance.comm_code: ~5 rows (approximately)
/*!40000 ALTER TABLE `comm_code` DISABLE KEYS */;
INSERT INTO `comm_code` (`COMM_CODE`, `COMM_NAME`, `PARENT`) VALUES
	('01', 'Trạng thái điểm danh', NULL),
	('01-01', 'Chưa điểm danh', '01'),
	('01-02', 'Đã điểm danh', '01'),
	('01-03', 'Đi muộn', '01'),
	('01-04', 'Nghỉ học', '01');
/*!40000 ALTER TABLE `comm_code` ENABLE KEYS */;

-- Dumping structure for table attendance.point
CREATE TABLE IF NOT EXISTS `point` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(50) DEFAULT NULL,
  `CLASS_ID` varchar(50) DEFAULT NULL,
  `SUBJECT_ID` varchar(50) DEFAULT NULL,
  `POINT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=449 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table attendance.point: ~12 rows (approximately)
/*!40000 ALTER TABLE `point` DISABLE KEYS */;
INSERT INTO `point` (`ID`, `USER_ID`, `CLASS_ID`, `SUBJECT_ID`, `POINT`) VALUES
	(437, '705112003', '85943', '9560', 10),
	(438, '705112004', '85943', '9560', 10),
	(439, '705112001', '85943', '9560', 10),
	(440, '705112002', '85943', '9560', 10),
	(441, '705112006', '85943', '9560', 10),
	(442, '705112008', '85943', '9560', 10),
	(443, '705112010', '85943', '9560', 10),
	(444, '705112011', '85943', '9560', 10),
	(445, '705112013', '85943', '9560', 10),
	(446, '705112015', '85943', '9560', 10),
	(447, '705112016', '85943', '9560', 10),
	(448, '705112018', '85943', '9560', 10);
/*!40000 ALTER TABLE `point` ENABLE KEYS */;

-- Dumping structure for table attendance.user
CREATE TABLE IF NOT EXISTS `user` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(200) DEFAULT NULL,
  `NAME` varchar(200) DEFAULT NULL,
  `PASSWORD` varchar(200) DEFAULT NULL,
  `BIRTH_DATE` datetime DEFAULT NULL,
  `GENDER` bit(1) DEFAULT NULL,
  `ROLE_ID` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `EMAIL_VERIFY_KEY` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  KEY `ROLE_ID` (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table attendance.user: ~3 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`USER_ID`, `USER_NAME`, `NAME`, `PASSWORD`, `BIRTH_DATE`, `GENDER`, `ROLE_ID`, `EMAIL`, `EMAIL_VERIFY_KEY`) VALUES
	(1, 'gv1', 'Nguyễn Thị Hồng', '$2a$10$Qh2Gi3w4tT3klKIYazWvu.84Qkjj1QV1leeV98Tado5FhxjBnUFEK', '2022-12-15 22:52:53', b'1', 'ROLE002', NULL, NULL),
	(2, '695105008', 'Nguyễn Văn Nam', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(5, 'admin', 'Nguyễn Trung Anh', '$2a$10$Qh2Gi3w4tT3klKIYazWvu.84Qkjj1QV1leeV98Tado5FhxjBnUFEK', '2001-09-05 00:00:00', b'1', 'ROLE001', NULL, NULL),
	(6, '695105009', 'Nguyễn Việt Anh', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(7, '695105010', 'Trần Thị Ánh', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(8, '695105011', 'Nguyễn Tuấn Anh', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(9, '695105012', 'Trần Văn Hùng', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(10, '695105013', 'Hoàng Văn Nam', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(11, '695105014', 'Đinh Việt Hoàng', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(12, '695105015', 'Trần Quốc Tuấn', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(13, '695105016', 'Tạ Văn Nam', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(14, '695105017', 'Vũ Tiến Long', '$2a$10$dt57pi5QQYqPKxvXaBWK/ef6CrNiW93/KqZcw.IseOnclR8voEf5i', '2022-12-10 20:04:54', b'1', 'ROLE003', NULL, NULL),
	(15, 'gv2', 'Nguyễn Văn Tuấn', '$2a$10$Qh2Gi3w4tT3klKIYazWvu.84Qkjj1QV1leeV98Tado5FhxjBnUFEK', '2022-12-15 22:52:53', b'1', 'ROLE002', NULL, NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table attendance.user_class
CREATE TABLE IF NOT EXISTS `user_class` (
  `CLASS_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  PRIMARY KEY (`CLASS_ID`,`USER_ID`),
  KEY `FK_user_class_user` (`USER_ID`),
  CONSTRAINT `FK_user_class_class` FOREIGN KEY (`CLASS_ID`) REFERENCES `class` (`CLASS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_user_class_user` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table attendance.user_class: ~2 rows (approximately)
/*!40000 ALTER TABLE `user_class` DISABLE KEYS */;
INSERT INTO `user_class` (`CLASS_ID`, `USER_ID`) VALUES
	(1, 1),
	(1, 2),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(1, 10),
	(2, 6),
	(2, 11),
	(2, 12),
	(2, 13),
	(2, 14),
	(2, 15);
/*!40000 ALTER TABLE `user_class` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
