-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.3-MariaDB - mariadb.org binary distribution
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
	('6ff34c60-8a7b-4d9b-bda0-03d70bd9fa7c', '9634cbb3-356a-40c3-bc28-a97c2915cb6b', 1639966710153, 1639966710174, 7200, 1639973910174, NULL);
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;

-- 테이블 surveytogether.spring_session_attributes 구조 내보내기
CREATE TABLE IF NOT EXISTS `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 surveytogether.spring_session_attributes:~0 rows (대략적) 내보내기
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

-- 테이블 데이터 surveytogether.tb_auth:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_auth` DISABLE KEYS */;
INSERT INTO `tb_auth` (`id`, `auth`) VALUES
	('user', 'ROLE_USER'),
	('user2', 'ROLE_USER');
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_question:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_question` DISABLE KEYS */;
INSERT INTO `tb_question` (`qu_idx`, `qu_survey_idx`, `qu_title`, `qu_format`) VALUES
	(33, 51, '좋아하는 영화장르는?', 'checkBox'),
	(34, 51, '왜 그 장르를 좋아합니까? ', 'shortSentence'),
	(35, 50, '가장 좋아하는 계절은?', 'multipleChoice'),
	(36, 50, '이유는 무엇입니까?', 'shortSentence');
/*!40000 ALTER TABLE `tb_question` ENABLE KEYS */;

-- 테이블 surveytogether.tb_question_option 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_question_option` (
  `op_idx` int(10) NOT NULL AUTO_INCREMENT,
  `op_question_idx` int(10) NOT NULL,
  `op_name` varchar(200) NOT NULL,
  PRIMARY KEY (`op_idx`) USING BTREE,
  KEY `question_idx` (`op_question_idx`) USING BTREE,
  CONSTRAINT `tb_question_option_ibfk_1` FOREIGN KEY (`op_question_idx`) REFERENCES `tb_question` (`qu_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_question_option:~8 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_question_option` DISABLE KEYS */;
INSERT INTO `tb_question_option` (`op_idx`, `op_question_idx`, `op_name`) VALUES
	(63, 33, '호러'),
	(64, 33, '로맨스'),
	(65, 33, '코미디'),
	(66, 33, '판타지'),
	(67, 35, '봄'),
	(68, 35, '여름'),
	(69, 35, '가을'),
	(70, 35, '겨울');
/*!40000 ALTER TABLE `tb_question_option` ENABLE KEYS */;

-- 테이블 surveytogether.tb_result 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_result` (
  `re_su_idx` int(10) NOT NULL,
  `re_qu_idx` int(10) NOT NULL,
  `re_idx` int(10) NOT NULL,
  `re_answer` varchar(1000) NOT NULL,
  PRIMARY KEY (`re_su_idx`,`re_qu_idx`,`re_idx`),
  KEY `FK_tb_result_tb_question` (`re_qu_idx`),
  CONSTRAINT `FK_tb_result_tb_question` FOREIGN KEY (`re_qu_idx`) REFERENCES `tb_question` (`qu_idx`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tb_result_tb_survey` FOREIGN KEY (`re_su_idx`) REFERENCES `tb_survey` (`su_idx`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_result:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_result` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_select_answer:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_select_answer` DISABLE KEYS */;
INSERT INTO `tb_select_answer` (`sela_idx`, `sela_question_idx`, `sela_writer`, `sela_answer`) VALUES
	(26, 35, 'user2', '여름');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_string_answer:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_string_answer` DISABLE KEYS */;
INSERT INTO `tb_string_answer` (`stra_idx`, `stra_question_idx`, `stra_writer`, `stra_answer`) VALUES
	(9, 36, 'user2', '여름이라서');
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_survey:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_survey` DISABLE KEYS */;
INSERT INTO `tb_survey` (`su_idx`, `su_writer`, `su_title`, `su_desc`, `su_create_time`, `su_update_time`) VALUES
	(50, 'user', '계절에 관한 설문조사', '좋아하는 계절과 싫어하는 계절을 말해주세요 ', '2021-12-20 09:59:40', '2021-12-20 11:17:38'),
	(51, 'user', '영화에 관한 설문조사', '영화를 좋아하는 사람들을 위한 설문조사 ', '2021-12-20 10:01:30', NULL);
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

-- 테이블 데이터 surveytogether.tb_user:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` (`id`, `password`, `name`, `register_date`, `isAccountNonExpired`, `isAccountNonLocked`, `isCredentialsNonExpired`, `isEnabled`) VALUES
	('user', '$2a$10$f7uKmqvzVqFtTm4S5UnC6.vEzV9Z2b9EjkuHk3fLj4Aji/J1WUtge', '김건우', '2021-12-09', 1, 1, 1, 1),
	('user2', '$2a$10$lUO6EeF0pesj6YNm8idjnuXdeFPz9QqfV7GkNUp5ou5.K4w3ZytDm', '이철수', '2021-12-20', 1, 1, 1, 1);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
