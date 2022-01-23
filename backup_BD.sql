/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.3.31-MariaDB-0ubuntu0.20.04.1 : Database - apg_lp2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`apg_lp2` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `apg_lp2`;

/*Table structure for table `alumnado` */

DROP TABLE IF EXISTS `alumnado`;

CREATE TABLE `alumnado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_alumnos` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `id_division` int(11) NOT NULL,
  `anio` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_alumnos` (`id_alumnos`),
  KEY `id_curso` (`id_curso`),
  KEY `id_division` (`id_division`),
  CONSTRAINT `alumnado_ibfk_1` FOREIGN KEY (`id_alumnos`) REFERENCES `alumnos` (`id`),
  CONSTRAINT `alumnado_ibfk_4` FOREIGN KEY (`id_division`) REFERENCES `division` (`id`),
  CONSTRAINT `alumnado_ibfk_8` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

/*Data for the table `alumnado` */

insert  into `alumnado`(`id`,`id_alumnos`,`id_curso`,`id_division`,`anio`) values (39,33,3,1,2022),(40,34,4,3,2022),(42,35,11,1,2022),(43,37,14,2,2022),(44,42,14,3,2022);

/*Table structure for table `alumnos` */

DROP TABLE IF EXISTS `alumnos`;

CREATE TABLE `alumnos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apellido` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `domicilio` varchar(70) DEFAULT NULL,
  `id_localidad` int(4) NOT NULL,
  `id_pais_nac` int(3) NOT NULL,
  `id_sexo` int(1) DEFAULT NULL,
  `activo` binary(1) NOT NULL DEFAULT '1' COMMENT '1 = activo / 0 = inactivo',
  `nombre_apellido_cont` varchar(100) NOT NULL,
  `direccion_cont` varchar(100) DEFAULT NULL,
  `telefono_cont` varchar(100) DEFAULT NULL,
  `correo_electronico_cont` varchar(70) NOT NULL,
  `relacion_cont` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_sexo` (`id_sexo`),
  KEY `id_nacionalidad` (`id_pais_nac`),
  KEY `alumnos_ibfk_3` (`id_localidad`),
  CONSTRAINT `alumnos_ibfk_1` FOREIGN KEY (`id_sexo`) REFERENCES `sexo` (`id`),
  CONSTRAINT `alumnos_ibfk_2` FOREIGN KEY (`id_pais_nac`) REFERENCES `pais_nac` (`id`),
  CONSTRAINT `alumnos_ibfk_3` FOREIGN KEY (`id_localidad`) REFERENCES `localidad` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4;

/*Data for the table `alumnos` */

insert  into `alumnos`(`id`,`apellido`,`nombre`,`dni`,`domicilio`,`id_localidad`,`id_pais_nac`,`id_sexo`,`activo`,`nombre_apellido_cont`,`direccion_cont`,`telefono_cont`,`correo_electronico_cont`,`relacion_cont`) values (33,'Moran Abba','Agustin Andres','32548943','Vicente Lopez 513',1,41,1,'1','Graciela Rampazo','Mojica 1029','4635788','silvia_moran@hotmail.com','Abuela'),(34,'Fretes','Mariano','34748639','Lugones 725',2,5,1,'1','Mariela Fretes','Jujuy 540','489756132','mariela@mariel.com','Madrastra'),(35,'Perez','Natalia','29320432','Tejerina 230',1,3,2,'1','Juan Perez','tejerina 1350','155487951','perez@perez.com.ar','Padre'),(37,'Rojas','Mauro','17865423','Alvear 540',1,6,1,'1','Walter Rojas','Alvear 780','155423981','rojas@rojas.com','Hermano'),(42,'Gonzalez','Javier','32495681','Calle 4 n°381, Barrio Golf',1,95,1,'1','Sandra Godoy','Calle 4 n°381, Barrio Golf','3584669871','sandra_godoy@gmail.com','Madre');

/*Table structure for table `concepto` */

DROP TABLE IF EXISTS `concepto`;

CREATE TABLE `concepto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

/*Data for the table `concepto` */

insert  into `concepto`(`id`,`nombre`) values (1,'202200'),(2,'202203'),(3,'202204'),(4,'202205'),(5,'202206'),(6,'202207'),(7,'202208'),(8,'202209'),(9,'202210'),(10,'202211'),(11,'202212'),(12,'202300'),(13,'202303'),(14,'202304'),(15,'202305'),(16,'202306'),(17,'202307'),(18,'202308'),(19,'202309'),(20,'202310'),(21,'202311'),(22,'202312');

/*Table structure for table `curso` */

DROP TABLE IF EXISTS `curso`;

CREATE TABLE `curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `curso` */

insert  into `curso`(`id`,`nombre`) values (1,'Sala Roja'),(2,'Sala Azul'),(3,'Primer Grado'),(4,'Segundo Grado'),(5,'Tercer Grado'),(6,'Cuarto Grado'),(7,'Quinto Grado'),(8,'Sexto Grado'),(9,'Primer Año'),(10,'Segundo Año'),(11,'Tercer Año'),(12,'Cuarto Año'),(13,'Quinto Año'),(14,'Sexto Año');

/*Table structure for table `devengado` */

DROP TABLE IF EXISTS `devengado`;

CREATE TABLE `devengado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_alumnado` int(11) NOT NULL,
  `id_concepto` int(11) NOT NULL,
  `monto` int(11) NOT NULL,
  `pagado` binary(1) DEFAULT NULL COMMENT '0 = no / 1 = si',
  PRIMARY KEY (`id`),
  KEY `id_alumnado` (`id_alumnado`),
  KEY `id_periodo` (`id_concepto`),
  CONSTRAINT `devengado_ibfk_1` FOREIGN KEY (`id_alumnado`) REFERENCES `alumnado` (`id`),
  CONSTRAINT `devengado_ibfk_2` FOREIGN KEY (`id_concepto`) REFERENCES `concepto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4;

/*Data for the table `devengado` */

insert  into `devengado`(`id`,`id_alumnado`,`id_concepto`,`monto`,`pagado`) values (420,39,1,5000,'1'),(421,40,1,5000,'0'),(422,42,1,5000,'0'),(423,43,1,5000,'0'),(424,44,1,5000,'1');

/*Table structure for table `division` */

DROP TABLE IF EXISTS `division`;

CREATE TABLE `division` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `division` */

insert  into `division`(`id`,`nombre`) values (1,'A'),(2,'B'),(3,'C');

/*Table structure for table `localidad` */

DROP TABLE IF EXISTS `localidad`;

CREATE TABLE `localidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `id_provincia` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_provincia` (`id_provincia`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `localidad` */

insert  into `localidad`(`id`,`nombre`,`id_provincia`) values (1,'Rio Cuarto',1),(2,'Las Higueras',1),(3,'Espinillo',1),(4,'Chucul',1),(5,'Carnerillo',1),(6,'Baigorria',1),(7,'Alcira Gigena',1),(8,'Holmberg',1),(9,'Las Vertientes',1),(10,'Sampacho',1);

/*Table structure for table `pais_nac` */

DROP TABLE IF EXISTS `pais_nac`;

CREATE TABLE `pais_nac` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8;

/*Data for the table `pais_nac` */

insert  into `pais_nac`(`id`,`nombre`) values (1,'Argentina\r\n'),(2,'Afghanistan\r\n'),(3,'Aland Islands\r\n'),(4,'Albania\r\n'),(5,'Algeria\r\n'),(6,'American Samoa\r\n'),(7,'Andorra\r\n'),(8,'Angola\r\n'),(9,'Anguilla\r\n'),(10,'Anonymous Proxy\r\n'),(11,'Antarctica\r\n'),(12,'Antigua and Barbuda\r\n'),(13,'Armenia\r\n'),(14,'Aruba\r\n'),(15,'Asia/Pacific Region\r\n'),(16,'Australia\r\n'),(17,'Austria\r\n'),(18,'Azerbaijan\r\n'),(19,'Austria'),(20,'Bahamas\r\n'),(21,'Bahrain\r\n'),(22,'Belgium'),(23,'Bangladesh\r\n'),(24,'Barbados\r\n'),(25,'Belarus\r\n'),(26,'Belgium\r\n'),(27,'Belize\r\n'),(28,'Benin\r\n'),(29,'Bermuda'),(30,'Bhutan\r\n'),(31,'Bolivia\r\n'),(32,'Bonair\r\n'),(33,'Bosnia and Herzegovina\r\n'),(34,'Botswana\r\n'),(35,'Brazil'),(36,'British Indian Ocean Territory\r\n'),(37,'Brunei Darussalam\r\n'),(38,'Bulgaria\r\n'),(39,'Burkina Faso\r\n'),(40,'Burundi\r\n'),(41,'Iraq'),(42,'Cambodia\r\n'),(43,'Cameroon\r\n'),(44,'Canada\r\n'),(45,'Cape Verde\r\n'),(46,'Cayman Islands\r\n'),(47,'Central African Republic\r\n'),(48,'Chad\r\n'),(49,'Chile\r\n'),(50,'China\r\n'),(51,'Christmas Island\r\n'),(52,'Cocos (Keeling) Islands\r\n'),(53,'Colombia\r\n'),(54,'Comoros\r\n'),(55,'Cong\r\n'),(56,'Congo\r\n'),(57,'Cook Islands\r\n'),(58,'Costa Rica\r\n'),(59,'Cote D\'Ivoire\r\n'),(60,'Croatia\r\n'),(61,'Cuba\r\n'),(62,'Curacao\r\n'),(63,'Cyprus\r\n'),(64,'Czech Republic\r\n'),(65,'Denmark\r\n'),(66,'Djibouti\r\n'),(67,'Dominica\r\n'),(68,'Dominican Republic\r\n'),(69,'Ecuador\r\n'),(70,'Egypt\r\n'),(71,'El Salvador\r\n'),(72,'Equatorial Guinea\r\n'),(73,'Eritrea\r\n'),(74,'Estonia\r\n'),(75,'Ethiopia\r\n'),(76,'Europe\r\n'),(77,'Falkland Islands (Malvinas)\r\n'),(78,'Faroe Islands\r\n'),(79,'Fiji\r\n'),(80,'Finland\r\n'),(81,'France\r\n'),(82,'French Guiana\r\n'),(83,'Puerto Rico'),(84,'French Southern Territories\r\n'),(85,'Gabon\r\n'),(86,'Gambia\r\n'),(87,'Georgia\r\n'),(88,'Germany\r\n'),(89,'Ghana\r\n'),(90,'Gibraltar\r\n'),(91,'Greece\r\n'),(92,'Greenland\r\n'),(93,'Grenada\r\n'),(94,'Guadeloupe\r\n'),(95,'Guam\r\n'),(96,'Guatemala\r\n'),(97,'Guernsey\r\n'),(98,'Guinea\r\n'),(99,'Guinea-Bissau\r\n'),(100,'Guyana\r\n'),(101,'Haiti\r\n'),(102,'Holy See (Vatican City State)\r\n'),(103,'Honduras\r\n'),(104,'Hong Kong\r\n'),(105,'Hungary\r\n'),(106,'Iceland\r\n'),(107,'India\r\n'),(108,'Indonesia\r\n'),(109,'Ira\r\n'),(110,'Iraq\r\n'),(111,'Ireland\r\n'),(112,'Isle of Man\r\n'),(113,'Israel\r\n'),(114,'Colombia'),(115,'Italy\r\n'),(116,'Jamaica\r\n'),(117,'Japan\r\n'),(118,'Jersey\r\n'),(119,'Jordan\r\n'),(120,'Kazakhstan\r\n'),(121,'Kenya\r\n'),(122,'Kiribati\r\n'),(123,'Kore\r\n'),(124,'Kuwait\r\n'),(125,'Kyrgyzstan\r\n'),(126,'Lao People\'s Democratic Republic\r\n'),(127,'Latvia\r\n'),(128,'Lebanon\r\n'),(129,'Lesotho\r\n'),(130,'Liberia\r\n'),(131,'Libya\r\n'),(132,'Liechtenstein\r\n'),(133,'Lithuania\r\n'),(134,'Luxembourg\r\n'),(135,'Macau\r\n'),(136,'Macedonia\r\n'),(137,'Madagascar\r\n'),(138,'Malawi\r\n'),(139,'Malaysia\r\n'),(140,'Maldives\r\n'),(141,'Mali\r\n'),(142,'Malta\r\n'),(143,'Marshall Islands\r\n'),(144,'Martinique\r\n'),(145,'Mauritania\r\n'),(146,'Mauritius\r\n'),(147,'Mayotte\r\n'),(148,'Mexico\r\n'),(149,'Micronesi\r\n'),(150,'Moldov\r\n'),(151,'Monaco\r\n'),(152,'Montenegro\r\n'),(153,'Montserrat\r\n'),(154,'Morocco'),(155,'Mozambique\r\n'),(156,'Myanmar\r\n'),(157,'Namibia\r\n'),(158,'Nauru\r\n'),(159,'Nepal\r\n'),(160,'Netherlands\r\n'),(161,'New Caledonia\r\n'),(162,'New Zealand\r\n'),(163,'Nicaragua\r\n'),(164,'Niger\r\n'),(165,'Nigeria\r\n'),(166,'Niue\r\n'),(167,'Norfolk Island\r\n'),(168,'Northern Mariana Islands\r\n'),(169,'Norway\r\n'),(170,'Oman\r\n'),(171,'Pakistan\r\n'),(172,'Palau\r\n'),(173,'Palestinian Territory\r\n'),(174,'Panama\r\n'),(175,'Papua New Guinea\r\n'),(176,'Paraguay\r\n'),(177,'Peru\r\n'),(178,'Philippines\r\n'),(179,'Pitcairn Islands\r\n'),(180,'Poland\r\n'),(181,'Portugal\r\n'),(182,'Puerto Rico\r\n'),(183,'Qatar\r\n'),(184,'Reunion\r\n'),(185,'Romania\r\n'),(186,'Russian Federation\r\n'),(187,'Rwanda\r\n'),(188,'Saint Barthelemy\r\n'),(189,'Saint Helena\r\n'),(190,'Saint Kitts and Nevis\r\n'),(191,'Saint Lucia\r\n'),(192,'Saint Martin\r\n'),(193,'Saint Pierre and Miquelon\r\n'),(194,'Saint Vincent and the Grenadines\r\n'),(195,'Samoa\r\n'),(196,'San Marino\r\n'),(197,'Sao Tome and Principe\r\n'),(198,'Satellite Provider\r\n'),(199,'Saudi Arabia\r\n'),(200,'Senegal\r\n'),(201,'Serbia\r\n'),(202,'Seychelles\r\n'),(203,'Sierra Leone\r\n'),(204,'Singapore\r\n'),(205,'Sint Maarten (Dutch part)\r\n'),(206,'Slovakia\r\n'),(207,'Slovenia\r\n'),(208,'Solomon Islands\r\n'),(209,'Somalia\r\n'),(210,'South Africa\r\n'),(211,'South Georgia and the South Sandwich Islands\r\n'),(212,'South Sudan\r\n'),(213,'Spain\r\n'),(214,'Sri Lanka\r\n'),(215,'Sudan\r\n'),(216,'Suriname\r\n'),(217,'Svalbard and Jan Mayen\r\n'),(218,'Swaziland\r\n'),(219,'Sweden\r\n'),(220,'Switzerland\r\n'),(221,'Syrian Arab Republic\r\n'),(222,'Taiwan\r\n'),(223,'Tajikistan\r\n'),(224,'Tanzani\r\n'),(225,'Thailand\r\n'),(226,'Timor-Leste\r\n'),(227,'Togo\r\n'),(228,'Tokelau\r\n'),(229,'Tonga\r\n'),(230,'Trinidad and Tobago\r\n'),(231,'Tunisia\r\n'),(232,'Turkey\r\n'),(233,'Turkmenistan\r\n'),(234,'Turks and Caicos Islands\r\n'),(235,'Tuvalu\r\n'),(236,'Uganda\r\n'),(237,'Ukraine\r\n'),(238,'United Arab Emirates\r\n'),(239,'United Kingdom\r\n'),(240,'United States\r\n'),(241,'United States Minor Outlying Islands\r\n'),(242,'Uruguay\r\n'),(243,'Uzbekistan\r\n'),(244,'Venezuela\r\n'),(245,'Vietnam\r\n'),(246,'Nicaragua'),(247,'Virgin Island\r\n'),(248,'Wallis and Futuna\r\n'),(249,'Western Sahara\r\n'),(250,'Zambia\r\n'),(251,'Zimbabwe\r\n');

/*Table structure for table `sexo` */

DROP TABLE IF EXISTS `sexo`;

CREATE TABLE `sexo` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `inicial` varchar(1) NOT NULL,
  `descripcion` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sexo` */

insert  into `sexo`(`id`,`inicial`,`descripcion`) values (1,'M','Masculino'),(2,'F','Femenino'),(3,'X','No binario');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`email`,`password`) values (1,'Lucas','l.pastranaparrello@itecriocuarto.org.ar','123456'),(2,'Alvaro','a.perezgarcia@itecriocuarto.org.ar','123456');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
