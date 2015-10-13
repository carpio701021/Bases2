use outguat;


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
    _idEstablecimiento INT,
    _porcentaje INT
  ) RETURNS INT
BEGIN
  INSERT INTO EstablecimientoServicio (idServicio,idEstablecimiento,porcentaje) VALUES (_idServicio,_idEstablecimiento,_porcentaje);
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
RETURN 1;
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS deleteEstablecimiento;
DELIMITER $$
CREATE FUNCTION deleteEstablecimiento(
    _id INT
  ) RETURNS INT
BEGIN
      DELETE FROM Establecimiento WHERE id=_id;
RETURN 1;
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS deleteServicio;
DELIMITER $$
CREATE FUNCTION deleteServicio(
    _id INT
  ) RETURNS INT
BEGIN
      DELETE FROM Servicio WHERE id=_id;
RETURN 1;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS deleteValor;
DELIMITER $$
CREATE FUNCTION deleteValor(_idEstablecimiento INT, _idAtributo INT)
RETURNS INT
BEGIN
DECLARE a INT DEFAULT 0;
select V.id from Valor V where V.idEstablecimiento=_idEstablecimiento AND V.idAtributo=_idAtributo INTO a;
DELETE FROM Valor WHERE id=a;
RETURN 1;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS deleteEstablecimientoServicio;
DELIMITER $$
CREATE FUNCTION deleteEstablecimientoServicio(_idEstablecimiento INT, _idServicio INT)
RETURNS INT
BEGIN
DELETE FROM EstablecimientoServicio WHERE idEstablecimiento=_idEstablecimiento AND idServicio=_idServicio;
RETURN 1;
END $$
DELIMITER ;



-- UPDATE

-- usuario

-- establecimiento
DROP PROCEDURE IF EXISTS updateEstablecimiento;
DELIMITER $$
CREATE Procedure updateEstablecimiento(
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
select insertUsuario(2,'Abel','Abel Gutierrez','1994/03/13','5952-1001','vegetalink@hotmail.com',1,'pokemon');
select insertUsuario(1,'Chinin','Daniel Chavarria','1994/02/01','','',1,'pokemon');
select insertUsuario(2,'Carpio','Javier','1994/12/21','','',1,'pokemon');

select insertAtributo('Mesa',0);
select insertAtributo('Habitacion',0);
select insertAtributo('Piscina',0);
select insertAtributo('Salones',0);
select insertAtributo('Color',1);

select insertEstablecimiento(2,'Little Cesars','14.649125','-90.477471',5,'Pizza Pizza');
select insertEstablecimiento(1,'Hotel Conquistador and Conference Center Guatemalas','14.619889','-90.516142',3,'COECYS');

select insertValor(1,10,0,'Naranja');
select insertValor(1,10,0,'Rojo');
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

select insertEstablecimientoServicio(2,1,21);
select insertEstablecimientoServicio(1,2,32);
select insertEstablecimientoServicio(2,2,42);
select insertEstablecimientoServicio(3,2,12);

select insertReserva(3,5,'2015-12-10 21:59:59','2015-12-10 23:59:59');




DROP FUNCTION IF EXISTS Calificar;
DELIMITER $$
CREATE FUNCTION Calificar(
  _idUsuario INT,
  _idEstablecimiento INT
)
RETURNS DOUBLE
BEGIN
DECLARE nota DOUBLE DEFAULT 0.00;
DECLARE i INT DEFAULT 0;
DECLARE n INT;
DECLARE o INT;
DECLARE u INT;
DECLARE e INT;
DECLARE p INT;
SELECT count(*) FROM EstablecimientoServicio WHERE  idEstablecimiento=_idEstablecimiento into i;
WHILE i<n DO
  SELECT _idEstablecimiento FROM EstablecimientoServicio WHERE  idEstablecimiento=_idEstablecimiento limit i,1 INTO o;
  SELECT _idServicio FROM EstablecimientoServicio WHERE  idEstablecimiento=_idEstablecimiento limit i,1 INTO e;
  SELECT AVG(punteo) FROM Calificacion WHERE idEstablecimiento=o AND idServicio=e INTO u;
  SELECT porcentaje FROM EstablecimientoServicio WHERE idEstablecimiento=o AND idServicio=e  INTO p;
  SET nota= nota+(u*(p/100));
END WHILE;
RETURN nota;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS AgruparBusqueda;
DELIMITER $$
CREATE FUNCTION AgruparBusqueda()
RETURNS TEXT
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

DROP Procedure IF EXISTS Comentario;
DELIMITER $$
CREATE Procedure Comentario(
  _id INT  
)
BEGIN
select C.id, C.comentario, C.fecha, U.usuario from Comentario C, Usuario U where C.idEstablecimiento=_id AND U.id=C.idUsuario;
END $$
DELIMITER ;

DROP Procedure IF EXISTS selectAtributo;
DELIMITER $$
CREATE Procedure selectAtributo(
    _id INT
  )
BEGIN
select A.nombre, V.valor,V.cantidad
from Valor V, Atributo A
where V.idAtributo = A.id AND V.idEstablecimiento=_id AND A.dimension=0;

END $$
DELIMITER ;


DROP Procedure IF EXISTS selectServicio;
DELIMITER $$
CREATE Procedure selectServicio(
    _id INT,
    _idUsr INT
  )
BEGIN
select S.nombre, C.punteo
from Servicio S, EstablecimientoServicio ES, Calificacion C
where S.id=ES.idServicio
and C.idUsuario=_idUsr
and ES.idEstablecimiento=_id
and C.idServicio=S.id;
END $$
DELIMITER ;

DROP Procedure IF EXISTS selectServicioOwner;

DELIMITER $$

CREATE Procedure selectServicioOwner(
    _id INT
  )
BEGIN
select S.nombre
from Servicio S, EstablecimientoServicio ES, Valor V
where S.id=ES.idServicio
and V.idAtributo=4
and V.Valor=_id
and V.idEstablecimiento=ES.idEstablecimiento;
END $$
DELIMITER ;

DROP Procedure IF EXISTS selectAtributosOwner;
DELIMITER $$
CREATE Procedure selectAtributosOwner(
    _id INT
  )
BEGIN
DECLARE p INT;
select V.idEstablecimiento as valor from Valor V, Atributo A where A.id=4 and V.valor=_id and V.idAtributo = A.id into p;
select TE.id, A.nombre, V.valor,V.cantidad
from Valor V, Atributo A, TipoEstablecimiento TE
where V.idAtributo = A.id AND TE.id=p AND V.idEstablecimiento=p;
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
