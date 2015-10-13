


-- INSERTS
DROP FUNCTION IF EXISTS insertAtributo;
DELIMITER $$
CREATE FUNCTION insertAtributo(
    _nombre VARCHAR(128),
    _dimension INT
  ) RETURNS INT
BEGIN
  INSERT INTO Atributo (nombre, dimension) VALUES (_nombre,_dimension);
  RETURN last_insert_id();
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS insertCalificacion;
DELIMITER $$
CREATE FUNCTION insertCalificacion(
    _idEstablecimiento INT,
    _idServicio INT,
    _idUsuario INT,
    _punteo INT,
    _fecha DATETIME
  ) RETURNS INT
BEGIN
  INSERT INTO Calificacion (idEstablecimiento, idServicio, idUsuario,punteo,fecha) VALUES (_idEstablecimiento, _idServicio, _idUsuario, _punteo, _fecha);
  RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS insertComentario;
DELIMITER $$
CREATE FUNCTION insertComentario(
    _idEstablecimiento INT,
    _idServicio INT,
    _idUsuario INT,
    _comentario VARCHAR(128),
    _fecha DATETIME
  ) RETURNS INT
BEGIN


  INSERT INTO Comentario (idEstablecimiento, idServicio, idUsuario,comentario,fecha) VALUES (_idEstablecimiento, _idServicio, _idUsuario, _comentario, _fecha);
  RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS insertEstablecimiento;
DELIMITER $$
CREATE FUNCTION insertEstablecimiento(
    _idTipoEstablecimiento INT,
    _nombre VARCHAR(128),
    _longitud VARCHAR(45),
    _latitud VARCHAR(45),
    _oficial INT,
    _descripcion VARCHAR (128)
  ) RETURNS INT
BEGIN
  DECLARE ult INT;
  INSERT INTO Establecimiento (idTipoEstablecimiento) VALUES (_idTipoEstablecimiento);
  SET ult=last_insert_id();
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,1,_nombre);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,2,_latitud);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,3,_longitud);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,4,_oficial);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,5,_descripcion);
  RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS insertReserva;
DELIMITER $$
CREATE FUNCTION insertReserva(
    _idUsuario INT,
    _idValor INT,
    _fechaInicio DATETIME,
    _fechaFin DATETIME
  ) RETURNS INT
BEGIN
  INSERT INTO Reserva (idUsuario, idValor, fechaInicio, fechaFin) VALUES (_idUsuario, _idValor, _fechaInicio, _fechaFin);
  RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS insertServicio;
DELIMITER $$
CREATE FUNCTION insertServicio(
    _nombre VARCHAR (128)
  ) RETURNS INT
BEGIN

	DECLARE `_rollBack` BOOL DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollBack` = 1;        
	  INSERT INTO Servicio (nombre) VALUES (_nombre);
        IF `_rollBack` THEN
			RETURN 0;            
        ELSE
            RETURN last_insert_id();
        END IF;
END $$
DELIMITER ;




DROP FUNCTION IF EXISTS insertEstablecimientoServicio;
DELIMITER $$
CREATE FUNCTION insertEstablecimientoServicio(
    _idServicio INT,
    _idEstablecimiento INT
  ) RETURNS INT
BEGIN
  INSERT INTO EstablecimientoServicio (idServicio,idEstablecimiento) VALUES (_idServicio,_idEstablecimiento);
  RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS insertTipoEstablecimiento;
DELIMITER $$
CREATE FUNCTION insertTipoEstablecimiento(
    _nombre VARCHAR (128)
  ) RETURNS INT
BEGIN

  INSERT INTO TipoEstablecimiento (nombre) VALUES (_nombre);
  RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS insertTipoUsuario;
DELIMITER $$
CREATE FUNCTION insertTipoUsuario(
    _nombre VARCHAR (128)
  ) RETURNS INT
BEGIN
  INSERT INTO TipoUsuario (nombre) VALUES (_nombre);
  RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS insertUsuario;
DELIMITER $$
CREATE FUNCTION insertUsuario(
    _idTipoUsuario INT,
    _usuario VARCHAR(45),
    _nombre VARCHAR(128),
    _fechaNacimiento DATE,
    _telefono VARCHAR(45),
    _correo VARCHAR(45),
    _genero INT,
    _password VARCHAR(45)
  ) RETURNS INT
BEGIN

		DECLARE `_rollBack` BOOL DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollBack` = 1;        
		INSERT INTO Usuario (idTipoUsuario, usuario, nombre, fechaNacimiento, telefono, correo, genero, password) VALUES(_idTipoUsuario, _usuario, _nombre, _fechaNacimiento, _telefono,_correo,_genero,md5(_password));
        IF `_rollBack` THEN
			RETURN 0;
            
        ELSE
            RETURN last_insert_id();
        END IF;
         

END $$
DELIMITER ;

DROP FUNCTION IF EXISTS insertValor;
DELIMITER $$
CREATE FUNCTION insertValor(
    _idEstablecimiento INT,
    _idAtributo INT,
    _cantidad INT,
    _valor VARCHAR(128)
  ) RETURNS INT
BEGIN
  INSERT INTO Valor (idEstablecimiento,idAtributo,cantidad,valor) VALUES (_idEstablecimiento,_idAtributo,_cantidad,_valor);
  RETURN last_insert_id();
END $$
DELIMITER ;

-- DELETES
DROP FUNCTION IF EXISTS deleteUsuario;
DELIMITER $$
CREATE FUNCTION deleteUsuario(
    _id INT
  ) RETURNS INT
BEGIN
      DELETE FROM Usuario WHERE id=_id;
RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS deleteEstablecimiento;
DELIMITER $$
CREATE FUNCTION deleteEstablecimiento(
    _id INT
  ) RETURNS INT
BEGIN
      DELETE FROM Establecimiento WHERE id=_id;
RETURN last_insert_id();
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS deleteServicio;
DELIMITER $$
CREATE FUNCTION deleteServicio(
    _id INT
  ) RETURNS INT
BEGIN
      DELETE FROM Servicio WHERE id=_id;
RETURN last_insert_id();
END $$
DELIMITER ;


-- INSERTS BÁSICOS
select insertTipoEstablecimiento('Hotel');
select insertTipoEstablecimiento('Restaurante');
select insertTipoEstablecimiento('Taller');

select insertAtributo('Nombre',0);
select insertAtributo('Latitud',0);
select insertAtributo('Longitud',0);
select insertAtributo('Oficial',0);
select insertAtributo('Descripcion',0);

select insertTipoUsuario('Administrador');
select insertTipoUsuario('Owner');
select insertTipoUsuario('Final');

-- RELLENO

select insertUsuario(3,'Yo','Juan Lopez','1906/01/01','2255-0741','lala@lele.com',1,'pokemon');
select insertUsuario(3,'El','Tomo Chan','1926/02/02','','coco@hotmail.com',1,'pokemon');
select insertUsuario(2,'Abel','Abel Gutierrez','1994/12/03','5952-1001','vegetalink@hotmail.com',1,'pokemon');
select insertUsuario(1,'Chinin','Daniel Chavarria','1994/02/01','','',1,'pokemon');
select insertUsuario(2,'Carpio','Javier','1994/12/21','','',1,'pokemon');

select insertAtributo('Mesa',0);
select insertAtributo('Habitacion',0);
select insertAtributo('Piscina',0);
select insertAtributo('Salones',0);

select insertEstablecimiento(2,'Little Cesars','14.649125','-90.477471',5,'Pizza Pizza');
select insertEstablecimiento(1,'Hotel Conquistador and Conference Center Guatemalas','14.619889','-90.516142',3,'COECYS');

select insertValor(1,5,2,'Grande');
select insertValor(1,5,5,'Mediana');
select insertValor(1,5,21,'Pequeña');
select insertValor(2,6,100,'Individual');
select insertValor(2,6,80,'Dobles');
select insertValor(2,6,40,'Triples');
select insertValor(2,7,2,'Pequeña');
select insertValor(2,7,1,'Grande');
select insertValor(2,7,20,'Para 10 personas');
select insertValor(2,7,5,'Para 100 personas');
select insertValor(2,7,2,'Para 200 personas');
select insertValor(2,7,1,'Para 500 personas');



select insertServicio('Hospedaje');
select insertServicio('Comida');
select insertServicio('Conferencias');

select insertEstablecimientoServicio(2,1);
select insertEstablecimientoServicio(1,2);
select insertEstablecimientoServicio(2,2);
select insertEstablecimientoServicio(3,2);

select insertReserva(3,5,'2015-12-10 21:59:59','2015-12-10 23:59:59');


DROP FUNCTION IF EXISTS AgruparServicio;
DELIMITER $$
CREATE FUNCTION AgruparServicio() 
RETURNS TEXT
BEGIN
DECLARE e INT DEFAULT 0;
DECLARE ei INT DEFAULT 0;
DECLARE eide INT DEFAULT 0;
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE a VARCHAR(45);
DECLARE r TEXT;
SELECT COUNT(*) FROM Establecimiento INTO e;
SET ei=0;
WHILE ei<e DO 
	SELECT id FROM Establecimiento limit ei,1 INTO eide;
    SELECT COUNT(*) FROM EstablecimientoServicio WHERE idEstablecimiento=eide INTO n;
	SET i=0;
    IF ei=0 THEN
				SET r=CONCAT(eide,':');            
			ELSE
				SET r = CONCAT(r,' ',eide,':');
	END IF;  
	WHILE i<n DO 
	SELECT S.nombre FROM Servicio S, EstablecimientoServicio ES WHERE ES.idEstablecimiento=eide AND ES.idServicio=S.id limit i,1 INTO a;
	IF i=0 THEN
				SET r=CONCAT(r,a);            
			ELSE
				SET r = CONCAT(r,',',a);
	END IF;  
	SET i = i + 1;
	END WHILE;
SET ei = ei + 1;
END WHILE;
RETURN r;
END $$
DELIMITER ;



DROP FUNCTION IF EXISTS AgruparDimension;
DELIMITER $$
CREATE FUNCTION AgruparDimension() 
RETURNS TEXT
BEGIN
DECLARE e INT DEFAULT 0;
DECLARE ei INT DEFAULT 0;
DECLARE eide INT DEFAULT 0;
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE a VARCHAR(45);
DECLARE r TEXT;
SELECT COUNT(*) FROM Establecimiento INTO e;
SET ei=0;
WHILE ei<e DO 
	SELECT id FROM Establecimiento limit ei,1 INTO eide;
    SELECT COUNT(*) FROM EstablecimientoServicio WHERE idEstablecimiento=eide INTO n;
	SET i=0;
    IF ei=0 THEN
				SET r=CONCAT(eide,':');            
			ELSE
				SET r = CONCAT(r,' ',eide,':');
	END IF;  
	WHILE i<n DO 
	SELECT S.nombre FROM Servicio S, EstablecimientoServicio ES WHERE ES.idEstablecimiento=eide AND ES.idServicio=S.id limit i,1 INTO a;
	IF i=0 THEN
				SET r=CONCAT(r,a);            
			ELSE
				SET r = CONCAT(r,',',a);
	END IF;  
	SET i = i + 1;
	END WHILE;
SET ei = ei + 1;
END WHILE;
RETURN r;
END $$
DELIMITER ;


DROP Procedure IF EXISTS selectTipoEstablecimiento;
DELIMITER $$

CREATE Procedure selectTipoEstablecimiento()
BEGIN
select TE.id, TE.nombre from TipoEstablecimiento TE;
END $$
DELIMITER ;


DROP Procedure IF EXISTS selectEstablecimiento;

DELIMITER $$

CREATE Procedure selectEstablecimiento()
BEGIN
select E.id, E.idTipoEstablecimiento, V.valor from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstablecimiento=E.id;
END $$
DELIMITER ;

DROP Procedure IF EXISTS selectAtributosOwner;

DELIMITER $$

CREATE Procedure selectAtributosOwner(
    _id INT
  )
BEGIN
	select A.nombre, V.valor,V.cantidad as valor
from Valor V, Atributo A
where V.idAtributo = A.id AND V.idEstablecimiento=(select V.idEstablecimiento as valor
from Valor V, Atributo A
where A.id=4 and V.valor=_id and V.idAtributo = A.id);



END $$
DELIMITER ;


DROP Procedure IF EXISTS selectServicioOwner;

DELIMITER $$

CREATE Procedure selectServicioOwner(
    _id INT
  )
BEGIN
select S.nombre
from Servicio S, EstablecimientoServicio ES
where S.id=ES.idServicio
and ES.idEstablecimiento=_id;
END $$
DELIMITER ;


DROP Procedure IF EXISTS logUsuario;

DELIMITER $$

CREATE Procedure logUsuario(
    _Usuario VARCHAR(45),
    _Password VARCHAR(45)
  )
BEGIN

      SELECT *
      FROM Usuario
      WHERE usuario=_Usuario
      AND password=MD5(_Password);

END $$
DELIMITER ;

