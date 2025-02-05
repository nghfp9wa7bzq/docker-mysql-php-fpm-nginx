-- Adminer 4.8.1 MySQL 8.4.3 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `c_name` varchar(50) NOT NULL,
  `c_address` varchar(255) NOT NULL,
  `c_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_type` (`c_type_id`),
  CONSTRAINT `fk_company_type` FOREIGN KEY (`c_type_id`) REFERENCES `company_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `company` (`id`, `c_name`, `c_address`, `c_type_id`) VALUES
(1,	'Bonefish Grill',	'2202 North West Shore Boulevard, Suite 500
Tampa, Florida, U.S. 33607',	2),
(2,	"Checkers and Rally's",	'Louisville, Kentucky, U.S.',	2),
(3,	'Citrix Systems',	'Fort Lauderdale, Florida, U.S.',	1),
(4,	'Elkins Constructors',	'	Jacksonville, Florida, United States',	2);

DROP TABLE IF EXISTS `company_type`;
CREATE TABLE `company_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `company_type` (`id`, `company_type`) VALUES
(1,	'Inc.'),
(2,	'Ltd.'),
(3,	'partnership');

DROP VIEW IF EXISTS `p_c_ct`;
CREATE TABLE `p_c_ct` (`person_name` varchar(50), `company_name` varchar(50), `company_type` varchar(50));


DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `id` int NOT NULL AUTO_INCREMENT,
  `p_name` varchar(50) NOT NULL,
  `c_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_person_company` (`c_id`),
  CONSTRAINT `fk_person_company` FOREIGN KEY (`c_id`) REFERENCES `company` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `person` (`id`, `p_name`, `c_id`) VALUES
(1,	'Ryleigh Lang',	1),
(2,	'Valeria Cohen',	1),
(3,	'Keith Sutton',	3),
(4,	'Stefan Dominguez',	4),
(5,	'Marcus Lucero',	2);

DROP TABLE IF EXISTS `p_c_ct`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `p_c_ct` AS select `person`.`p_name` AS `person_name`,`company`.`c_name` AS `company_name`,`company_type`.`company_type` AS `company_type` from ((`person` left join `company` on((`person`.`c_id` = `company`.`id`))) left join `company_type` on((`company`.`c_type_id` = `company_type`.`id`)));

-- 2024-11-21 19:02:31
