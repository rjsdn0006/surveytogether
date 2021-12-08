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

-- 테이블 데이터 surveytogether.spring_session:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
INSERT INTO `spring_session` (`PRIMARY_ID`, `SESSION_ID`, `CREATION_TIME`, `LAST_ACCESS_TIME`, `MAX_INACTIVE_INTERVAL`, `EXPIRY_TIME`, `PRINCIPAL_NAME`) VALUES
	('1d53eb0d-eb22-4f83-9707-a9cd7c9bd755', '3aa939a4-464d-4436-aaf6-7f0e9611ee2e', 1638927777813, 1638932249933, 7200, 1638939449933, NULL),
	('d8db3b29-bcee-43c0-ae8a-e4ff8a7fffd5', '6933381a-7bcd-406d-9163-b779d5f2b0f0', 1638927777787, 1638927777787, 7200, 1638934977787, NULL);
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
INSERT INTO `spring_session_attributes` (`SESSION_PRIMARY_ID`, `ATTRIBUTE_NAME`, `ATTRIBUTE_BYTES`) VALUES
	('1d53eb0d-eb22-4f83-9707-a9cd7c9bd755', 'org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN', _binary 0xaced0005737200366f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e637372662e44656661756c7443737266546f6b656e5aefb7c82fa2fbd50200034c000a6865616465724e616d657400124c6a6176612f6c616e672f537472696e673b4c000d706172616d657465724e616d6571007e00014c0005746f6b656e71007e0001787074000c582d435352462d544f4b454e7400055f6373726674002432376531306539632d653062392d346238652d626364342d653338356264366332363966);
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;

-- 테이블 surveytogether.tb_auth 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_auth` (
  `id` varchar(50) NOT NULL,
  `auth` varchar(200) NOT NULL,
  PRIMARY KEY (`id`,`auth`),
  CONSTRAINT `tb_auth_ibfk_1` FOREIGN KEY (`id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 surveytogether.tb_auth:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_auth` ENABLE KEYS */;

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
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
