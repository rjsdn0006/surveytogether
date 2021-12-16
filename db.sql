-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.4-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- surveytogether 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `surveytogether` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;
USE `surveytogether`;

-- 테이블 surveytogether.spring_session 구조 내보내기
CREATE TABLE IF NOT EXISTS `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 surveytogether.spring_session:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
INSERT INTO `spring_session` (`PRIMARY_ID`, `SESSION_ID`, `CREATION_TIME`, `LAST_ACCESS_TIME`, `MAX_INACTIVE_INTERVAL`, `EXPIRY_TIME`, `PRINCIPAL_NAME`) VALUES
	('74a314b5-6781-4267-a233-9e63e97e9a62', 'ce744cfc-422b-4614-81fd-d7dc80d74ec2', 1639643353615, 1639643378032, 7200, 1639650578032, NULL);
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;

-- 테이블 surveytogether.spring_session_attributes 구조 내보내기
CREATE TABLE IF NOT EXISTS `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 surveytogether.spring_session_attributes:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;

-- 테이블 surveytogether.tb_answer 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_answer` (
  `an_idx` int(10) NOT NULL AUTO_INCREMENT,
  `an_writer` varchar(20) NOT NULL,
  `an_question_idx` int(10) NOT NULL,
  `an_string_answer` varchar(1000) DEFAULT NULL,
  `an_select_answer` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`an_idx`),
  KEY `tb_answer_ibfk_1` (`an_writer`),
  KEY `tb_answer_ibfk_2` (`an_question_idx`),
  CONSTRAINT `tb_answer_ibfk_1` FOREIGN KEY (`an_writer`) REFERENCES `tb_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tb_answer_ibfk_2` FOREIGN KEY (`an_question_idx`) REFERENCES `tb_question` (`qu_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_answer:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_answer` ENABLE KEYS */;

-- 테이블 surveytogether.tb_auth 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_auth` (
  `id` varchar(50) NOT NULL,
  `auth` varchar(200) NOT NULL,
  PRIMARY KEY (`id`,`auth`),
  CONSTRAINT `tb_auth_ibfk_1` FOREIGN KEY (`id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_auth:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_auth` DISABLE KEYS */;
INSERT INTO `tb_auth` (`id`, `auth`) VALUES
	('user', 'ROLE_USER');
/*!40000 ALTER TABLE `tb_auth` ENABLE KEYS */;

-- 테이블 surveytogether.tb_question 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_question` (
  `qu_idx` int(10) NOT NULL AUTO_INCREMENT,
  `qu_survey_idx` int(10) NOT NULL,
  `qu_title` varchar(100) NOT NULL,
  `qu_format` varchar(100) NOT NULL,
  PRIMARY KEY (`qu_idx`) USING BTREE,
  KEY `FK_tb_question_tb_survey` (`qu_survey_idx`) USING BTREE,
  CONSTRAINT `FK_tb_question_tb_survey` FOREIGN KEY (`qu_survey_idx`) REFERENCES `tb_survey` (`su_idx`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_question:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_question` DISABLE KEYS */;
INSERT INTO `tb_question` (`qu_idx`, `qu_survey_idx`, `qu_title`, `qu_format`) VALUES
	(9, 18, '하고싶은말 적으시오', 'longSentence'),
	(15, 48, '무슨 질문을할까', 'shortSentence'),
	(22, 49, '좋아하는 계절은?', 'multipleChoice'),
	(23, 49, '체크박스테스트', 'checkBox'),
	(24, 49, '단답형 질문테스트', 'shortSentence'),
	(25, 49, '드롭다운 질문테스트', 'dropDown');
/*!40000 ALTER TABLE `tb_question` ENABLE KEYS */;

-- 테이블 surveytogether.tb_question_option 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_question_option` (
  `op_idx` int(10) NOT NULL AUTO_INCREMENT,
  `op_question_idx` int(10) NOT NULL,
  `op_name` varchar(200) NOT NULL,
  PRIMARY KEY (`op_idx`) USING BTREE,
  KEY `question_idx` (`op_question_idx`) USING BTREE,
  CONSTRAINT `tb_question_option_ibfk_1` FOREIGN KEY (`op_question_idx`) REFERENCES `tb_question` (`qu_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_question_option:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_question_option` DISABLE KEYS */;
INSERT INTO `tb_question_option` (`op_idx`, `op_question_idx`, `op_name`) VALUES
	(38, 22, '봄'),
	(39, 22, '여름'),
	(40, 22, '가을'),
	(41, 22, '겨울'),
	(42, 23, '이게되나'),
	(43, 23, '되네'),
	(44, 23, '왜지'),
	(45, 25, '1번'),
	(46, 25, '2번');
/*!40000 ALTER TABLE `tb_question_option` ENABLE KEYS */;

-- 테이블 surveytogether.tb_select_answer 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_select_answer` (
  `sela_idx` int(10) NOT NULL AUTO_INCREMENT,
  `sela_question_idx` int(10) NOT NULL,
  `sela_writer` varchar(20) NOT NULL,
  `sela_answer` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`sela_idx`),
  KEY `tb_select_answer_ibfk_1` (`sela_writer`),
  KEY `tb_select_answer_ibfk_2` (`sela_question_idx`),
  CONSTRAINT `tb_select_answer_ibfk_1` FOREIGN KEY (`sela_writer`) REFERENCES `tb_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tb_select_answer_ibfk_2` FOREIGN KEY (`sela_question_idx`) REFERENCES `tb_question` (`qu_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_select_answer:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_select_answer` DISABLE KEYS */;
INSERT INTO `tb_select_answer` (`sela_idx`, `sela_question_idx`, `sela_writer`, `sela_answer`) VALUES
	(2, 25, 'user', '2번'),
	(3, 25, 'user', '1번'),
	(4, 22, 'user', '여름'),
	(5, 23, 'user', '이게되나');
/*!40000 ALTER TABLE `tb_select_answer` ENABLE KEYS */;

-- 테이블 surveytogether.tb_string_answer 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_string_answer` (
  `stra_idx` int(10) NOT NULL AUTO_INCREMENT,
  `stra_question_idx` int(10) NOT NULL,
  `stra_writer` varchar(20) NOT NULL,
  `stra_answer` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`stra_idx`),
  KEY `tb_stirng_answer_ibfk_1` (`stra_writer`),
  KEY `tb_stirng_answer_ibfk_2` (`stra_question_idx`),
  CONSTRAINT `tb_string_answer_ibfk_1` FOREIGN KEY (`stra_writer`) REFERENCES `tb_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tb_string_answer_ibfk_2` FOREIGN KEY (`stra_question_idx`) REFERENCES `tb_question` (`qu_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_string_answer:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_string_answer` DISABLE KEYS */;
INSERT INTO `tb_string_answer` (`stra_idx`, `stra_question_idx`, `stra_writer`, `stra_answer`) VALUES
	(1, 24, 'user', '123'),
	(2, 24, 'user', '456');
/*!40000 ALTER TABLE `tb_string_answer` ENABLE KEYS */;

-- 테이블 surveytogether.tb_survey 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_survey` (
  `su_idx` int(10) NOT NULL AUTO_INCREMENT,
  `su_writer` varchar(20) NOT NULL,
  `su_title` varchar(100) NOT NULL,
  `su_desc` varchar(1000) DEFAULT NULL,
  `su_create_time` datetime DEFAULT current_timestamp(),
  `su_update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`su_idx`) USING BTREE,
  KEY `FK_tb_survey_tb_user` (`su_writer`) USING BTREE,
  CONSTRAINT `FK_tb_survey_tb_user` FOREIGN KEY (`su_writer`) REFERENCES `tb_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_survey:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_survey` DISABLE KEYS */;
INSERT INTO `tb_survey` (`su_idx`, `su_writer`, `su_title`, `su_desc`, `su_create_time`, `su_update_time`) VALUES
	(18, 'user', '하고싶은말 ', '하고싶은말을 적으시오', '2021-12-14 11:16:11', NULL),
	(22, 'user', '하고싶은말 ', NULL, '2021-12-16 09:08:58', NULL),
	(23, 'user', '하고싶은말 ', NULL, '2021-12-16 09:08:59', NULL),
	(24, 'user', '하고싶은말 ', NULL, '2021-12-16 09:08:59', NULL),
	(26, 'user', '하고싶은말 ', NULL, '2021-12-16 09:08:59', NULL),
	(48, 'user', '해야했던말', '생각이안나', '2021-12-16 10:08:03', NULL),
	(49, 'user', '객관식 테스트', '객관식 테스트중 ', '2021-12-16 10:25:23', '2021-12-16 11:04:46');
/*!40000 ALTER TABLE `tb_survey` ENABLE KEYS */;

-- 테이블 surveytogether.tb_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_user` (
  `id` varchar(20) NOT NULL COMMENT '아이디',
  `password` varchar(200) DEFAULT NULL COMMENT '비밀번호',
  `name` varchar(20) DEFAULT NULL COMMENT '이름',
  `register_date` date DEFAULT current_timestamp() COMMENT '가입일',
  `isAccountNonExpired` tinyint(4) DEFAULT NULL COMMENT '계정 만료여부',
  `isAccountNonLocked` tinyint(4) DEFAULT NULL COMMENT '패스워드 만료여부',
  `isCredentialsNonExpired` tinyint(4) DEFAULT NULL COMMENT '계정 잠김여부',
  `isEnabled` tinyint(4) DEFAULT NULL COMMENT '계정 유효여부',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_user:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` (`id`, `password`, `name`, `register_date`, `isAccountNonExpired`, `isAccountNonLocked`, `isCredentialsNonExpired`, `isEnabled`) VALUES
	('user', '$2a$10$f7uKmqvzVqFtTm4S5UnC6.vEzV9Z2b9EjkuHk3fLj4Aji/J1WUtge', '김건우', '2021-12-09', 1, 1, 1, 1);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
