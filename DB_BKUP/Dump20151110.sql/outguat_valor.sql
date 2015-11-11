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
-- Table structure for table `valor`
--

DROP TABLE IF EXISTS `valor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) DEFAULT NULL,
  `valor` varchar(128) NOT NULL,
  `idEstablecimiento` int(11) NOT NULL,
  `idAtributo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Valor_Establecimiento1_idx` (`idEstablecimiento`),
  KEY `fk_Valor_Atributo1_idx` (`idAtributo`),
  CONSTRAINT `fk_Valor_Atributo1` FOREIGN KEY (`idAtributo`) REFERENCES `atributo` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Valor_Establecimiento1` FOREIGN KEY (`idEstablecimiento`) REFERENCES `establecimiento` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valor`
--

LOCK TABLES `valor` WRITE;
/*!40000 ALTER TABLE `valor` DISABLE KEYS */;
INSERT INTO `valor` VALUES (1,NULL,'Taller Automotriz Auto Sueco',1,1),(2,NULL,'14.6463534',1,2),(3,NULL,'-90.500200',1,3),(4,NULL,'2',1,4),(5,NULL,'Taller chulo',1,5),(6,NULL,'Parroquia Santa Cruz del Milagro',2,1),(7,NULL,'14.6501273',2,2),(8,NULL,'-90.4993659',2,3),(9,NULL,'3',2,4),(10,NULL,'Esto es una iglesia',2,5),(11,NULL,'McDonald´s Calle Marti',3,1),(12,NULL,'14.6510822',3,2),(13,NULL,'-90.5004215',3,3),(14,NULL,'4',3,4),(15,NULL,'Me encanta',3,5),(16,NULL,'Burguer King Calle Mart',4,1),(17,NULL,'14.651115',4,2),(18,NULL,'-90.501094',4,3),(19,NULL,'5',4,4),(20,NULL,'Asi lo quiero',4,5),(21,NULL,'Campero Calle Marti',5,1),(22,NULL,'14.651136',5,2),(23,NULL,'-90.501466',5,3),(24,NULL,'6',5,4),(25,NULL,'Juan Gutierrez',5,5),(26,NULL,'Capillas Señoriales Parroquia',6,1),(27,NULL,'14.651121',6,2),(28,NULL,'-90.49991',6,3),(29,NULL,'7',6,4),(30,NULL,'Muertes Felices',6,5),(31,NULL,'Funerales Mansilla Parque Colon',7,1),(32,NULL,'14.640529',7,2),(33,NULL,'-90.508031',7,3),(34,NULL,'8',7,4),(35,NULL,'Muertes Infelices',7,5),(36,NULL,'Parroquia Nuestra Señora De La Merced',8,1),(37,NULL,'14.6427825',8,2),(38,NULL,'-90.5070367',8,3),(39,NULL,'9',8,4),(40,NULL,'San Ignacio del Loyola!! :D',8,5),(41,NULL,'Colegio San Ignacio del Loyola',9,1),(42,NULL,'14.6433709',9,2),(43,NULL,'-90.5070878',9,3),(44,NULL,'10',9,4),(45,NULL,'Loyola siempre adelante, adelante siempre Loyolaaa!!',9,5),(46,NULL,'Banco Industrial',10,1),(47,NULL,'14.6368466',10,2),(48,NULL,'-90.5127453',10,3),(49,NULL,'11',10,4),(50,NULL,'Siempre a tu lado',10,5),(51,NULL,'Liceo Guatemala',11,1),(52,NULL,'14.6172995',11,2),(53,NULL,'-90.512476',11,3),(54,NULL,'12',11,4),(55,NULL,'Aqui estudio julio y eiji',11,5),(56,NULL,'Cofiño Stahl y Compañia',12,1),(57,NULL,'14.6188446',12,2),(58,NULL,'-90.5125405',12,3),(59,NULL,'13',12,4),(60,NULL,'Stahliñando',12,5),(61,NULL,'Conquistador Hotel & Conference Center',13,1),(62,NULL,'14.6196969',13,2),(63,NULL,'-90.516307',13,3),(64,NULL,'14',13,4),(65,NULL,'Conquistando america',13,5),(66,NULL,'Estadio Nacional Mateo Flores',14,1),(67,NULL,'14.6263065',14,2),(68,NULL,'-90.5101799',14,3),(69,NULL,'15',14,4),(70,NULL,'Holi erick barrondo :D',14,5),(71,NULL,'Hospital Roosevelt',15,1),(72,NULL,'14.6143048',15,2),(73,NULL,'-90.541346',15,3),(74,NULL,'16',15,4),(75,NULL,'Aqui mueren todos!!',15,5),(76,NULL,'Campo Marte',16,1),(77,NULL,'14.614776',16,2),(78,NULL,'-90.506919',16,3),(79,NULL,'17',16,4),(80,NULL,'Holi kevin cordon!! :D',16,5),(81,NULL,'Supertienda Paiz',17,1),(82,NULL,'14.6262604',17,2),(83,NULL,'-90.4960388',17,3),(84,NULL,'18',17,4),(85,NULL,'Nos compro walmart :c',17,5),(86,NULL,'Anfora',18,1),(87,NULL,'14.6265522',18,2),(88,NULL,'-90.4949799',18,3),(89,NULL,'19',18,4),(90,NULL,'Yo quiero Cheese Cake :D',18,5),(91,NULL,'El Borrachin',19,1),(92,NULL,'14.631449',19,2),(93,NULL,'-90.4976585',19,3),(94,NULL,'20',19,4),(95,NULL,'Valimos pitoooo',19,5),(96,NULL,'Litegua',20,1),(97,NULL,'14.632767',20,2),(98,NULL,'-90.510164',20,3),(99,NULL,'21',20,4),(100,NULL,'Viajes gratisss :D',20,5),(101,NULL,'Linea Dorada',21,1),(102,NULL,'14.632363',21,2),(103,NULL,'-90.5095214',21,3),(104,NULL,'22',21,4),(105,NULL,'Vamos a penten :D',21,5),(106,NULL,'Parque de la Industria',22,1),(107,NULL,'14.6084384',22,2),(108,NULL,'-90.5229776',22,3),(109,NULL,'23',22,4),(110,NULL,'Aqui se hace la INTERFER',22,5),(111,NULL,'Do Mi Sol Bolivar',23,1),(112,NULL,'14.616809',23,2),(113,NULL,'-90.5304734',23,3),(114,NULL,'24',23,4),(115,NULL,'do re mi fa sol la si',23,5),(116,NULL,'McDonald´s Bolivar',24,1),(117,NULL,'14.6186301',24,2),(118,NULL,'-90.5296823',24,3),(119,NULL,'25',24,4),(120,NULL,'Otro mc',24,5),(121,NULL,'Colegio Don Bosco',25,1),(122,NULL,'14.6244634',25,2),(123,NULL,'-90.52248',25,3),(124,NULL,'26',25,4),(125,NULL,'Colegio Salesiano',25,5),(126,NULL,'Plaza el Amate',26,1),(127,NULL,'14.6301484',26,2),(128,NULL,'-90.517689',26,3),(129,NULL,'27',26,4),(130,NULL,'No llevar mas de Q100 que de seguro te los roban',26,5),(131,NULL,'Hospital Los Angeles',27,1),(132,NULL,'14.6344463',27,2),(133,NULL,'-90.5207678',27,3),(134,NULL,'28',27,4),(135,NULL,'guiiiiu guiiiiu guiiiiu (ambulancia)',27,5),(136,NULL,'Hospital San Juan de Dios',28,1),(137,NULL,'14.6396636',28,2),(138,NULL,'-90.5223389',28,3),(139,NULL,'29',28,4),(140,NULL,'Con mas de 80% de defunciones',28,5),(141,NULL,'Conservatorio Nacional de Musica German Alcantara',29,1),(142,NULL,'14.6435707',29,2),(143,NULL,'-90.5187091',29,3),(144,NULL,'30',29,4),(145,NULL,'Do8 re8 mi8',29,5),(146,NULL,'Arrin Cuan',30,1),(147,NULL,'14.6450828',30,2),(148,NULL,'-90.5145114',30,3),(149,NULL,'31',30,4),(150,NULL,'Comida y marimba en vivo todos los dias',30,5),(151,2,'Carro Pequeño',1,10),(152,1,'Atrio Mediano',2,11),(153,10,'Para 2 personas',3,6),(154,15,'Para 8 personas',3,6),(155,5,'Para 13 personas',3,6),(156,1,'Son bien cool :D',3,13),(157,10,'Para 2 personas',4,6),(158,15,'Para 8 personas',4,6),(159,1,'Para 13 personas',4,6),(160,1,'Son bien medio-cool',4,13),(161,10,'Para 2 personas',5,6),(162,15,'Para 8 personas',5,6),(163,5,'Para 13 personas',5,6),(164,1,'No tan cool :c',5,13),(165,12,'Para 10 invitados',6,9),(166,3,'Para mas de 100 invitados',6,9),(167,1,'Para 10 invitados',7,9),(168,0,'Para mas de 99999 invitados',7,9),(169,1,'Bien grandote y chulo',8,11),(170,200,'Nuestra señora de la merced',8,12),(171,40,'Primero primaria',9,14),(172,40,'Segundo primaria',9,14),(173,40,'Tercero primaria',9,14),(174,40,'Cuarto primaria',9,14),(175,40,'Quinto primaria',9,14),(176,40,'Sexto primaria',9,14),(177,2,'Cancha de fut',9,15),(178,2,'Para conferencias',10,9),(179,30,'Primero primaria',11,14),(180,30,'Segundo primaria',11,14),(181,30,'Tercero primaria',11,14),(182,30,'Cuarto primaria',11,14),(183,30,'Quinto primaria',11,14),(184,30,'Sexto primaria',11,14),(185,2,'Cancha de fut',11,15),(186,20,'De mas de 10 Ton',12,10),(187,20,'Individuales',13,7),(188,10,'Dobles',13,7),(189,4,'Triples',13,7),(190,1,'Muy pequeña',13,8),(191,1,'Arruinada',14,19),(192,1,'Campo fut 11',14,18),(193,100,'Doctores',15,16),(194,15,'Bonitas',15,7),(195,150,'Feas',15,7),(196,1,'Arruinada',15,20),(197,3,'Bien cuidadas',16,19),(198,1,'Arruinada',16,19),(199,1,'Campo fut 11',16,18),(200,20,'Campo papi fut',16,18),(201,50,'Buen estado',17,22),(202,10,'Mal estado',17,22),(203,4,'Para 5 personas',18,6),(204,1,'Para 10 personas',18,6),(205,15,'Para 5 personas',19,6),(206,4,'Para 8 personas',19,6),(207,4,'Para Xela',20,24),(208,14,'Para Peten',20,24),(209,3,'Para Rehu',21,24),(210,1,'Para Izabal',21,24),(211,3,'Para niños',22,13),(212,1,'Piscina Mediana',22,8),(213,5,'Para 50 personas',22,9),(214,3,'Para 200 personas',22,9),(215,7,'Para 500 personas',22,9),(216,5,'Con profesionales',23,16),(217,1,'Para niños',24,13),(218,1,'MCSalon',24,9),(219,40,'Primero primaria',25,14),(220,40,'Segundo primaria',25,14),(221,40,'Tercero primaria',25,14),(222,40,'Cuarto primaria',25,14),(223,40,'Quinto primaria',25,14),(224,40,'Sexto primaria',25,14),(225,2,'Cancha de Basquet',25,15),(226,100,'Pequeños',26,9),(227,10,'Doctores',27,16),(228,2,'Cirujanos',27,16),(229,5,'Oftalmologos',27,16),(230,15,'Chileras',27,7),(231,1,'Doctores',27,16),(232,1,'Descompuesta',27,7),(233,10,'Bateria 1',29,14),(234,10,'Bateria 2',29,14),(235,10,'Bateria 3',29,14),(236,15,'Bajo 1',29,14),(237,15,'Bajo 2',29,14),(238,25,'Guitarra 1',29,14),(239,25,'Guitarra 2',29,14),(240,25,'Guitarra 3',29,14),(241,10,'Para 5 personas',30,6),(242,5,'Para 15 personas',30,6),(243,1,'Para todo evento',30,9),(244,0,'Pequeña',2,26),(245,0,'Amarillo',3,25),(246,0,'Rojo',4,25),(247,0,'Anaranjado',5,25),(248,0,'Grande',8,26),(249,0,'Grande',9,26),(250,0,'Cool',9,27),(251,0,'Obscuro',19,28),(252,0,'Dark',19,27),(253,NULL,'hola nenes',31,1),(254,NULL,'13',31,2),(255,NULL,'31',31,3),(256,NULL,'0',31,4),(257,NULL,' sisis wowo yeye',31,5);
/*!40000 ALTER TABLE `valor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-10 18:40:52
