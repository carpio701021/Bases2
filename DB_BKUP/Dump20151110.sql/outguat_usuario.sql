CREATE DATABASE  IF NOT EXISTS `outguat` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `outguat`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: outguat
-- ------------------------------------------------------
-- Server version	5.6.26-log

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
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idTipoUsuario` int(11) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `nombre` varchar(128) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `genero` tinyint(4) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_UNIQUE` (`usuario`),
  KEY `fk_Usuario_TipoUsuario1_idx` (`idTipoUsuario`),
  CONSTRAINT `fk_Usuario_TipoUsuario1` FOREIGN KEY (`idTipoUsuario`) REFERENCES `tipousuario` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,1,'Chinin','Daniel Chavarria','1994-02-01','12312312','chino@chinin.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(2,2,'Owner1','Owner','1994-12-21','12312','owner1@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(3,2,'Owner2','Owner','1994-12-21','12312','owner2@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(4,2,'Owner3','Owner','1994-12-21','12312','owner3@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(5,2,'Owner4','Owner','1994-12-21','12312','owner4@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(6,2,'Owner5','Owner','1994-12-21','12312','owner5@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(7,2,'Owner6','Owner','1994-12-21','12312','owner6@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(8,2,'Owner7','Owner','1994-12-21','12312','owner7@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(9,2,'Owner8','Owner','1994-12-21','12312','owner8@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(10,2,'Owner9','Owner','1994-12-21','12312','owner9@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(11,2,'Owner10','Owner','1994-12-21','12312','owner10@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(12,2,'Owner11','Owner','1994-12-21','12312','owner11@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(13,2,'Owner12','Owner','1994-12-21','12312','owner12@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(14,2,'Owner13','Owner','1994-12-21','12312','owner13@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(15,2,'Owner14','Owner','1994-12-21','12312','owner14@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(16,2,'Owner15','Owner','1994-12-21','12312','owner15@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(17,2,'Owner16','Owner','1994-12-21','12312','owner16@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(18,2,'Owner17','Owner','1994-12-21','12312','owner17@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(19,2,'Owner18','Owner','1994-12-21','12312','owner18@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(20,2,'Owner19','Owner','1994-12-21','12312','owner19@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(21,2,'Owner20','Owner','1994-12-21','12312','owner20@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(22,2,'Owner21','Owner','1994-12-21','12312','owner21@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(23,2,'Owner22','Owner','1994-12-21','12312','owner22@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(24,2,'Owner23','Owner','1994-12-21','12312','owner23@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(25,2,'Owner24','Owner','1994-12-21','12312','owner24@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(26,2,'Owner25','Owner','1994-12-21','12312','owner25@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(27,2,'Owner26','Owner','1994-12-21','12312','owner26@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(28,2,'Owner27','Owner','1994-12-21','12312','owner27@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(29,2,'Owner28','Owner','1994-12-21','12312','owner28@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(30,2,'Owner29','Owner','1994-12-21','12312','owner29@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(31,2,'Owner30','Owner','1994-12-21','12312','owner30@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(32,3,'a','a','2015-09-30','23513','a',0,'0cc175b9c0f1b6a831c399e269772661');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-10 18:40:51
