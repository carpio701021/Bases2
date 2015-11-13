-- MySQL dump 10.13  Distrib 5.6.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: OutGuat
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu0.14.04.1-log

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
-- Table structure for table `Atributo`
--

DROP TABLE IF EXISTS `Atributo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Atributo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) NOT NULL,
  `dimension` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Atributo`
--

LOCK TABLES `Atributo` WRITE;
/*!40000 ALTER TABLE `Atributo` DISABLE KEYS */;
INSERT INTO `Atributo` VALUES (1,'Nombre',0),(2,'Latitud',0),(3,'Longitud',0),(4,'Oficial',0),(5,'Descripcion',0),(6,'Mesas',0),(7,'Habitaciones',0),(8,'Piscinas',0),(9,'Salones',0),(10,'Elevadores',0),(11,'Atrios',0),(12,'Procesiones',0),(13,'Juegos',0),(14,'Grados',0),(15,'Patios',0),(16,'Citas',0),(17,'Talleres',0),(18,'Campos',0),(19,'Pistas',0),(20,'Ambulancias',0),(21,'Clinicas',0),(22,'Carretas',0),(23,'Pasteles',0),(24,'Viajes',0),(25,'Color',1),(26,'Tamaño',1),(27,'Estado',1),(28,'Iluminacion',1);
/*!40000 ALTER TABLE `Atributo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bitacora`
--

DROP TABLE IF EXISTS `Bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bitacora` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `descripcion` varchar(256) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bitacora`
--

LOCK TABLES `Bitacora` WRITE;
/*!40000 ALTER TABLE `Bitacora` DISABLE KEYS */;
INSERT INTO `Bitacora` VALUES (1,2,'Se creo el establecimiento Taller Automotriz Auto Sueco','2015-11-13 02:33:23'),(2,3,'Se creo el establecimiento Parroquia Santa Cruz del Milagro','2015-11-13 02:33:23'),(3,4,'Se creo el establecimiento McDonald´s Calle Marti','2015-11-13 02:33:23'),(4,5,'Se creo el establecimiento Burguer King Calle Mart','2015-11-13 02:33:23'),(5,6,'Se creo el establecimiento Campero Calle Marti','2015-11-13 02:33:23'),(6,7,'Se creo el establecimiento Capillas Señoriales Parroquia','2015-11-13 02:33:23'),(7,8,'Se creo el establecimiento Funerales Mansilla Parque Colon','2015-11-13 02:33:23'),(8,9,'Se creo el establecimiento Parroquia Nuestra Señora De La Merced','2015-11-13 02:33:23'),(9,10,'Se creo el establecimiento Colegio San Ignacio del Loyola','2015-11-13 02:33:23'),(10,11,'Se creo el establecimiento Banco Industrial','2015-11-13 02:33:23'),(11,12,'Se creo el establecimiento Liceo Guatemala','2015-11-13 02:33:24'),(12,13,'Se creo el establecimiento Cofiño Stahl y Compañia','2015-11-13 02:33:24'),(13,14,'Se creo el establecimiento Conquistador Hotel & Conference Center','2015-11-13 02:33:24'),(14,15,'Se creo el establecimiento Estadio Nacional Mateo Flores','2015-11-13 02:33:24'),(15,16,'Se creo el establecimiento Hospital Roosevelt','2015-11-13 02:33:24'),(16,17,'Se creo el establecimiento Campo Marte','2015-11-13 02:33:24'),(17,18,'Se creo el establecimiento Supertienda Paiz','2015-11-13 02:33:24'),(18,19,'Se creo el establecimiento Anfora','2015-11-13 02:33:24'),(19,20,'Se creo el establecimiento El Borrachin','2015-11-13 02:33:24'),(20,21,'Se creo el establecimiento Litegua','2015-11-13 02:33:24'),(21,22,'Se creo el establecimiento Linea Dorada','2015-11-13 02:33:24'),(22,23,'Se creo el establecimiento Parque de la Industria','2015-11-13 02:33:24'),(23,24,'Se creo el establecimiento Do Mi Sol Bolivar','2015-11-13 02:33:24'),(24,25,'Se creo el establecimiento McDonald´s Bolivar','2015-11-13 02:33:24'),(25,26,'Se creo el establecimiento Colegio Don Bosco','2015-11-13 02:33:24'),(26,27,'Se creo el establecimiento Plaza el Amate','2015-11-13 02:33:24'),(27,28,'Se creo el establecimiento Hospital Los Angeles','2015-11-13 02:33:24'),(28,29,'Se creo el establecimiento Hospital San Juan de Dios','2015-11-13 02:33:24'),(29,30,'Se creo el establecimiento Conservatorio Nacional de Musica German Alcantara','2015-11-13 02:33:24'),(30,31,'Se creo el establecimiento Arrin Cuan','2015-11-13 02:33:24'),(31,2,'Se creo el valor de Carro Pequeño','2015-11-13 02:33:24'),(32,3,'Se creo el valor de Atrio Mediano','2015-11-13 02:33:24'),(33,4,'Se creo el valor de Para 2 personas','2015-11-13 02:33:24'),(34,4,'Se creo el valor de Para 8 personas','2015-11-13 02:33:24'),(35,4,'Se creo el valor de Para 13 personas','2015-11-13 02:33:24'),(36,4,'Se creo el valor de Son bien cool :D','2015-11-13 02:33:25'),(37,5,'Se creo el valor de Para 2 personas','2015-11-13 02:33:25'),(38,5,'Se creo el valor de Para 8 personas','2015-11-13 02:33:25'),(39,5,'Se creo el valor de Para 13 personas','2015-11-13 02:33:25'),(40,5,'Se creo el valor de Son bien medio-cool','2015-11-13 02:33:25'),(41,6,'Se creo el valor de Para 2 personas','2015-11-13 02:33:25'),(42,6,'Se creo el valor de Para 8 personas','2015-11-13 02:33:25'),(43,6,'Se creo el valor de Para 13 personas','2015-11-13 02:33:25'),(44,6,'Se creo el valor de No tan cool :c','2015-11-13 02:33:25'),(45,7,'Se creo el valor de Para 10 invitados','2015-11-13 02:33:25'),(46,7,'Se creo el valor de Para mas de 100 invitados','2015-11-13 02:33:25'),(47,8,'Se creo el valor de Para 10 invitados','2015-11-13 02:33:25'),(48,8,'Se creo el valor de Para mas de 99999 invitados','2015-11-13 02:33:25'),(49,9,'Se creo el valor de Bien grandote y chulo','2015-11-13 02:33:25'),(50,9,'Se creo el valor de Nuestra señora de la merced','2015-11-13 02:33:25'),(51,10,'Se creo el valor de Primero primaria','2015-11-13 02:33:25'),(52,10,'Se creo el valor de Segundo primaria','2015-11-13 02:33:25'),(53,10,'Se creo el valor de Tercero primaria','2015-11-13 02:33:25'),(54,10,'Se creo el valor de Cuarto primaria','2015-11-13 02:33:25'),(55,10,'Se creo el valor de Quinto primaria','2015-11-13 02:33:25'),(56,10,'Se creo el valor de Sexto primaria','2015-11-13 02:33:25'),(57,10,'Se creo el valor de Cancha de fut','2015-11-13 02:33:25'),(58,11,'Se creo el valor de Para conferencias','2015-11-13 02:33:25'),(59,12,'Se creo el valor de Primero primaria','2015-11-13 02:33:25'),(60,12,'Se creo el valor de Segundo primaria','2015-11-13 02:33:25'),(61,12,'Se creo el valor de Tercero primaria','2015-11-13 02:33:25'),(62,12,'Se creo el valor de Cuarto primaria','2015-11-13 02:33:25'),(63,12,'Se creo el valor de Quinto primaria','2015-11-13 02:33:25'),(64,12,'Se creo el valor de Sexto primaria','2015-11-13 02:33:26'),(65,12,'Se creo el valor de Cancha de fut','2015-11-13 02:33:26'),(66,13,'Se creo el valor de De mas de 10 Ton','2015-11-13 02:33:26'),(67,14,'Se creo el valor de Individuales','2015-11-13 02:33:26'),(68,14,'Se creo el valor de Dobles','2015-11-13 02:33:26'),(69,14,'Se creo el valor de Triples','2015-11-13 02:33:26'),(70,14,'Se creo el valor de Muy pequeña','2015-11-13 02:33:26'),(71,15,'Se creo el valor de Arruinada','2015-11-13 02:33:26'),(72,15,'Se creo el valor de Campo fut 11','2015-11-13 02:33:26'),(73,16,'Se creo el valor de Doctores','2015-11-13 02:33:26'),(74,16,'Se creo el valor de Bonitas','2015-11-13 02:33:26'),(75,16,'Se creo el valor de Feas','2015-11-13 02:33:26'),(76,16,'Se creo el valor de Arruinada','2015-11-13 02:33:26'),(77,17,'Se creo el valor de Bien cuidadas','2015-11-13 02:33:26'),(78,17,'Se creo el valor de Arruinada','2015-11-13 02:33:26'),(79,17,'Se creo el valor de Campo fut 11','2015-11-13 02:33:26'),(80,17,'Se creo el valor de Campo papi fut','2015-11-13 02:33:26'),(81,18,'Se creo el valor de Buen estado','2015-11-13 02:33:26'),(82,18,'Se creo el valor de Mal estado','2015-11-13 02:33:26'),(83,19,'Se creo el valor de Para 5 personas','2015-11-13 02:33:26'),(84,19,'Se creo el valor de Para 10 personas','2015-11-13 02:33:26'),(85,20,'Se creo el valor de Para 5 personas','2015-11-13 02:33:26'),(86,20,'Se creo el valor de Para 8 personas','2015-11-13 02:33:26'),(87,21,'Se creo el valor de Para Xela','2015-11-13 02:33:26'),(88,21,'Se creo el valor de Para Peten','2015-11-13 02:33:26'),(89,22,'Se creo el valor de Para Rehu','2015-11-13 02:33:26'),(90,22,'Se creo el valor de Para Izabal','2015-11-13 02:33:26'),(91,23,'Se creo el valor de Para niños','2015-11-13 02:33:26'),(92,23,'Se creo el valor de Piscina Mediana','2015-11-13 02:33:26'),(93,23,'Se creo el valor de Para 50 personas','2015-11-13 02:33:27'),(94,23,'Se creo el valor de Para 200 personas','2015-11-13 02:33:27'),(95,23,'Se creo el valor de Para 500 personas','2015-11-13 02:33:27'),(96,24,'Se creo el valor de Con profesionales','2015-11-13 02:33:27'),(97,25,'Se creo el valor de Para niños','2015-11-13 02:33:27'),(98,25,'Se creo el valor de MCSalon','2015-11-13 02:33:27'),(99,26,'Se creo el valor de Primero primaria','2015-11-13 02:33:27'),(100,26,'Se creo el valor de Segundo primaria','2015-11-13 02:33:27'),(101,26,'Se creo el valor de Tercero primaria','2015-11-13 02:33:27'),(102,26,'Se creo el valor de Cuarto primaria','2015-11-13 02:33:27'),(103,26,'Se creo el valor de Quinto primaria','2015-11-13 02:33:27'),(104,26,'Se creo el valor de Sexto primaria','2015-11-13 02:33:27'),(105,26,'Se creo el valor de Cancha de Basquet','2015-11-13 02:33:27'),(106,27,'Se creo el valor de Pequeños','2015-11-13 02:33:27'),(107,28,'Se creo el valor de Doctores','2015-11-13 02:33:27'),(108,28,'Se creo el valor de Cirujanos','2015-11-13 02:33:27'),(109,28,'Se creo el valor de Oftalmologos','2015-11-13 02:33:27'),(110,28,'Se creo el valor de Chileras','2015-11-13 02:33:27'),(111,28,'Se creo el valor de Doctores','2015-11-13 02:33:27'),(112,28,'Se creo el valor de Descompuesta','2015-11-13 02:33:27'),(113,30,'Se creo el valor de Bateria 1','2015-11-13 02:33:27'),(114,30,'Se creo el valor de Bateria 2','2015-11-13 02:33:27'),(115,30,'Se creo el valor de Bateria 3','2015-11-13 02:33:27'),(116,30,'Se creo el valor de Bajo 1','2015-11-13 02:33:27'),(117,30,'Se creo el valor de Bajo 2','2015-11-13 02:33:27'),(118,30,'Se creo el valor de Guitarra 1','2015-11-13 02:33:27'),(119,30,'Se creo el valor de Guitarra 2','2015-11-13 02:33:28'),(120,30,'Se creo el valor de Guitarra 3','2015-11-13 02:33:28'),(121,31,'Se creo el valor de Para 5 personas','2015-11-13 02:33:28'),(122,31,'Se creo el valor de Para 15 personas','2015-11-13 02:33:28'),(123,31,'Se creo el valor de Para todo evento','2015-11-13 02:33:28'),(124,3,'Se creo el valor de Pequeña','2015-11-13 02:33:28'),(125,4,'Se creo el valor de Amarillo','2015-11-13 02:33:28'),(126,5,'Se creo el valor de Rojo','2015-11-13 02:33:28'),(127,6,'Se creo el valor de Anaranjado','2015-11-13 02:33:28'),(128,9,'Se creo el valor de Grande','2015-11-13 02:33:28'),(129,10,'Se creo el valor de Grande','2015-11-13 02:33:28'),(130,10,'Se creo el valor de Cool','2015-11-13 02:33:28'),(131,20,'Se creo el valor de Obscuro','2015-11-13 02:33:28'),(132,20,'Se creo el valor de Dark','2015-11-13 02:33:28'),(133,32,'Se creo una calificacion con id 0','2015-11-13 02:43:25'),(134,32,'Se creo un comentario con id 1','2015-11-13 02:45:06'),(135,32,'Se creo una calificacion con id 0','2015-11-13 02:46:33'),(136,32,'Se creo una calificacion con id 0','2015-11-13 02:46:34'),(137,32,'Se creo un comentario con id 2','2015-11-13 02:46:48'),(138,32,'Se creo una calificacion con id 0','2015-11-13 02:47:21');
/*!40000 ALTER TABLE `Bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CSV1`
--

DROP TABLE IF EXISTS `CSV1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CSV1` (
  `id_Tipo_Establecimiento` varchar(255) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Estado` varchar(255) NOT NULL,
  `Servicio_Default` varchar(255) NOT NULL,
  `id_Establecimiento` varchar(255) NOT NULL,
  `Nombre1` varchar(255) NOT NULL,
  `Latitud` varchar(255) NOT NULL,
  `Longitud` varchar(255) NOT NULL,
  `is_Oficial` varchar(255) NOT NULL,
  `Tipo` varchar(255) NOT NULL,
  `Estado1` varchar(255) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `id_Servicio_Establecimiento` varchar(255) NOT NULL,
  `id_Servicio` varchar(255) NOT NULL,
  `id_Establecimiento1` varchar(255) NOT NULL,
  `Prioridad` varchar(255) NOT NULL,
  `Estado2` varchar(255) NOT NULL,
  `id_Servicio1` varchar(255) NOT NULL,
  `Nombre2` varchar(255) NOT NULL,
  `Estado3` varchar(255) NOT NULL,
  `id_Detalle_Tipo` varchar(255) NOT NULL,
  `Etiqueta` varchar(255) NOT NULL,
  `Tipo_Dato` varchar(255) NOT NULL,
  `es_Reservable` varchar(255) NOT NULL,
  `Metrica_Reserva` varchar(255) NOT NULL,
  `id_Detalle_Servicio` varchar(255) NOT NULL,
  `Estado4` varchar(255) NOT NULL,
  `Valor` varchar(255) NOT NULL,
  `Descripcion1` varchar(255) NOT NULL,
  `id_Servicio_Establecimiento1` varchar(255) NOT NULL,
  `Servicio_id_Servicio` varchar(255) NOT NULL,
  `Hora_Check_In` varchar(255) NOT NULL,
  `id_Establecimiento2` varchar(255) NOT NULL,
  `id_Usuario` varchar(255) NOT NULL,
  `Estado5` varchar(255) NOT NULL,
  `id_Usuario1` varchar(255) NOT NULL,
  `Nombre3` varchar(255) NOT NULL,
  `Nick` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Estado6` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `id_Usuario2` varchar(255) NOT NULL,
  `id_Rol` varchar(255) NOT NULL,
  `Estado7` varchar(255) NOT NULL,
  `id_Rol1` varchar(255) NOT NULL,
  `Nombre4` varchar(255) NOT NULL,
  `Estado8` varchar(255) NOT NULL,
  `id_Calificacion` varchar(255) NOT NULL,
  `id_Categoria` varchar(255) NOT NULL,
  `Valor1` varchar(255) NOT NULL,
  `Fecha` varchar(255) NOT NULL,
  `Comentario` varchar(255) NOT NULL,
  `id_Servicio_Establecimiento2` varchar(255) NOT NULL,
  `id_Categoria1` varchar(255) NOT NULL,
  `Nombre5` varchar(255) NOT NULL,
  `Tipo_Dato1` varchar(255) NOT NULL,
  `Estado9` varchar(255) NOT NULL,
  `id_Detalle_Categoria` varchar(255) NOT NULL,
  `Valor2` varchar(255) NOT NULL,
  `id_Categoria2` varchar(255) NOT NULL,
  `Estado10` varchar(255) NOT NULL,
  `id_Reserva` varchar(255) NOT NULL,
  `Fecha_Inicio` varchar(255) NOT NULL,
  `Fecha_Fin` varchar(255) NOT NULL,
  `Aprobada` varchar(255) NOT NULL,
  `Usuario_id_Usuario` varchar(255) NOT NULL,
  `id_Detalle_Servicio1` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CSV1`
--

LOCK TABLES `CSV1` WRITE;
/*!40000 ALTER TABLE `CSV1` DISABLE KEYS */;
/*!40000 ALTER TABLE `CSV1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CSV2`
--

DROP TABLE IF EXISTS `CSV2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CSV2` (
  `establecimiento_id_establecimiento` varchar(255) NOT NULL,
  `establecimiento_nombre` varchar(255) NOT NULL,
  `establecimiento_direccion` varchar(255) NOT NULL,
  `establecimiento_tipo` varchar(255) NOT NULL,
  `establecimiento_longitud` varchar(255) NOT NULL,
  `establecimiento_latitud` varchar(255) NOT NULL,
  `establecimiento_oficial` varchar(255) NOT NULL,
  `establecimiento_calificacion_general` varchar(255) NOT NULL,
  `establecimiento_dimension_id_establecimiento` varchar(255) NOT NULL,
  `establecimiento_dimension_id_dimension` varchar(255) NOT NULL,
  `establecimiento_dimension_id_categoria` varchar(255) NOT NULL,
  `categoria_id_categoria` varchar(255) NOT NULL,
  `categoria_nombre` varchar(255) NOT NULL,
  `categoria_descripcion` varchar(255) NOT NULL,
  `servicio_id_servicio` varchar(255) NOT NULL,
  `servicio_nombre` varchar(255) NOT NULL,
  `servicio_descripcion` varchar(255) NOT NULL,
  `caracteristica_id_caracteristica` varchar(255) NOT NULL,
  `caracteristica_nombre` varchar(255) NOT NULL,
  `caracteristica_valor` varchar(255) NOT NULL,
  `caracteristica_Fid_servicio` varchar(255) NOT NULL,
  `establecimiento_servicio_id_establecimiento_servicio` varchar(255) NOT NULL,
  `establecimiento_servicio_Fid_establecimiento` varchar(255) NOT NULL,
  `establecimiento_servicio_Fid_servicio` varchar(255) NOT NULL,
  `usuario_id_usuario` varchar(255) NOT NULL,
  `usuario_nombre` varchar(255) NOT NULL,
  `usuario_correo` varchar(255) NOT NULL,
  `usuario_telefono` varchar(255) NOT NULL,
  `usuario_rol` varchar(255) NOT NULL,
  `usuario_id_establecimiento` varchar(255) NOT NULL,
  `usuario_password` varchar(255) NOT NULL,
  `prereserva_id_prereserva` varchar(255) NOT NULL,
  `prereserva_horayfecha` varchar(255) NOT NULL,
  `prereserva_cantpersonas` varchar(255) NOT NULL,
  `prereserva_id_establecimiento_servicio` varchar(255) NOT NULL,
  `prereserva_id_usuario` varchar(255) NOT NULL,
  `comentario_id_comentario` varchar(255) NOT NULL,
  `comentario_contenido` varchar(255) NOT NULL,
  `comentario_calificacion` varchar(255) NOT NULL,
  `comentario_Fid_establecimiento_servicio` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CSV2`
--

LOCK TABLES `CSV2` WRITE;
/*!40000 ALTER TABLE `CSV2` DISABLE KEYS */;
/*!40000 ALTER TABLE `CSV2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CSV3`
--

DROP TABLE IF EXISTS `CSV3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CSV3` (
  `ID_Establecimiento` varchar(255) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Latitud` varchar(255) NOT NULL,
  `Longitud` varchar(255) NOT NULL,
  `Tipo_Establecimiento` varchar(255) NOT NULL,
  `Establecimiento_Oficial` varchar(255) NOT NULL,
  `Servicio_Establecimiento` varchar(255) NOT NULL,
  `Descripcion_Servicio` varchar(255) NOT NULL,
  `Calificacion` varchar(255) NOT NULL,
  `Comentario` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CSV3`
--

LOCK TABLES `CSV3` WRITE;
/*!40000 ALTER TABLE `CSV3` DISABLE KEYS */;
/*!40000 ALTER TABLE `CSV3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CSV6`
--

DROP TABLE IF EXISTS `CSV6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CSV6` (
  `ESTABLECIMIENTO` varchar(255) NOT NULL,
  `TELEFONO_ESTABLECIMIENTO` varchar(255) NOT NULL,
  `DIRECCION_ESTABLECIMIENTO` varchar(255) NOT NULL,
  `NOMBRE_ESTABLECIMIENTO` varchar(255) NOT NULL,
  `LATITUD_ESTABLECIMIENTO` varchar(255) NOT NULL,
  `LONGITUD_ESTABLECIMIENTO` varchar(255) NOT NULL,
  `USERNAME_USER_CREADOR` varchar(255) NOT NULL,
  `TELEFONO_USER_CREADOR` varchar(255) NOT NULL,
  `CORREO_USER_CREADOR` varchar(255) NOT NULL,
  `PASSWORD_USER_CREADOR` varchar(255) NOT NULL,
  `NOMBRE_USER_CREADOR` varchar(255) NOT NULL,
  `TIPONOMBRE_USER_CREADOR` varchar(255) NOT NULL,
  `NOMBRE_DIMENSION` varchar(255) NOT NULL,
  `NOMBRE_ATRIBUTO` varchar(255) NOT NULL,
  `DESCRIPCION_ATRIBUTO` varchar(255) NOT NULL,
  `NOMBRE_SERVICIO` varchar(255) NOT NULL,
  `DESCRIPCION_SERVICIO` varchar(255) NOT NULL,
  `NOMBRE_R_C` varchar(255) NOT NULL,
  `SERVICIO_TRC` varchar(255) NOT NULL,
  `ESTABLECIMIENTO_TRC` varchar(255) NOT NULL,
  `VALOR_RC` varchar(255) NOT NULL,
  `COMENTARIO_RC` varchar(255) NOT NULL,
  `INICIO_RC` varchar(255) NOT NULL,
  `FINAL_RC` varchar(255) NOT NULL,
  `USERNAME_USER_TRC` varchar(255) NOT NULL,
  `TELEFONO_USER_TRC` varchar(255) NOT NULL,
  `CORREO_USER_TRC` varchar(255) NOT NULL,
  `PASSWORD_USER_TRC` varchar(255) NOT NULL,
  `NOMBRE_USER_TRC` varchar(255) NOT NULL,
  `NOMBRE_TIPOUSUARIOTRC` varchar(255) NOT NULL,
  `OTRA` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CSV6`
--

LOCK TABLES `CSV6` WRITE;
/*!40000 ALTER TABLE `CSV6` DISABLE KEYS */;
/*!40000 ALTER TABLE `CSV6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Calificacion`
--

DROP TABLE IF EXISTS `Calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Calificacion` (
  `idEstablecimiento` int(11) NOT NULL,
  `idServicio` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `punteo` mediumint(9) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEstablecimiento`,`idUsuario`,`idServicio`),
  KEY `fk_Calificacion_Usuario1_idx` (`idUsuario`),
  KEY `fk_Calificacion_EstablecimientoServicio1` (`idServicio`,`idEstablecimiento`),
  CONSTRAINT `Calificacion_ibfk_1` FOREIGN KEY (`idEstablecimiento`) REFERENCES `EstablecimientoServicio` (`idEstablecimiento`) ON UPDATE CASCADE,
  CONSTRAINT `fk_Calificacion_EstablecimientoServicio1` FOREIGN KEY (`idServicio`, `idEstablecimiento`) REFERENCES `EstablecimientoServicio` (`idServicio`, `idEstablecimiento`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Calificacion_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Calificacion`
--

LOCK TABLES `Calificacion` WRITE;
/*!40000 ALTER TABLE `Calificacion` DISABLE KEYS */;
INSERT INTO `Calificacion` VALUES (3,2,32,5,'2015-11-13 02:43:25'),(13,1,32,3,'2015-11-13 02:46:33'),(13,2,32,5,'2015-11-13 02:46:34'),(13,3,32,7,'2015-11-13 02:47:21');
/*!40000 ALTER TABLE `Calificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comentario`
--

DROP TABLE IF EXISTS `Comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comentario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comentario` varchar(128) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idUsuario` int(11) NOT NULL,
  `idEstablecimiento` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Comentario_Usuario1_idx` (`idUsuario`),
  KEY `fk_Comentario_Establecimiento1_idx` (`idEstablecimiento`),
  CONSTRAINT `fk_Comentario_Establecimiento1` FOREIGN KEY (`idEstablecimiento`) REFERENCES `Establecimiento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comentario`
--

LOCK TABLES `Comentario` WRITE;
/*!40000 ALTER TABLE `Comentario` DISABLE KEYS */;
INSERT INTO `Comentario` VALUES (1,'hola nene','2015-11-13 02:45:06',32,3),(2,'hoy si nenes','2015-11-13 02:46:48',32,13);
/*!40000 ALTER TABLE `Comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Establecimiento`
--

DROP TABLE IF EXISTS `Establecimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Establecimiento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idTipoEstablecimiento` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Establecimiento_TipoEstablecimiento_idx` (`idTipoEstablecimiento`),
  CONSTRAINT `fk_Establecimiento_TipoEstablecimiento` FOREIGN KEY (`idTipoEstablecimiento`) REFERENCES `TipoEstablecimiento` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Establecimiento`
--

LOCK TABLES `Establecimiento` WRITE;
/*!40000 ALTER TABLE `Establecimiento` DISABLE KEYS */;
INSERT INTO `Establecimiento` VALUES (13,1),(3,2),(4,2),(5,2),(24,2),(30,2),(1,3),(12,3),(2,4),(8,4),(6,5),(7,5),(9,6),(25,6),(10,7),(11,7),(14,8),(15,9),(27,9),(28,9),(16,10),(22,10),(17,11),(26,11),(18,12),(19,13),(20,14),(21,14),(23,15),(29,15);
/*!40000 ALTER TABLE `Establecimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EstablecimientoServicio`
--

DROP TABLE IF EXISTS `EstablecimientoServicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EstablecimientoServicio` (
  `idServicio` int(11) NOT NULL,
  `idEstablecimiento` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  PRIMARY KEY (`idServicio`,`idEstablecimiento`),
  KEY `fk_EstablecimientoServicio_Establecimiento1_idx` (`idEstablecimiento`),
  CONSTRAINT `fk_EstablecimientoServicio_Establecimiento1` FOREIGN KEY (`idEstablecimiento`) REFERENCES `Establecimiento` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstablecimientoServicio_Servicio1` FOREIGN KEY (`idServicio`) REFERENCES `Servicio` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EstablecimientoServicio`
--

LOCK TABLES `EstablecimientoServicio` WRITE;
/*!40000 ALTER TABLE `EstablecimientoServicio` DISABLE KEYS */;
INSERT INTO `EstablecimientoServicio` VALUES (1,13,34),(1,15,10),(2,3,85),(2,4,80),(2,5,75),(2,6,50),(2,13,33),(2,17,90),(2,18,100),(2,19,10),(2,24,100),(2,30,50),(3,13,33),(4,2,100),(4,8,70),(5,8,20),(6,8,10),(7,3,15),(7,4,20),(7,5,25),(7,9,1),(7,11,45),(8,9,99),(8,11,55),(8,25,95),(8,29,60),(9,10,60),(10,10,40),(11,1,20),(11,12,20),(12,1,80),(12,12,30),(13,12,30),(14,14,100),(14,16,50),(15,15,20),(16,15,30),(17,15,40),(17,27,50),(17,28,50),(18,17,10),(18,19,90),(18,22,10),(19,20,100),(19,21,100),(20,6,50),(20,7,95),(20,12,20),(21,16,50),(22,22,90),(22,25,5),(22,26,10),(24,23,50),(24,27,20),(24,28,20),(24,29,40),(25,23,50),(25,26,90),(25,27,20),(25,28,20),(25,30,50);
/*!40000 ALTER TABLE `EstablecimientoServicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reserva`
--

DROP TABLE IF EXISTS `Reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reserva` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fechaInicio` datetime NOT NULL,
  `fechaFin` datetime DEFAULT NULL,
  `idValor` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Reserva_Valor1_idx` (`idValor`),
  KEY `fk_Reserva_Usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_Reserva_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Valor1` FOREIGN KEY (`idValor`) REFERENCES `Valor` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reserva`
--

LOCK TABLES `Reserva` WRITE;
/*!40000 ALTER TABLE `Reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Servicio`
--

DROP TABLE IF EXISTS `Servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Servicio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servicio`
--

LOCK TABLES `Servicio` WRITE;
/*!40000 ALTER TABLE `Servicio` DISABLE KEYS */;
INSERT INTO `Servicio` VALUES (9,'Ahorros'),(21,'Balanceo'),(24,'Calidad'),(5,'Casamiento'),(17,'Cirugia'),(2,'Comida'),(6,'Comunion'),(3,'Conferencias'),(15,'Consulta'),(8,'Educacion'),(14,'Ejercicio'),(16,'Emergencia'),(11,'Enderesado'),(26,'General'),(1,'Hospedaje'),(7,'Juegos'),(4,'Misa'),(18,'Musicon'),(13,'Over Haul'),(12,'Pintura'),(10,'Prestamos'),(23,'Profesionalismo'),(22,'Recreacion'),(25,'Seguridad'),(19,'Transporte'),(20,'Velorio');
/*!40000 ALTER TABLE `Servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TipoEstablecimiento`
--

DROP TABLE IF EXISTS `TipoEstablecimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TipoEstablecimiento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TipoEstablecimiento`
--

LOCK TABLES `TipoEstablecimiento` WRITE;
/*!40000 ALTER TABLE `TipoEstablecimiento` DISABLE KEYS */;
INSERT INTO `TipoEstablecimiento` VALUES (7,'Banco'),(13,'Bar'),(10,'Campo'),(6,'Colegio'),(8,'Estadio'),(5,'Funeraria'),(9,'Hospital'),(1,'Hotel'),(4,'Iglesia'),(15,'Musica'),(12,'Pasteleria'),(2,'Restaurante'),(11,'Supermercado'),(3,'Taller'),(14,'Transporte');
/*!40000 ALTER TABLE `TipoEstablecimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TipoUsuario`
--

DROP TABLE IF EXISTS `TipoUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TipoUsuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TipoUsuario`
--

LOCK TABLES `TipoUsuario` WRITE;
/*!40000 ALTER TABLE `TipoUsuario` DISABLE KEYS */;
INSERT INTO `TipoUsuario` VALUES (1,'Administrador'),(3,'Final'),(2,'Owner');
/*!40000 ALTER TABLE `TipoUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
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
  CONSTRAINT `fk_Usuario_TipoUsuario1` FOREIGN KEY (`idTipoUsuario`) REFERENCES `TipoUsuario` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (1,1,'Chinin','Daniel Chavarria','1994-02-01','12312312','chino@chinin.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(2,2,'Owner1','Owner','1994-12-21','12312','owner1@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(3,2,'Owner2','Owner','1994-12-21','12312','owner2@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(4,2,'Owner3','Owner','1994-12-21','12312','owner3@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(5,2,'Owner4','Owner','1994-12-21','12312','owner4@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(6,2,'Owner5','Owner','1994-12-21','12312','owner5@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(7,2,'Owner6','Owner','1994-12-21','12312','owner6@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(8,2,'Owner7','Owner','1994-12-21','12312','owner7@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(9,2,'Owner8','Owner','1994-12-21','12312','owner8@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(10,2,'Owner9','Owner','1994-12-21','12312','owner9@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(11,2,'Owner10','Owner','1994-12-21','12312','owner10@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(12,2,'Owner11','Owner','1994-12-21','12312','owner11@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(13,2,'Owner12','Owner','1994-12-21','12312','owner12@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(14,2,'Owner13','Owner','1994-12-21','12312','owner13@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(15,2,'Owner14','Owner','1994-12-21','12312','owner14@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(16,2,'Owner15','Owner','1994-12-21','12312','owner15@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(17,2,'Owner16','Owner','1994-12-21','12312','owner16@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(18,2,'Owner17','Owner','1994-12-21','12312','owner17@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(19,2,'Owner18','Owner','1994-12-21','12312','owner18@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(20,2,'Owner19','Owner','1994-12-21','12312','owner19@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(21,2,'Owner20','Owner','1994-12-21','12312','owner20@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(22,2,'Owner21','Owner','1994-12-21','12312','owner21@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(23,2,'Owner22','Owner','1994-12-21','12312','owner22@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(24,2,'Owner23','Owner','1994-12-21','12312','owner23@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(25,2,'Owner24','Owner','1994-12-21','12312','owner24@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(26,2,'Owner25','Owner','1994-12-21','12312','owner25@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(27,2,'Owner26','Owner','1994-12-21','12312','owner26@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(28,2,'Owner27','Owner','1994-12-21','12312','owner27@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(29,2,'Owner28','Owner','1994-12-21','12312','owner28@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(30,2,'Owner29','Owner','1994-12-21','12312','owner29@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(31,2,'Owner30','Owner','1994-12-21','12312','owner30@owner.com',1,'00bfc8c729f5d4d529a412b12c58ddd2'),(32,3,'a','a','2015-01-01','12341234','a',0,'0cc175b9c0f1b6a831c399e269772661');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Valor`
--

DROP TABLE IF EXISTS `Valor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Valor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) DEFAULT NULL,
  `valor` varchar(128) NOT NULL,
  `idEstablecimiento` int(11) NOT NULL,
  `idAtributo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Valor_Establecimiento1_idx` (`idEstablecimiento`),
  KEY `fk_Valor_Atributo1_idx` (`idAtributo`),
  CONSTRAINT `fk_Valor_Atributo1` FOREIGN KEY (`idAtributo`) REFERENCES `Atributo` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Valor_Establecimiento1` FOREIGN KEY (`idEstablecimiento`) REFERENCES `Establecimiento` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Valor`
--

LOCK TABLES `Valor` WRITE;
/*!40000 ALTER TABLE `Valor` DISABLE KEYS */;
INSERT INTO `Valor` VALUES (1,NULL,'Taller Automotriz Auto Sueco',1,1),(2,NULL,'14.6463534',1,2),(3,NULL,'-90.500200',1,3),(4,NULL,'2',1,4),(5,NULL,'Taller chulo',1,5),(6,NULL,'Parroquia Santa Cruz del Milagro',2,1),(7,NULL,'14.6501273',2,2),(8,NULL,'-90.4993659',2,3),(9,NULL,'3',2,4),(10,NULL,'Esto es una iglesia',2,5),(11,NULL,'McDonald´s Calle Marti',3,1),(12,NULL,'14.6510822',3,2),(13,NULL,'-90.5004215',3,3),(14,NULL,'4',3,4),(15,NULL,'Me encanta',3,5),(16,NULL,'Burguer King Calle Mart',4,1),(17,NULL,'14.651115',4,2),(18,NULL,'-90.501094',4,3),(19,NULL,'5',4,4),(20,NULL,'Asi lo quiero',4,5),(21,NULL,'Campero Calle Marti',5,1),(22,NULL,'14.651136',5,2),(23,NULL,'-90.501466',5,3),(24,NULL,'6',5,4),(25,NULL,'Juan Gutierrez',5,5),(26,NULL,'Capillas Señoriales Parroquia',6,1),(27,NULL,'14.651121',6,2),(28,NULL,'-90.49991',6,3),(29,NULL,'7',6,4),(30,NULL,'Muertes Felices',6,5),(31,NULL,'Funerales Mansilla Parque Colon',7,1),(32,NULL,'14.640529',7,2),(33,NULL,'-90.508031',7,3),(34,NULL,'8',7,4),(35,NULL,'Muertes Infelices',7,5),(36,NULL,'Parroquia Nuestra Señora De La Merced',8,1),(37,NULL,'14.6427825',8,2),(38,NULL,'-90.5070367',8,3),(39,NULL,'9',8,4),(40,NULL,'San Ignacio del Loyola!! :D',8,5),(41,NULL,'Colegio San Ignacio del Loyola',9,1),(42,NULL,'14.6433709',9,2),(43,NULL,'-90.5070878',9,3),(44,NULL,'10',9,4),(45,NULL,'Loyola siempre adelante, adelante siempre Loyolaaa!!',9,5),(46,NULL,'Banco Industrial',10,1),(47,NULL,'14.6368466',10,2),(48,NULL,'-90.5127453',10,3),(49,NULL,'11',10,4),(50,NULL,'Siempre a tu lado',10,5),(51,NULL,'Liceo Guatemala',11,1),(52,NULL,'14.6172995',11,2),(53,NULL,'-90.512476',11,3),(54,NULL,'12',11,4),(55,NULL,'Aqui estudio julio y eiji',11,5),(56,NULL,'Cofiño Stahl y Compañia',12,1),(57,NULL,'14.6188446',12,2),(58,NULL,'-90.5125405',12,3),(59,NULL,'13',12,4),(60,NULL,'Stahliñando',12,5),(61,NULL,'Conquistador Hotel & Conference Center',13,1),(62,NULL,'14.6196969',13,2),(63,NULL,'-90.516307',13,3),(64,NULL,'14',13,4),(65,NULL,'Conquistando america',13,5),(66,NULL,'Estadio Nacional Mateo Flores',14,1),(67,NULL,'14.6263065',14,2),(68,NULL,'-90.5101799',14,3),(69,NULL,'15',14,4),(70,NULL,'Holi erick barrondo :D',14,5),(71,NULL,'Hospital Roosevelt',15,1),(72,NULL,'14.6143048',15,2),(73,NULL,'-90.541346',15,3),(74,NULL,'16',15,4),(75,NULL,'Aqui mueren todos!!',15,5),(76,NULL,'Campo Marte',16,1),(77,NULL,'14.614776',16,2),(78,NULL,'-90.506919',16,3),(79,NULL,'17',16,4),(80,NULL,'Holi kevin cordon!! :D',16,5),(81,NULL,'Supertienda Paiz',17,1),(82,NULL,'14.6262604',17,2),(83,NULL,'-90.4960388',17,3),(84,NULL,'18',17,4),(85,NULL,'Nos compro walmart :c',17,5),(86,NULL,'Anfora',18,1),(87,NULL,'14.6265522',18,2),(88,NULL,'-90.4949799',18,3),(89,NULL,'19',18,4),(90,NULL,'Yo quiero Cheese Cake :D',18,5),(91,NULL,'El Borrachin',19,1),(92,NULL,'14.631449',19,2),(93,NULL,'-90.4976585',19,3),(94,NULL,'20',19,4),(95,NULL,'Valimos pitoooo',19,5),(96,NULL,'Litegua',20,1),(97,NULL,'14.632767',20,2),(98,NULL,'-90.510164',20,3),(99,NULL,'21',20,4),(100,NULL,'Viajes gratisss :D',20,5),(101,NULL,'Linea Dorada',21,1),(102,NULL,'14.632363',21,2),(103,NULL,'-90.5095214',21,3),(104,NULL,'22',21,4),(105,NULL,'Vamos a penten :D',21,5),(106,NULL,'Parque de la Industria',22,1),(107,NULL,'14.6084384',22,2),(108,NULL,'-90.5229776',22,3),(109,NULL,'23',22,4),(110,NULL,'Aqui se hace la INTERFER',22,5),(111,NULL,'Do Mi Sol Bolivar',23,1),(112,NULL,'14.616809',23,2),(113,NULL,'-90.5304734',23,3),(114,NULL,'24',23,4),(115,NULL,'do re mi fa sol la si',23,5),(116,NULL,'McDonald´s Bolivar',24,1),(117,NULL,'14.6186301',24,2),(118,NULL,'-90.5296823',24,3),(119,NULL,'25',24,4),(120,NULL,'Otro mc',24,5),(121,NULL,'Colegio Don Bosco',25,1),(122,NULL,'14.6244634',25,2),(123,NULL,'-90.52248',25,3),(124,NULL,'26',25,4),(125,NULL,'Colegio Salesiano',25,5),(126,NULL,'Plaza el Amate',26,1),(127,NULL,'14.6301484',26,2),(128,NULL,'-90.517689',26,3),(129,NULL,'27',26,4),(130,NULL,'No llevar mas de Q100 que de seguro te los roban',26,5),(131,NULL,'Hospital Los Angeles',27,1),(132,NULL,'14.6344463',27,2),(133,NULL,'-90.5207678',27,3),(134,NULL,'28',27,4),(135,NULL,'guiiiiu guiiiiu guiiiiu (ambulancia)',27,5),(136,NULL,'Hospital San Juan de Dios',28,1),(137,NULL,'14.6396636',28,2),(138,NULL,'-90.5223389',28,3),(139,NULL,'29',28,4),(140,NULL,'Con mas de 80% de defunciones',28,5),(141,NULL,'Conservatorio Nacional de Musica German Alcantara',29,1),(142,NULL,'14.6435707',29,2),(143,NULL,'-90.5187091',29,3),(144,NULL,'30',29,4),(145,NULL,'Do8 re8 mi8',29,5),(146,NULL,'Arrin Cuan',30,1),(147,NULL,'14.6450828',30,2),(148,NULL,'-90.5145114',30,3),(149,NULL,'31',30,4),(150,NULL,'Comida y marimba en vivo todos los dias',30,5),(151,2,'Carro Pequeño',1,10),(152,1,'Atrio Mediano',2,11),(153,10,'Para 2 personas',3,6),(154,15,'Para 8 personas',3,6),(155,5,'Para 13 personas',3,6),(156,1,'Son bien cool :D',3,13),(157,10,'Para 2 personas',4,6),(158,15,'Para 8 personas',4,6),(159,5,'Para 13 personas',4,6),(160,1,'Son bien medio-cool',4,13),(161,10,'Para 2 personas',5,6),(162,15,'Para 8 personas',5,6),(163,5,'Para 13 personas',5,6),(164,1,'No tan cool :c',5,13),(165,12,'Para 10 invitados',6,9),(166,3,'Para mas de 100 invitados',6,9),(167,1,'Para 10 invitados',7,9),(168,1,'Para mas de 99999 invitados',7,9),(169,1,'Bien grandote y chulo',8,11),(170,200,'Nuestra señora de la merced',8,12),(171,40,'Primero primaria',9,14),(172,40,'Segundo primaria',9,14),(173,40,'Tercero primaria',9,14),(174,40,'Cuarto primaria',9,14),(175,40,'Quinto primaria',9,14),(176,40,'Sexto primaria',9,14),(177,2,'Cancha de fut',9,15),(178,2,'Para conferencias',10,9),(179,30,'Primero primaria',11,14),(180,30,'Segundo primaria',11,14),(181,30,'Tercero primaria',11,14),(182,30,'Cuarto primaria',11,14),(183,30,'Quinto primaria',11,14),(184,30,'Sexto primaria',11,14),(185,2,'Cancha de fut',11,15),(186,20,'De mas de 10 Ton',12,10),(187,20,'Individuales',13,7),(188,10,'Dobles',13,7),(189,4,'Triples',13,7),(190,1,'Muy pequeña',13,8),(191,1,'Arruinada',14,19),(192,1,'Campo fut 11',14,18),(193,100,'Doctores',15,16),(194,15,'Bonitas',15,7),(195,150,'Feas',15,7),(196,1,'Arruinada',15,20),(197,3,'Bien cuidadas',16,19),(198,1,'Arruinada',16,19),(199,1,'Campo fut 11',16,18),(200,20,'Campo papi fut',16,18),(201,50,'Buen estado',17,22),(202,10,'Mal estado',17,22),(203,4,'Para 5 personas',18,6),(204,1,'Para 10 personas',18,6),(205,15,'Para 5 personas',19,6),(206,4,'Para 8 personas',19,6),(207,4,'Para Xela',20,24),(208,14,'Para Peten',20,24),(209,3,'Para Rehu',21,24),(210,1,'Para Izabal',21,24),(211,3,'Para niños',22,13),(212,1,'Piscina Mediana',22,8),(213,5,'Para 50 personas',22,9),(214,3,'Para 200 personas',22,9),(215,7,'Para 500 personas',22,9),(216,5,'Con profesionales',23,16),(217,1,'Para niños',24,13),(218,1,'MCSalon',24,9),(219,40,'Primero primaria',25,14),(220,40,'Segundo primaria',25,14),(221,40,'Tercero primaria',25,14),(222,40,'Cuarto primaria',25,14),(223,40,'Quinto primaria',25,14),(224,40,'Sexto primaria',25,14),(225,2,'Cancha de Basquet',25,15),(226,100,'Pequeños',26,9),(227,10,'Doctores',27,16),(228,2,'Cirujanos',27,16),(229,5,'Oftalmologos',27,16),(230,15,'Chileras',27,7),(231,1,'Doctores',27,16),(232,1,'Descompuesta',27,7),(233,10,'Bateria 1',29,14),(234,10,'Bateria 2',29,14),(235,10,'Bateria 3',29,14),(236,15,'Bajo 1',29,14),(237,15,'Bajo 2',29,14),(238,25,'Guitarra 1',29,14),(239,25,'Guitarra 2',29,14),(240,25,'Guitarra 3',29,14),(241,10,'Para 5 personas',30,6),(242,5,'Para 15 personas',30,6),(243,1,'Para todo evento',30,9),(244,0,'Pequeña',2,26),(245,0,'Amarillo',3,25),(246,0,'Rojo',4,25),(247,0,'Anaranjado',5,25),(248,0,'Grande',8,26),(249,0,'Grande',9,26),(250,0,'Cool',9,27),(251,0,'Obscuro',19,28),(252,0,'Dark',19,27);
/*!40000 ALTER TABLE `Valor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-13  0:33:52
