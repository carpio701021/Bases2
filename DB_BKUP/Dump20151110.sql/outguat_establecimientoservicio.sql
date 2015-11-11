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
-- Table structure for table `establecimientoservicio`
--

DROP TABLE IF EXISTS `establecimientoservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `establecimientoservicio` (
  `idServicio` int(11) NOT NULL,
  `idEstablecimiento` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  PRIMARY KEY (`idServicio`,`idEstablecimiento`),
  KEY `fk_EstablecimientoServicio_Establecimiento1_idx` (`idEstablecimiento`),
  CONSTRAINT `fk_EstablecimientoServicio_Establecimiento1` FOREIGN KEY (`idEstablecimiento`) REFERENCES `establecimiento` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstablecimientoServicio_Servicio1` FOREIGN KEY (`idServicio`) REFERENCES `servicio` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `establecimientoservicio`
--

LOCK TABLES `establecimientoservicio` WRITE;
/*!40000 ALTER TABLE `establecimientoservicio` DISABLE KEYS */;
INSERT INTO `establecimientoservicio` VALUES (1,13,34),(1,15,10),(2,3,85),(2,4,80),(2,5,75),(2,6,50),(2,13,33),(2,17,90),(2,18,100),(2,19,10),(2,24,100),(2,30,50),(3,13,33),(4,2,100),(4,8,70),(5,8,20),(6,8,10),(7,3,15),(7,4,20),(7,5,25),(7,9,1),(7,11,45),(8,9,99),(8,11,55),(8,25,95),(8,29,60),(9,10,60),(10,10,40),(11,1,20),(11,12,20),(12,1,80),(12,12,30),(13,12,30),(14,14,100),(14,16,50),(15,15,20),(16,15,30),(17,15,40),(17,27,50),(17,28,50),(18,17,10),(18,19,90),(18,22,10),(19,20,100),(19,21,100),(20,6,50),(20,7,95),(20,12,20),(21,16,50),(22,22,90),(22,25,5),(22,26,10),(24,23,50),(24,27,20),(24,28,20),(24,29,40),(25,23,50),(25,27,20),(25,28,20),(25,30,50);
/*!40000 ALTER TABLE `establecimientoservicio` ENABLE KEYS */;
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
