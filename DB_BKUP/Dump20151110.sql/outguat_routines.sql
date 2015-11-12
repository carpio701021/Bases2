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
-- Dumping events for database 'outguat'
--

--
-- Dumping routines for database 'outguat'
--
/*!50003 DROP FUNCTION IF EXISTS `AgruparBusqueda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `AgruparBusqueda`() RETURNS text CHARSET utf8
BEGIN
DECLARE e INT DEFAULT 0;
DECLARE ei INT DEFAULT 0;
DECLARE eide INT DEFAULT 0;
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE a VARCHAR(45);
DECLARE b VARCHAR(45);
DECLARE _tipo VARCHAR(45);
DECLARE _nombre VARCHAR(128);
DECLARE r TEXT;
DECLARE izq TEXT;
SELECT COUNT(*) FROM Establecimiento INTO e;
SET ei=0;
SET r='[';
WHILE ei<e DO
	SELECT id FROM Establecimiento ORDER BY idTipoEstablecimiento limit ei,1 INTO eide;
    SELECT TE.nombre FROM Establecimiento E, TipoEstablecimiento TE WHERE E.id=eide AND TE.id=E.idTipoEstablecimiento INTO _tipo;
    SELECT V.valor FROM Valor V Where V.idEstablecimiento = eide AND V.idAtributo=1 INTO _nombre;
    SELECT COUNT(*) FROM EstablecimientoServicio WHERE idEstablecimiento=eide INTO n;
	SET i=0;
    IF ei=0 THEN
				SET r=CONCAT(r,'{"id":',eide,',"tipo":"',_tipo,'","establecimiento":"',_nombre,'","tags":[');
			ELSE
				SET r = CONCAT(r,',{"id":',eide,',"tipo":"',_tipo,'","establecimiento":"',_nombre,'","tags":[');
	END IF;
	WHILE i<n DO
	SELECT S.nombre FROM Servicio S, EstablecimientoServicio ES WHERE ES.idEstablecimiento=eide AND ES.idServicio=S.id limit i,1 INTO a;
	IF i=0 THEN
					SET r=CONCAT(r,'"',a,'"');
                SET izq=1;
			ELSE
				SET r = CONCAT(r,',"',a,'"');
	END IF;
	SET i = i + 1;
	END WHILE;
    SET i =0;
	SELECT COUNT(V.idAtributo) FROM Valor V, Atributo A WHERE idEstablecimiento=eide AND A.dimension=1 AND A.id=V.idAtributo INTO n;
    WHILE i<n DO
	SELECT V.valor FROM Valor V, Atributo A WHERE V.idEstablecimiento=eide AND A.dimension=1 AND A.id=V.idAtributo  limit i,1 INTO a;
	IF izq=0 THEN
				SET r=CONCAT(r,'"',a,'"');
			ELSE
				SET r = CONCAT(r,',"',a,'"');
	END IF;
	SET i = i + 1;
	END WHILE;
SET ei = ei + 1;
SET r=CONCAT(r,']}');
END WHILE;
SET r=CONCAT(r,']');
RETURN r;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Calificar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Calificar`(
  _idEstablecimiento INT
) RETURNS double
BEGIN
DECLARE nota DOUBLE DEFAULT 0.00;
DECLARE i INT DEFAULT 0;
DECLARE n INT;
DECLARE o INT;
DECLARE u INT;
DECLARE e INT;
DECLARE p INT;
DECLARE mm DOUBLE default 0.00;
SELECT count(*) FROM EstablecimientoServicio WHERE  idEstablecimiento=_idEstablecimiento into n;
WHILE i<n DO
  SELECT ES.idServicio FROM EstablecimientoServicio ES WHERE  idEstablecimiento=_idEstablecimiento limit i,1 INTO e;
  SELECT AVG(punteo) FROM Calificacion WHERE idEstablecimiento=_idEstablecimiento AND idServicio=e limit i,1 INTO u;
  SELECT porcentaje FROM EstablecimientoServicio WHERE idEstablecimiento=_idEstablecimiento AND idServicio=e INTO p;
  SET nota= nota+(u*(p/100));
  SET i=i+1;

END WHILE;
RETURN nota;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `deleteEstablecimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `deleteEstablecimiento`(
    _id INT
  ) RETURNS int(11)
BEGIN
      DELETE FROM Establecimiento WHERE id=_id;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `deleteEstablecimientoServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `deleteEstablecimientoServicio`(_idEstablecimiento INT, _idServicio INT) RETURNS int(11)
BEGIN
DELETE FROM EstablecimientoServicio WHERE idEstablecimiento=_idEstablecimiento AND idServicio=_idServicio;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `deleteReserva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `deleteReserva`(
    _id INT
  ) RETURNS int(11)
BEGIN
      DELETE FROM Reserva WHERE id=_id;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `deleteServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `deleteServicio`(
    _id INT
  ) RETURNS int(11)
BEGIN
      DELETE FROM Servicio WHERE id=_id;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `deleteUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `deleteUsuario`(
    _id INT
  ) RETURNS int(11)
BEGIN
      DELETE FROM Usuario WHERE id=_id;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `deleteValor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `deleteValor`(_id INT) RETURNS int(11)
BEGIN
DELETE FROM Valor WHERE id=_id;

RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertAtributo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertAtributo`(
    _nombre VARCHAR(128),
    _dimension INT
  ) RETURNS int(11)
BEGIN
  INSERT INTO Atributo (nombre, dimension) VALUES (_nombre,_dimension);
  RETURN last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertBitacora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertBitacora`(
    _idUsuario INT,
    _decripcion VARCHAR(256)
  ) RETURNS int(11)
BEGIN
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, _descripcion);
  RETURN last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertCalificacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertCalificacion`(
    _idEstablecimiento INT,
    _idServicio INT,
    _idUsuario INT,
    _punteo INT
  ) RETURNS int(11)
BEGIN
  DECLARE i INT;
  select count(*) from Calificacion where idEstablecimiento=_idEstablecimiento AND idServicio=_idServicio AND idUsuario=_idUsuario into i;
  IF i=1 THEN
	UPDATE Calificacion SET punteo = _punteo WHERE idEstablecimiento=_idEstablecimiento AND idUsuario=_idUsuario AND idServicio=_idServicio;
    INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se modifico la calificacion con id ',last_insert_id()));
  ELSE
	INSERT INTO Calificacion (idEstablecimiento, idServicio, idUsuario,punteo) VALUES (_idEstablecimiento, _idServicio, _idUsuario, _punteo);
	INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se creo una calificacion con id ',last_insert_id()));
  END IF;
  RETURN last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertComentario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertComentario`(
    _idEstablecimiento INT,
    _idUsuario INT,
    _comentario VARCHAR(128)
  ) RETURNS int(11)
BEGIN


  INSERT INTO Comentario (idEstablecimiento, idUsuario,comentario) VALUES (_idEstablecimiento, _idUsuario, _comentario);
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se creo un comentario con id ',last_insert_id()));
  RETURN last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertEstablecimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertEstablecimiento`(
    _idTipoEstablecimiento INT,
    _nombre VARCHAR(128),
    _longitud VARCHAR(45),
    _latitud VARCHAR(45),
    _oficial INT,
    _descripcion VARCHAR (128)
  ) RETURNS int(11)
BEGIN
  DECLARE ult INT;
  INSERT INTO Establecimiento (idTipoEstablecimiento) VALUES (_idTipoEstablecimiento);
  SET ult=last_insert_id();
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,1,_nombre);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,2,_latitud);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,3,_longitud);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,4,_oficial);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,5,_descripcion);
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_oficial, CONCAT('Se creo el establecimiento ',_nombre));
  RETURN last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertEstablecimientoServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertEstablecimientoServicio`(
    _idServicio INT,
    _idEstablecimiento INT,
    _porcentaje INT
  ) RETURNS int(11)
BEGIN
DECLARE `_rollBack` BOOL DEFAULT 0;
      DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollBack` = 1;
  INSERT INTO EstablecimientoServicio (idServicio,idEstablecimiento,porcentaje) VALUES (_idServicio,_idEstablecimiento,_porcentaje);
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se asigno servicio ',_idServicio,' a ',' establecimiento ',_idEstablecimiento));
      IF `_rollBack` THEN
    RETURN 0;
      ELSE
          RETURN last_insert_id();
      END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertReserva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertReserva`(
    _idUsuario INT,
    _idValor INT,
    _fechaInicio DATETIME,
    _fechaFin DATETIME,
    _cantidad INT
  ) RETURNS int(11)
BEGIN
  DECLARE a INT;
  INSERT INTO Reserva (idUsuario, idValor, fechaInicio, fechaFin) VALUES (_idUsuario, _idValor, _fechaInicio, _fechaFin);
  select cantidad from Valor Where id=_idValor into a;
  IF a=0 THEN
  RETURN 0;
  ELSE
  UPDATE Valor SET cantidad = a-_cantidad WHERE id=_idValor;
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se creo una reserva con id ',last_insert_id()));
  RETURN 1;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertServicio`(
    _nombre VARCHAR (128)
  ) RETURNS int(11)
BEGIN

	DECLARE `_rollBack` BOOL DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollBack` = 1;
	  INSERT INTO Servicio (nombre) VALUES (_nombre);
        IF `_rollBack` THEN
			RETURN 0;
        ELSE
            RETURN last_insert_id();
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertTipoEstablecimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertTipoEstablecimiento`(
    _nombre VARCHAR (128)
  ) RETURNS int(11)
BEGIN

  INSERT INTO TipoEstablecimiento (nombre) VALUES (_nombre);
  RETURN last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertTipoUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertTipoUsuario`(
    _nombre VARCHAR (128)
  ) RETURNS int(11)
BEGIN
  INSERT INTO TipoUsuario (nombre) VALUES (_nombre);
  RETURN last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertUsuario`(
    _idTipoUsuario INT,
    _usuario VARCHAR(45),
    _nombre VARCHAR(128),
    _fechaNacimiento DATE,
    _telefono VARCHAR(45),
    _correo VARCHAR(45),
    _genero INT,
    _password VARCHAR(45)
  ) RETURNS int(11)
BEGIN

		DECLARE `_rollBack` BOOL DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollBack` = 1;
		INSERT INTO Usuario (idTipoUsuario, usuario, nombre, fechaNacimiento, telefono, correo, genero, password) VALUES(_idTipoUsuario, _usuario, _nombre, _fechaNacimiento, _telefono,_correo,_genero,md5(_password));
        IF `_rollBack` THEN
			RETURN 0;

        ELSE
            RETURN last_insert_id();
        END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `insertValor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insertValor`(
    _idEstablecimiento INT,
    _idAtributo INT,
    _cantidad INT,
    _valor VARCHAR(128)
  ) RETURNS int(11)
BEGIN
DECLARE a VARCHAR(5);
  INSERT INTO Valor (idEstablecimiento,idAtributo,cantidad,valor) VALUES (_idEstablecimiento,_idAtributo,_cantidad,_valor);
  select V.valor from Valor V Where V.idEstablecimiento=_idEstablecimiento AND V.idAtributo=4 into a;
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (a, CONCAT('Se creo el valor de ',_valor));
  RETURN last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `selectCalificacionServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `selectCalificacionServicio`(
    _idServicio INT,
    _idOwner INT
  ) RETURNS int(11)
BEGIN
  DECLARE p INT;
  DECLARE pro INT;
  select V.idEstablecimiento as valor from Valor V, Atributo A where A.id=4 and V.valor=_idOwner and V.idAtributo = A.id into p;
  select AVG(punteo) FROM Calificacion WHERE idEstablecimiento=p AND idServicio=_idServicio into pro;
  RETURN pro;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `logUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `logUsuario`(
    _Usuario VARCHAR(45),
    _Password VARCHAR(45)
  )
BEGIN

      SELECT *
      FROM Usuario
      WHERE usuario=_Usuario
      AND password=MD5(_Password);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectAtributo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAtributo`(
    _id INT
  )
BEGIN
select V.id AS idValor, A.id, A.nombre, V.valor,V.cantidad
from  Valor V, Atributo A
where V.idAtributo = A.id AND V.idEstablecimiento=_id AND A.dimension=0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectAtributosOwner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAtributosOwner`(
    _id INT
  )
BEGIN
DECLARE p INT;
select V.idEstablecimiento as valor from Valor V, Atributo A where A.id=4 and V.valor=_id and V.idAtributo = A.id into p;
select E.id AS idEstablecimiento,V.id AS idValor,E.idTipoEstablecimiento, A.nombre, V.valor,V.cantidad, A.dimension
from Valor V, Atributo A, Establecimiento E
where V.idAtributo = A.id AND E.id=p AND V.idEstablecimiento=p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectAtributosOwnerSinRepetir` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAtributosOwnerSinRepetir`(
    _id INT
  )
BEGIN
DECLARE p INT;
select V.idEstablecimiento as valor from Valor V, Atributo A where A.id=4 and V.valor=_id and V.idAtributo = A.id into p;
select A.id, A.nombre, A.dimension
from Valor V, Atributo A, Establecimiento E
where V.idAtributo = A.id AND E.id=p AND V.idEstablecimiento=p
group by A.nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectAtributosTodos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAtributosTodos`()
BEGIN
DECLARE p INT;
select A.id, A.nombre, A.dimension
from Atributo A;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectComentario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectComentario`(
  _id INT
)
BEGIN
select C.id, C.comentario, C.fecha, U.usuario from Comentario C, Usuario U where C.idEstablecimiento=_id AND U.id=C.idUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEstablecimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEstablecimiento`()
BEGIN
select E.id, E.idTipoEstablecimiento, V.valor from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstablecimiento=E.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectServicio`(
    _id INT,
    _idUsr INT
  )
BEGIN
select S.id, S.nombre, C.punteo
from Servicio S JOIN EstablecimientoServicio ES ON
S.id=ES.idServicio
and ES.idEstablecimiento=_id
LEFT JOIN Calificacion C
ON C.idUsuario=_idUsr
and C.idServicio=S.id
and C.idEstablecimiento=_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectServicioOwner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectServicioOwner`(
    _id INT
  )
BEGIN
DECLARE p INT;
select S.id, S.nombre, ES.porcentaje
from Servicio S, EstablecimientoServicio ES, Valor V
where S.id=ES.idServicio
and V.idAtributo=4
and V.Valor=_id
and V.idEstablecimiento=ES.idEstablecimiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectServicioTodos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectServicioTodos`()
BEGIN
select S.id, S.nombre
from Servicio S;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectTipoEstablecimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectTipoEstablecimiento`()
BEGIN
select TE.id, TE.nombre from TipoEstablecimiento TE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Taran` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Taran`()
BEGIN
select 'TipoEstablecimiento_id','TipoEstablecimiento_nombre','Establecimiento_id','Establecimiento_idTipoEstablecimiento',
'Servicio_id','Servicio_nombre','EstablecimientoServicio_idServicio','EstablecimientoServicio_idEstablecimiento',
'EstablecimientoServicio_porcentaje','TipoUsuario_id','TipoUsuario_nombre','Usuario_id','Usuario_idTipoUsuario','Usuario_usuario',
'Usuario_nombre','Usuario_fechaNacimiento','Usuario_telefono','Usuario_correo','Usuario_genero','Usuario_password',
'Calificacion_idEstablecimiento','Calificacion_idServicio','Calificacion_idUsuario','Calificacion_punteo','Calificacion_fecha',
'Atributo_id','Atributo_nombre','Atributo_dimension','Valor_id','Valor_cantidad','Valor_valor','Valor_idEstablecimiento',
'Valor_idAtributo','Comentario_id','Comentario_comentario','Comentario_fecha','Comentario_idUsuario','Comentario_idEstablecimiento'
UNION
select distinct TE.id AS TipoEstablecimiento_id, TE.nombre AS TipoEstablecimiento_nombre, E.id AS Establecimiento_id, E.idTipoEstablecimiento AS Establecimiento_idTipoEstablecimiento, SUB2.*, SUB3.*,SUB5.*, SUB6.* from TipoEstablecimiento TE
LEFT JOIN Establecimiento E ON TE.id=E.idTipoEstablecimiento
LEFT JOIN (select S.id AS Servicio_id, S.nombre AS Servicio_nombre, ES.idServicio AS EstablecimientoServicio_idServicio, ES.idEstablecimiento AS EstablecimientoServicio_idEstablecimiento, ES.porcentaje AS EstablecimientoServicio_porcentaje from Servicio S
LEFT JOIN EstablecimientoServicio ES ON S.id = ES.idServicio) SUB2 ON E.id=SUB2.EstablecimientoServicio_idEstablecimiento
LEFT JOIN(select TU.id AS TipoUsuario_id, TU.nombre AS TipoUsuario_nombre,U.id AS Usuario_id,U.idTipoUsuario AS Usuario_idTipoUsuario,U.usuario AS Usuario_usuario,U.nombre AS Usuario_nombre,U.fechaNacimiento AS Usuario_fechaNacimiento,U.telefono AS Usuario_telefono,U.correo AS Usuario_correo,U.genero AS Usuario_genero,U.password AS Usuario_password, SUB1.* from TipoUsuario TU
LEFT JOIN Usuario U ON TU.id = U.idTipoUsuario
LEFT JOIN (select  C.idEstablecimiento AS Calificacion_idEstablecimiento, C.idServicio AS Calificacion_idServicio, C.idUsuario AS Calificacion_idUsuario, C.punteo AS Calificacion_punteo, C.fecha AS Calificacion_fecha from Calificacion C) SUB1 ON SUB1.Calificacion_idUsuario=U.id) SUB3 ON SUB2.EstablecimientoServicio_idServicio=SUB3.Calificacion_idServicio AND SUB2.EstablecimientoServicio_idEstablecimiento=SUB3.Calificacion_idEstablecimiento
LEFT JOIN(select A.id AS Atributo_id, A.nombre AS Atributo_nombre, A.dimension AS Atributo_dimension, V.id AS Valor_id, V.cantidad AS Valor_cantidad, V.valor AS Valor_valor, V.idEstablecimiento AS Valor_idEstablecimiento, V.idAtributo AS Valor_idAtributo from Atributo A
LEFT JOIN Valor V ON A.id=V.idAtributo
LEFT JOIN (Select R.id AS Reserva_id, R.fechaInicio AS Reserva_fechaInicio, R.fechaFin AS Reserva_fechaFin, R.idValor AS Reserva_idValor, R.idUsuario AS Reserva_idUsuario from Reserva R) SUB4 ON V.id=SUB4.Reserva_idValor)SUB5 ON E.id=SUB5.Valor_idEstablecimiento
LEFT JOIN (select C.id AS Comentario_id, C.comentario AS Comentario_comentario, C.fecha AS Comentario_fecha, C.idUsuario AS Comentario_idUsuario, C.idEstablecimiento AS Comentario_idEstablecimiento
from Comentario C)SUB6 ON E.id= SUB6.Comentario_idEstablecimiento

 into OUTFILE    '/tmp/Salida.csv' FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCalificacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCalificacion`(
    _idEstablecimiento INT,
    _idUsuario INT,
    _idServicio INT,
    _punteo INT
)
BEGIN
UPDATE Calificacion SET punteo = _punteo WHERE idEstablecimiento=_idEstablecimiento AND idUsuario=_idUsuario AND idServicio=_idServicio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEstablecimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEstablecimiento`(
    _id INT,
    _idTipoEstablecimiento INT,
    _nombre VARCHAR(128),
    _longitud VARCHAR(45),
    _latitud VARCHAR(45),
    _descripcion VARCHAR (128)
)
BEGIN
DECLARE  temp INT;
select V.idEstablecimiento as valor from Valor V, Atributo A where A.id=4 and V.valor=_id and V.idAtributo = A.id into temp;
UPDATE Valor SET valor = _nombre WHERE idAtributo=1 AND idEstablecimiento=temp;
UPDATE Valor SET valor = _latitud WHERE idAtributo=2 AND idEstablecimiento=temp;
UPDATE Valor SET valor = _longitud WHERE idAtributo=3 AND idEstablecimiento=temp;
UPDATE Valor SET valor = _descripcion WHERE idAtributo=5 AND idEstablecimiento=temp;
UPDATE Establecimiento SET idTipoEstablecimiento = _idTipoEstablecimiento WHERE id=temp;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEstablecimientoServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEstablecimientoServicio`(
    _idServicio INT,
    _idEstablecimiento INT,
    _porcentaje INT
)
BEGIN
UPDATE EstablecimientoServicio SET porcentaje = _porcentaje WHERE idServicio=_idServicio AND idEstablecimiento=_idEstablecimiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateValor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateValor`(
    _id INT,
    _cantidad INT
)
BEGIN
UPDATE Valor SET cantidad = _cantidad WHERE id=_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-10 18:40:53
