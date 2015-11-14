-- INSERTS

ALTER TABLE Calificacion ADD FOREIGN KEY(idEstablecimiento)
REFERENCES EstablecimientoServicio(idEstablecimiento) ON DELETE RESTRICT ON UPDATE CASCADE;

DROP FUNCTION IF EXISTS insertBitacora;
DELIMITER $$
CREATE FUNCTION insertBitacora(
    _idUsuario INT,
    _decripcion VARCHAR(256)
  ) RETURNS INT
BEGIN
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, _descripcion);
  RETURN last_insert_id();
END $$
DELIMITER ;


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
    _punteo INT
  ) RETURNS INT
BEGIN
  DECLARE i INT;
  DECLARE nom VARCHAR(128);
  select count(*) from Calificacion where idEstablecimiento=_idEstablecimiento AND idServicio=_idServicio AND idUsuario=_idUsuario into i;
  IF i=1 THEN
	UPDATE Calificacion SET punteo = _punteo WHERE idEstablecimiento=_idEstablecimiento AND idUsuario=_idUsuario AND idServicio=_idServicio;
  Select V.valor from Valor V, Establecimiento E WHERE E.id=V.idEstablecimiento AND V.idAtributo=1 AND V.idEstablecimiento=_idEstablecimiento into nom;
    INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se modifico la calificacion con id ',last_insert_id(),' del establecimiento ',nom));
  ELSE
	INSERT INTO Calificacion (idEstablecimiento, idServicio, idUsuario,punteo) VALUES (_idEstablecimiento, _idServicio, _idUsuario, _punteo);
  Select V.valor from Valor V, Establecimiento E WHERE E.id=V.idEstablecimiento AND V.idAtributo=1 AND V.idEstablecimiento=_idEstablecimiento into nom;
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se creo una calificacion con id ',last_insert_id(),' del establecimiento ',nom));
  END IF;
  RETURN last_insert_id();
END $$
DELIMITER ;






DROP FUNCTION IF EXISTS insertComentario;
DELIMITER $$
CREATE FUNCTION insertComentario(
    _idEstablecimiento INT,
    _idUsuario INT,
    _comentario VARCHAR(128)
  ) RETURNS INT
BEGIN

  DECLARE nom VARCHAR(128);
  INSERT INTO Comentario (idEstablecimiento, idUsuario,comentario) VALUES (_idEstablecimiento, _idUsuario, _comentario);
  Select V.valor from Valor V, Establecimiento E WHERE E.id=V.idEstablecimiento AND V.idAtributo=1 AND V.idEstablecimiento=_idEstablecimiento into nom;
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se creo un comentario con id ',last_insert_id(),' ',nom));
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
  IF _oficial = 0 THEN
  INSERT INTO Establecimiento (idTipoEstablecimiento) VALUES (_idTipoEstablecimiento);
  SET ult=last_insert_id();
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,1,_nombre);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,2,_latitud);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,3,_longitud);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,4,_oficial);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,5,_descripcion);
  INSERT INTO EstablecimientoServicio (idServicio,idEstablecimiento,porcentaje) VALUES (26,ult,100);
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_oficial, CONCAT('Se creo el establecimiento ',_nombre));


else
  INSERT INTO Establecimiento (idTipoEstablecimiento) VALUES (_idTipoEstablecimiento);
  SET ult=last_insert_id();
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,1,_nombre);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,2,_latitud);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,3,_longitud);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,4,_oficial);
  INSERT INTO Valor (idEstablecimiento,idAtributo,valor) VALUES (ult,5,_descripcion);
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_oficial, CONCAT('Se creo el establecimiento ',_nombre));
  RETURN 2;
  END IF;
RETURN 2;
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS insertReserva;
DELIMITER $$
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
END  $$
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
DECLARE `_rollBack` BOOL DEFAULT 0;
DECLARE nom VARCHAR(128);
      DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollBack` = 1;
  INSERT INTO EstablecimientoServicio (idServicio,idEstablecimiento,porcentaje) VALUES (_idServicio,_idEstablecimiento,_porcentaje);
  Select V.valor from Valor V, Establecimiento E WHERE E.id=V.idEstablecimiento AND V.idAtributo=1 AND V.idEstablecimiento=_idEstablecimiento into nom;
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (_idUsuario, CONCAT('Se asigno servicio ',_idServicio,' a ',' establecimiento ',_idEstablecimiento,' ',nom));
      IF `_rollBack` THEN
    RETURN 0;
      ELSE
          RETURN last_insert_id();
      END IF;
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
DECLARE a VARCHAR(5);
DECLARE nom VARCHAR(128);
  INSERT INTO Valor (idEstablecimiento,idAtributo,cantidad,valor) VALUES (_idEstablecimiento,_idAtributo,_cantidad,_valor);
  select V.valor from Valor V Where V.idEstablecimiento=_idEstablecimiento AND V.idAtributo=4 into a;
  Select V.valor from Valor V, Establecimiento E WHERE E.id=V.idEstablecimiento AND V.idAtributo=1 AND V.idEstablecimiento=_idEstablecimiento into nom;
  INSERT INTO Bitacora (idUsuario, descripcion) VALUES (a, CONCAT('Se creo el valor de ',_valor,' ',nom));
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

DROP FUNCTION IF EXISTS deleteReserva;
DELIMITER $$
CREATE FUNCTION deleteReserva(
    _id INT
  ) RETURNS INT
BEGIN
      DELETE FROM Reserva WHERE id=_id;
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
CREATE FUNCTION deleteValor(_id INT)
RETURNS INT
BEGIN
DELETE FROM Valor WHERE id=_id;

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

DROP PROCEDURE IF EXISTS updateValor;
DELIMITER $$
CREATE Procedure updateValor(
    _id INT,
    _cantidad INT
)
BEGIN
UPDATE Valor SET cantidad = _cantidad WHERE id=_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS updateCalificacion;
DELIMITER $$
CREATE Procedure updateCalificacion(
    _idEstablecimiento INT,
    _idUsuario INT,
    _idServicio INT,
    _punteo INT
)
BEGIN
UPDATE Calificacion SET punteo = _punteo WHERE idEstablecimiento=_idEstablecimiento AND idUsuario=_idUsuario AND idServicio=_idServicio;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS updateEstablecimientoServicio;
DELIMITER $$
CREATE Procedure updateEstablecimientoServicio(
    _idServicio INT,
    _idEstablecimiento INT,
    _porcentaje INT
)
BEGIN
UPDATE EstablecimientoServicio SET porcentaje = _porcentaje WHERE idServicio=_idServicio AND idEstablecimiento=_idEstablecimiento;
END $$
DELIMITER ;

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
-- OTROS

DROP FUNCTION IF EXISTS Calificar;
DELIMITER $$
CREATE FUNCTION Calificar(
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
DECLARE ii INT;
DECLARE general Double;
DECLARE pro INT;
DECLARE mm DOUBLE default 0.00;

select count(*) from EstablecimientoServicio where idEstablecimiento=_idEstablecimiento and idServicio=26 into ii;

if ii>0 THEN
SELECT count(*) FROM EstablecimientoServicio WHERE  idEstablecimiento=_idEstablecimiento into n;
WHILE i<n DO
  SELECT ES.idServicio FROM EstablecimientoServicio ES WHERE  idEstablecimiento=_idEstablecimiento limit i,1 INTO e;
  SELECT AVG(punteo) FROM Calificacion WHERE idEstablecimiento=_idEstablecimiento AND idServicio=e INTO u;
  SELECT porcentaje FROM EstablecimientoServicio WHERE idEstablecimiento=_idEstablecimiento AND idServicio=e INTO p;
  SET nota= nota+(u*(p/100));
  SET i=i+1;

END WHILE;
  select AVG(punteo) FROM Calificacion WHERE idEstablecimiento=_idEstablecimiento AND idServicio=26 into pro;
Update Establecimiento set calificacion=(nota+pro)/2 where id=_idEstablecimiento;
RETURN (nota+pro)/2;
else

SELECT count(*) FROM EstablecimientoServicio WHERE  idEstablecimiento=_idEstablecimiento into n;
WHILE i<n DO
  SELECT ES.idServicio FROM EstablecimientoServicio ES WHERE  idEstablecimiento=_idEstablecimiento limit i,1 INTO e;
  SELECT AVG(punteo) FROM Calificacion WHERE idEstablecimiento=_idEstablecimiento AND idServicio=e INTO u;
  SELECT porcentaje FROM EstablecimientoServicio WHERE idEstablecimiento=_idEstablecimiento AND idServicio=e INTO p;
  SET nota= nota+(u*(p/100));
  SET i=i+1;

END WHILE;
Update Establecimiento set calificacion=nota where id=_idEstablecimiento;
RETURN nota;
END IF;
Update Establecimiento set calificacion=nota where id=_idEstablecimiento;
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

DROP Procedure IF EXISTS selectComentario;
DELIMITER $$
CREATE Procedure selectComentario(
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
select V.id AS idValor, A.id, A.nombre, V.valor,V.cantidad
from  Valor V, Atributo A
where V.idAtributo = A.id AND V.idEstablecimiento=_id AND A.dimension=0;

END $$
DELIMITER ;


DROP Procedure IF EXISTS selectServicioTodos;
DELIMITER $$
CREATE Procedure selectServicioTodos()
BEGIN
select S.id, S.nombre
from Servicio S;
END $$
DELIMITER ;


DROP Procedure IF EXISTS selectServicio;
DELIMITER $$
CREATE Procedure selectServicio(
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
END $$
DELIMITER ;


DROP FUNCTION IF EXISTS selectCalificacionServicio;
DELIMITER $$
CREATE FUNCTION selectCalificacionServicio(
    _idServicio INT,
    _idOwner INT
  ) RETURNS INT
BEGIN
  DECLARE p INT;
  DECLARE pro INT;
  select V.idEstablecimiento as valor from Valor V, Atributo A where A.id=4 and V.valor=_idOwner and V.idAtributo = A.id into p;
  select AVG(punteo) FROM Calificacion WHERE idEstablecimiento=p AND idServicio=_idServicio into pro;
  RETURN pro;
END $$
DELIMITER ;

DROP Procedure IF EXISTS selectServicioOwner;
DELIMITER $$
CREATE Procedure selectServicioOwner(
    _id INT
  )
BEGIN
DECLARE p INT;
select S.id, S.nombre, ES.porcentaje
from Servicio S, EstablecimientoServicio ES
where S.id=ES.idServicio
AND ES.idEstablecimiento=_id;
END $$
DELIMITER ;

DROP Procedure IF EXISTS selectAtributosOwnerSinRepetir;
DELIMITER $$
CREATE Procedure selectAtributosOwnerSinRepetir(
    _id INT
  )
BEGIN
DECLARE p INT;
select A.id, A.nombre, A.dimension
from Valor V, Atributo A, Establecimiento E
where V.idAtributo = A.id AND E.id=_id AND V.idEstablecimiento=_id
group by A.nombre;
END $$
DELIMITER ;

DROP Procedure IF EXISTS selectAtributosTodos;
DELIMITER $$
CREATE Procedure selectAtributosTodos()
BEGIN
DECLARE p INT;
select A.id, A.nombre, A.dimension
from Atributo A;
END $$
DELIMITER ;


DROP Procedure IF EXISTS selectAtributosOwner;
DELIMITER $$
CREATE Procedure selectAtributosOwner(
    _id INT
  )
BEGIN
DECLARE p INT;
select E.id AS idEstablecimiento,V.id AS idValor,E.idTipoEstablecimiento, A.nombre, V.valor,V.cantidad, A.dimension
from Valor V, Atributo A, Establecimiento E
where V.idAtributo = A.id AND E.id=_id AND V.idEstablecimiento=_id;
END $$
DELIMITER ;

DROP Procedure IF EXISTS selectEstablecimientosOwner;
DELIMITER $$
CREATE Procedure selectEstablecimientosOwner(
    _id INT
  )
BEGIN
select A.id, B.nombre from (select  V.idEstablecimiento as id from Valor V, Atributo A where A.id=4 and V.valor=_id and V.idAtributo = A.id order by V.id) A
inner join
(select E.id as uno, V.valor as nombre from Valor V, Atributo A, Establecimiento E where A.id=1 and V.idAtributo=A.id and E.id= V.idEstablecimiento and E.id IN (select V.idEstablecimiento from Valor V, Atributo A where A.id=4 and V.valor=_id and V.idAtributo = A.id ORDER BY V.id)Order by V.id) B
on B.uno =A.id;
END $$
DELIMITER ;


DROP Procedure IF EXISTS selectNoOficiales;
DELIMITER $$
CREATE Procedure selectNoOficiales(
  )
BEGIN

select A.id, B.nombre from (select  V.idEstablecimiento as id from Valor V, Atributo A where A.id=4 and V.valor=0 and V.idAtributo = A.id ORDER BY V.id) A
inner join
(select E.id as uno, V.valor as nombre from Valor V, Atributo A, Establecimiento E where A.id=1 and V.idAtributo=A.id and E.id= V.idEstablecimiento and E.id IN (select V.idEstablecimiento from Valor V, Atributo A where A.id=4 and V.valor=0 and V.idAtributo = A.id ORDER BY V.id) ORDER BY V.id) B
on B.uno =A.id;

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


DROP Procedure IF EXISTS Merge;
DELIMITER $$
CREATE Procedure Merge(
    _idO INT,
    _idN INT
  )
BEGIN
DECLARE i Varchar(250);
Select V.valor from Valor V, Establecimiento E where V.idEstablecimiento= E.id AND V.idAtributo=1 AND E.id=_idO into i;
select insertValor(_idN,29,0,i);
UPDATE EstablecimientoServicio SET porcentaje=0 Where idEstablecimiento= _idO;
UPDATE EstablecimientoServicio SET idEstablecimiento = _idN Where idEstablecimiento= _idO;
UPDATE Calificacion SET idEstablecimiento = _idN Where idEstablecimiento= _idO;
DELETE FROM Establecimiento WHERE id=_idO;
END $$
DELIMITER ;


DROP Procedure IF EXISTS Taran;
DELIMITER $$
CREATE Procedure Taran()
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
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS selectBitacora;
DELIMITER $$
CREATE Procedure selectBitacora()
Begin
  select * from Bitacora;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS Consulta11;
DELIMITER $$
CREATE Procedure Consulta11(
  _aqui INT
)
Begin
select A.id, B.nombre from (select  V.idEstablecimiento as id from Valor V, Atributo A where A.id=4
and V.valor=_aqui and V.idAtributo = A.id order by V.id) A
inner join
(select E.id as uno, V.valor as nombre from Valor V, Atributo A, Establecimiento E where A.id=1 and V.idAtributo=A.id and E.id= V.idEstablecimiento and E.id IN (select V.idEstablecimiento from Valor V, Atributo A where A.id=4 and V.valor=_aqui and V.idAtributo = A.id ORDER BY V.id)Order by V.id) B
on B.uno =A.id;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS Consulta12;
DELIMITER $$
CREATE Procedure Consulta12(
  _aqui INT
)
Begin

 Select A.nombre, B.total from (select S.nombre AS nombre, S.id as ida from EstablecimientoServicio E,Servicio S where S.id=E.idServicio AND idEstablecimiento IN
(select V.idEstablecimiento from Valor V, Atributo A where A.id=4 and V.valor=_aqui and V.idAtributo = A.id ORDER BY V.id) GROUP BY E.idServicio ORDER BY E.idServicio )A
inner join
(select  idServicio as ss,Count(*) as total from EstablecimientoServicio where idEstablecimiento IN
(select V.idEstablecimiento from Valor V, Atributo A where A.id=4 and V.valor=_aqui and V.idAtributo = A.id ORDER BY V.id) GROUP BY idServicio ORDER BY idServicio)B
on B.ss=A.ida;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS Consulta13;
DELIMITER $$
CREATE Procedure Consulta13(
  _aqui INT
)
Begin
select T.nombre, COUNT(T.nombre) from TipoEstablecimiento T, Establecimiento E WHERE E.idTipoEstablecimiento=T.id and E.id IN (
select V.idEstablecimiento from Valor V, Atributo A where A.id=4 and V.valor=_aqui and V.idAtributo = A.id ORDER BY V.id) group by T.nombre;
END $$
DELIMITER ;




INSERT INTO Job (resgistros, inserciones,modificaciones,eliminaciones,descripcion) VALUES (0,0,0,0,'Job en ejecucion');
SET GLOBAL event_scheduler = ON;
Drop event if exists evento_prueba;
delimiter |
CREATE event evento_prueba ON schedule every 5 minute do
begin
declare nom text;
declare c INT;
declare i INT;
declare m INT;
declare e INT;
declare ai INT;
declare am INT;
declare ae INT;
declare da DATE;
SELECT fecha FROM Job ORDER BY id DESC LIMIT 1 into da;
select Count(*) from Job into c;
select Count(*) from Bitacora Where descripcion LIKE '%creo%' AND fecha>da into i;
select Count(*) from Bitacora Where descripcion LIKE '%modifico%' AND fecha>da into m;
select Count(*) from Bitacora Where descripcion LIKE '%elimino%' AND fecha>da into e;
INSERT INTO Job (resgistros, inserciones,modificaciones,eliminaciones,descripcion)
VALUES (c,i,m,e,'Job en ejecucion');
end |
delimiter ;
ALTER event evento_prueba enable;



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
select insertUsuario(1,'Chinin','Daniel Chavarria','1994/02/01','12312312','chino@chinin.com',1,'pokemon');
select insertUsuario(2,'Owner1','Owner','1994/12/21','12312','owner1@owner.com',1,'pokemon');
select insertUsuario(2,'Owner2','Owner','1994/12/21','12312','owner2@owner.com',1,'pokemon');
select insertUsuario(2,'Owner3','Owner','1994/12/21','12312','owner3@owner.com',1,'pokemon');
select insertUsuario(2,'Owner4','Owner','1994/12/21','12312','owner4@owner.com',1,'pokemon');
select insertUsuario(2,'Owner5','Owner','1994/12/21','12312','owner5@owner.com',1,'pokemon');
select insertUsuario(2,'Owner6','Owner','1994/12/21','12312','owner6@owner.com',1,'pokemon');
select insertUsuario(2,'Owner7','Owner','1994/12/21','12312','owner7@owner.com',1,'pokemon');
select insertUsuario(2,'Owner8','Owner','1994/12/21','12312','owner8@owner.com',1,'pokemon');
select insertUsuario(2,'Owner9','Owner','1994/12/21','12312','owner9@owner.com',1,'pokemon');
select insertUsuario(2,'Owner10','Owner','1994/12/21','12312','owner10@owner.com',1,'pokemon');
select insertUsuario(2,'Owner11','Owner','1994/12/21','12312','owner11@owner.com',1,'pokemon');
select insertUsuario(2,'Owner12','Owner','1994/12/21','12312','owner12@owner.com',1,'pokemon');
select insertUsuario(2,'Owner13','Owner','1994/12/21','12312','owner13@owner.com',1,'pokemon');
select insertUsuario(2,'Owner14','Owner','1994/12/21','12312','owner14@owner.com',1,'pokemon');
select insertUsuario(2,'Owner15','Owner','1994/12/21','12312','owner15@owner.com',1,'pokemon');
select insertUsuario(2,'Owner16','Owner','1994/12/21','12312','owner16@owner.com',1,'pokemon');
select insertUsuario(2,'Owner17','Owner','1994/12/21','12312','owner17@owner.com',1,'pokemon');
select insertUsuario(2,'Owner18','Owner','1994/12/21','12312','owner18@owner.com',1,'pokemon');
select insertUsuario(2,'Owner19','Owner','1994/12/21','12312','owner19@owner.com',1,'pokemon');
select insertUsuario(2,'Owner20','Owner','1994/12/21','12312','owner20@owner.com',1,'pokemon');
select insertUsuario(2,'Owner21','Owner','1994/12/21','12312','owner21@owner.com',1,'pokemon');
select insertUsuario(2,'Owner22','Owner','1994/12/21','12312','owner22@owner.com',1,'pokemon');
select insertUsuario(2,'Owner23','Owner','1994/12/21','12312','owner23@owner.com',1,'pokemon');
select insertUsuario(2,'Owner24','Owner','1994/12/21','12312','owner24@owner.com',1,'pokemon');
select insertUsuario(2,'Owner25','Owner','1994/12/21','12312','owner25@owner.com',1,'pokemon');
select insertUsuario(2,'Owner26','Owner','1994/12/21','12312','owner26@owner.com',1,'pokemon');
select insertUsuario(2,'Owner27','Owner','1994/12/21','12312','owner27@owner.com',1,'pokemon');
select insertUsuario(2,'Owner28','Owner','1994/12/21','12312','owner28@owner.com',1,'pokemon');
select insertUsuario(2,'Owner29','Owner','1994/12/21','12312','owner29@owner.com',1,'pokemon');
select insertUsuario(2,'Owner30','Owner','1994/12/21','12312','owner30@owner.com',1,'pokemon');

select insertTipoEstablecimiento('Iglesia'); -- 4
select insertTipoEstablecimiento('Funeraria'); -- 5
select insertTipoEstablecimiento('Colegio'); -- 6
select insertTipoEstablecimiento('Banco'); -- 7
select insertTipoEstablecimiento('Estadio'); -- 8
select insertTipoEstablecimiento('Hospital'); -- 9
select insertTipoEstablecimiento('Campo'); -- 10
select insertTipoEstablecimiento('Supermercado'); -- 11
select insertTipoEstablecimiento('Pasteleria'); -- 12
select insertTipoEstablecimiento('Bar'); -- 13
select insertTipoEstablecimiento('Transporte'); -- 14
select insertTipoEstablecimiento('Musica'); -- 15


select insertAtributo('Mesas',0); -- 6
select insertAtributo('Habitaciones',0); -- 7
select insertAtributo('Piscinas',0); -- 8
select insertAtributo('Salones',0); -- 9
select insertAtributo('Elevadores',0); -- 10
select insertAtributo('Atrios',0); -- 11
select insertAtributo('Procesiones',0); -- 12
select insertAtributo('Juegos',0); -- 13
select insertAtributo('Grados',0); -- 14
select insertAtributo('Patios',0); -- 15
select insertAtributo('Citas',0); -- 16
select insertAtributo('Talleres',0); -- 17
select insertAtributo('Campos',0); -- 18
select insertAtributo('Pistas',0); -- 19
select insertAtributo('Ambulancias',0); -- 20
select insertAtributo('Clinicas',0); -- 21
select insertAtributo('Carretas',0); -- 22
select insertAtributo('Pasteles',0); -- 23
select insertAtributo('Viajes',0); -- 24


select insertAtributo('Color',1); -- 25
select insertAtributo('Tamaño',1); -- 26
select insertAtributo('Estado',1); -- 27
select insertAtributo('Iluminacion',1); -- 28
select insertAtributo('Alias',1);


select insertEstablecimiento(3,'Taller Automotriz Auto Sueco','-90.500200','14.6463534',2,'Taller chulo');
select insertEstablecimiento(4,'Parroquia Santa Cruz del Milagro','-90.4993659','14.6501273',3,'Esto es una iglesia');
select insertEstablecimiento(2,'McDonald´s Calle Marti','-90.5004215','14.6510822',4,'Me encanta');
select insertEstablecimiento(2,'Burguer King Calle Mart','-90.501094','14.651115',5,'Asi lo quiero');
select insertEstablecimiento(2,'Campero Calle Marti','-90.501466','14.651136',6,'Juan Gutierrez');
select insertEstablecimiento(5,'Capillas Señoriales Parroquia','-90.49991','14.651121',7,'Muertes Felices');
select insertEstablecimiento(5,'Funerales Mansilla Parque Colon','-90.508031','14.640529',8,'Muertes Infelices');
select insertEstablecimiento(4,'Parroquia Nuestra Señora De La Merced','-90.5070367','14.6427825',9,'San Ignacio del Loyola!! :D');
select insertEstablecimiento(6,'Colegio San Ignacio del Loyola','-90.5070878','14.6433709',10,'Loyola siempre adelante, adelante siempre Loyolaaa!!');
select insertEstablecimiento(7,'Banco Industrial','-90.5127453','14.6368466',11,'Siempre a tu lado');
select insertEstablecimiento(7,'Liceo Guatemala','-90.512476','14.6172995',12,'Aqui estudio julio y eiji');
select insertEstablecimiento(3,'Cofiño Stahl y Compañia','-90.5125405','14.6188446',13,'Stahliñando');
select insertEstablecimiento(1,'Conquistador Hotel & Conference Center','-90.516307','14.6196969',14,'Conquistando america');
select insertEstablecimiento(8,'Estadio Nacional Mateo Flores','-90.5101799','14.6263065',15,'Holi erick barrondo :D');
select insertEstablecimiento(9,'Hospital Roosevelt','-90.541346','14.6143048',16,'Aqui mueren todos!!');
select insertEstablecimiento(10,'Campo Marte','-90.506919','14.614776',17,'Holi kevin cordon!! :D');
select insertEstablecimiento(11,'Supertienda Paiz','-90.4960388','14.6262604',18,'Nos compro walmart :c');
select insertEstablecimiento(12,'Anfora','-90.4949799','14.6265522',19,'Yo quiero Cheese Cake :D');
select insertEstablecimiento(13,'El Borrachin','-90.4976585','14.631449',20,'Valimos pitoooo');
select insertEstablecimiento(14,'Litegua','-90.510164','14.632767',21,'Viajes gratisss :D');
select insertEstablecimiento(14,'Linea Dorada','-90.5095214','14.632363',22,'Vamos a penten :D');
select insertEstablecimiento(10,'Parque de la Industria','-90.5229776','14.6084384',23,'Aqui se hace la INTERFER');
select insertEstablecimiento(15,'Do Mi Sol Bolivar','-90.5304734','14.616809',24,'do re mi fa sol la si');
select insertEstablecimiento(2,'McDonald´s Bolivar','-90.5296823','14.6186301',25,'Otro mc');
select insertEstablecimiento(6,'Colegio Don Bosco','-90.52248','14.6244634',26,'Colegio Salesiano');
select insertEstablecimiento(11,'Plaza el Amate','-90.517689','14.6301484',27,'No llevar mas de Q100 que de seguro te los roban');
select insertEstablecimiento(9,'Hospital Los Angeles','-90.5207678','14.6344463',28,'guiiiiu guiiiiu guiiiiu (ambulancia)');
select insertEstablecimiento(9,'Hospital San Juan de Dios','-90.5223389','14.6396636',29,'Con mas de 80% de defunciones');
select insertEstablecimiento(15,'Conservatorio Nacional de Musica German Alcantara','-90.5187091','14.6435707',30,'Do8 re8 mi8');
select insertEstablecimiento(2,'Arrin Cuan','-90.5145114','14.6450828',31,'Comida y marimba en vivo todos los dias');

select insertValor(1,10,2,'Carro Pequeño');
select insertValor(2,11,1,'Atrio Mediano');
select insertValor(3,6,10,'Para 2 personas');
select insertValor(3,6,15,'Para 8 personas');
select insertValor(3,6,5,'Para 13 personas');
select insertValor(3,13,1,'Son bien cool :D');
select insertValor(4,6,10,'Para 2 personas');
select insertValor(4,6,5,'Para 13 personas');
select insertValor(4,6,15,'Para 8 personas');
select insertValor(4,13,1,'Son bien medio-cool');
select insertValor(5,6,10,'Para 2 personas');
select insertValor(5,6,15,'Para 8 personas');
select insertValor(5,6,5,'Para 13 personas');
select insertValor(5,13,1,'No tan cool :c');
select insertValor(6,9,12,'Para 10 invitados');
select insertValor(6,9,3,'Para mas de 100 invitados');
select insertValor(7,9,1,'Para 10 invitados');
select insertValor(7,9,1,'Para mas de 99999 invitados');
select insertValor(8,11,1,'Bien grandote y chulo');
select insertValor(8,12,200,'Nuestra señora de la merced');
select insertValor(9,14,40,'Primero primaria');
select insertValor(9,14,40,'Segundo primaria');
select insertValor(9,14,40,'Tercero primaria');
select insertValor(9,14,40,'Cuarto primaria');
select insertValor(9,14,40,'Quinto primaria');
select insertValor(9,14,40,'Sexto primaria');
select insertValor(9,15,2,'Cancha de fut');
select insertValor(10,9,2,'Para conferencias');
select insertValor(11,14,30,'Primero primaria');
select insertValor(11,14,30,'Segundo primaria');
select insertValor(11,14,30,'Tercero primaria');
select insertValor(11,14,30,'Cuarto primaria');
select insertValor(11,14,30,'Quinto primaria');
select insertValor(11,14,30,'Sexto primaria');
select insertValor(11,15,2,'Cancha de fut');
select insertValor(12,10,20,'De mas de 10 Ton');
select insertValor(13,7,20,'Individuales');
select insertValor(13,7,10,'Dobles');
select insertValor(13,7,4,'Triples');
select insertValor(13,8,1,'Muy pequeña');
select insertValor(14,19,1,'Arruinada');
select insertValor(14,18,1,'Campo fut 11');
select insertValor(15,16,100,'Doctores');
select insertValor(15,7,15,'Bonitas');
select insertValor(15,7,150,'Feas');
select insertValor(15,20,1,'Arruinada');
select insertValor(16,19,3,'Bien cuidadas');
select insertValor(16,19,1,'Arruinada');
select insertValor(16,18,1,'Campo fut 11');
select insertValor(16,18,20,'Campo papi fut');
select insertValor(17,22,50,'Buen estado');
select insertValor(17,22,10,'Mal estado');
select insertValor(18,6,4,'Para 5 personas');
select insertValor(18,6,1,'Para 10 personas');
select insertValor(19,6,15,'Para 5 personas');
select insertValor(19,6,4,'Para 8 personas');
select insertValor(20,24,4,'Para Xela');
select insertValor(20,24,14,'Para Peten');
select insertValor(21,24,3,'Para Rehu');
select insertValor(21,24,1,'Para Izabal');
select insertValor(22,13,3,'Para niños');
select insertValor(22,8,1,'Piscina Mediana');
select insertValor(22,9,5,'Para 50 personas');
select insertValor(22,9,3,'Para 200 personas');
select insertValor(22,9,7,'Para 500 personas');
select insertValor(23,16,5,'Con profesionales');
select insertValor(24,13,1,'Para niños');
select insertValor(24,9,1,'MCSalon');
select insertValor(25,14,40,'Primero primaria');
select insertValor(25,14,40,'Segundo primaria');
select insertValor(25,14,40,'Tercero primaria');
select insertValor(25,14,40,'Cuarto primaria');
select insertValor(25,14,40,'Quinto primaria');
select insertValor(25,14,40,'Sexto primaria');
select insertValor(25,15,2,'Cancha de Basquet');
select insertValor(26,9,100,'Pequeños');
select insertValor(27,16,10,'Doctores');
select insertValor(27,16,2,'Cirujanos');
select insertValor(27,16,5,'Oftalmologos');
select insertValor(27,7,15,'Chileras');
select insertValor(27,16,1,'Doctores');
select insertValor(27,7,1,'Descompuesta');
select insertValor(29,14,10,'Bateria 1');
select insertValor(29,14,10,'Bateria 2');
select insertValor(29,14,10,'Bateria 3');
select insertValor(29,14,15,'Bajo 1');
select insertValor(29,14,15,'Bajo 2');
select insertValor(29,14,25,'Guitarra 1');
select insertValor(29,14,25,'Guitarra 2');
select insertValor(29,14,25,'Guitarra 3');
select insertValor(30,6,10,'Para 5 personas');
select insertValor(30,6,5,'Para 15 personas');
select insertValor(30,9,1,'Para todo evento');



select insertValor(2,26,0,'Pequeña');
select insertValor(3,25,0,'Amarillo');
select insertValor(4,25,0,'Rojo');
select insertValor(5,25,0,'Anaranjado');
select insertValor(8,26,0,'Grande');
select insertValor(9,26,0,'Grande');
select insertValor(9,27,0,'Cool');
select insertValor(19,28,0,'Obscuro');
select insertValor(19,27,0,'Dark');

select insertServicio('Hospedaje'); -- 1
select insertServicio('Comida'); -- 2
select insertServicio('Conferencias'); -- 3
select insertServicio('Misa'); -- 4
select insertServicio('Casamiento'); -- 5
select insertServicio('Comunion'); -- 6
select insertServicio('Juegos'); -- 7
select insertServicio('Educacion'); -- 8
select insertServicio('Ahorros'); -- 9
select insertServicio('Prestamos'); -- 10
select insertServicio('Enderesado'); -- 11
select insertServicio('Pintura'); -- 12
select insertServicio('Over Haul'); -- 13
select insertServicio('Ejercicio'); -- 14
select insertServicio('Consulta'); -- 15
select insertServicio('Emergencia'); -- 16
select insertServicio('Cirugia'); -- 17
select insertServicio('Musicon'); -- 18
select insertServicio('Transporte'); -- 19
select insertServicio('Velorio'); -- 20
select insertServicio('Balanceo'); -- 21
select insertServicio('Recreacion'); -- 22
select insertServicio('Profesionalismo'); -- 24
select insertServicio('Calidad'); -- 25
select insertServicio('Seguridad'); -- 26
select insertServicio('General');



select insertEstablecimientoServicio(11,1,20);
select insertEstablecimientoServicio(12,1,80);
select insertEstablecimientoServicio(4,2,100);
select insertEstablecimientoServicio(2,3,85);
select insertEstablecimientoServicio(7,3,15);
select insertEstablecimientoServicio(2,4,80);
select insertEstablecimientoServicio(7,4,20);
select insertEstablecimientoServicio(2,5,75);
select insertEstablecimientoServicio(7,5,25);
select insertEstablecimientoServicio(20,6,50);
select insertEstablecimientoServicio(2,6,50);
select insertEstablecimientoServicio(20,7,95);
select insertEstablecimientoServicio(4,8,70);
select insertEstablecimientoServicio(5,8,20);
select insertEstablecimientoServicio(6,8,10);
select insertEstablecimientoServicio(8,9,99);
select insertEstablecimientoServicio(7,9,1);
select insertEstablecimientoServicio(9,10,60);
select insertEstablecimientoServicio(10,10,40);
select insertEstablecimientoServicio(8,11,55);
select insertEstablecimientoServicio(7,11,45);
select insertEstablecimientoServicio(11,12,20);
select insertEstablecimientoServicio(12,12,30);
select insertEstablecimientoServicio(13,12,30);
select insertEstablecimientoServicio(20,12,20);
select insertEstablecimientoServicio(1,13,34);
select insertEstablecimientoServicio(2,13,33);
select insertEstablecimientoServicio(3,13,33);
select insertEstablecimientoServicio(14,14,100);
select insertEstablecimientoServicio(1,15,10);
select insertEstablecimientoServicio(15,15,20);
select insertEstablecimientoServicio(16,15,30);
select insertEstablecimientoServicio(17,15,40);
select insertEstablecimientoServicio(14,16,50);
select insertEstablecimientoServicio(21,16,50);
select insertEstablecimientoServicio(2,17,90);
select insertEstablecimientoServicio(18,17,10);
select insertEstablecimientoServicio(2,18,100);
select insertEstablecimientoServicio(2,19,10);
select insertEstablecimientoServicio(18,19,90);
select insertEstablecimientoServicio(19,20,100);
select insertEstablecimientoServicio(19,21,100);
select insertEstablecimientoServicio(22,22,90);
select insertEstablecimientoServicio(18,22,10);
select insertEstablecimientoServicio(24,23,50);
select insertEstablecimientoServicio(25,23,50);
select insertEstablecimientoServicio(2,24,100);
select insertEstablecimientoServicio(8,25,95);
select insertEstablecimientoServicio(22,25,5);
select insertEstablecimientoServicio(25,26,90);
select insertEstablecimientoServicio(22,26,10);
select insertEstablecimientoServicio(24,27,20);
select insertEstablecimientoServicio(25,27,20);
select insertEstablecimientoServicio(25,27,10);
select insertEstablecimientoServicio(17,27,50);
select insertEstablecimientoServicio(24,28,20);
select insertEstablecimientoServicio(25,28,20);
select insertEstablecimientoServicio(25,28,10);
select insertEstablecimientoServicio(17,28,50);
select insertEstablecimientoServicio(24,29,40);
select insertEstablecimientoServicio(8,29,60);
select insertEstablecimientoServicio(25,30,50);
select insertEstablecimientoServicio(2,30,50);


DROP PROCEDURE IF EXISTS LlenarTipoEstablecimientos1;
DELIMITER $$
CREATE PROCEDURE LlenarTipoEstablecimientos1(
) BEGIN
  DECLARE v_nombre VARCHAR(120);
  DECLARE ex INT;
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Nombre FROM CSV1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;


  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
      IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from TipoEstablecimiento Where nombre=v_nombre into ex;
    IF ex=0 THEN
   IF v_nombre != '' THEN
  select insertTipoEstablecimiento(v_nombre);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarEstablecimientos1;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientos1 (
) BEGIN

  DECLARE v_nombre VARCHAR(120);
  DECLARE v_latitud VARCHAR(120);
  DECLARE v_longitud VARCHAR(120);
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_nombreTipo VARCHAR(120);
  DECLARE v_descripcion VARCHAR(120);
  DECLARE v_idUsuario INT;
  DECLARE v_idTipo INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Nombre,Nombre1, Latitud, Longitud,is_Oficial,Descripcion FROM CSV1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombreTipo,v_nombre, v_latitud, v_longitud, v_usuario,v_descripcion;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombre != '' THEN
  IF v_usuario != 0 THEN
  select id from TipoEstablecimiento Where nombre=v_nombreTipo into v_idTipo;
  select insertUsuario(2,CONCAT('Grupo1 ',v_nombre),'Usuario Grupo 1','1994/12/21','','',1,'pokemon') INTO v_idUsuario;
  select insertEstablecimiento(v_idTipo,v_nombre,v_longitud,v_latitud,v_idUsuario,'Establecimiento del Grupo6');
  ELSE
  select id from TipoEstablecimiento Where nombre=v_nombreTipo into v_idTipo;
  select insertEstablecimiento(v_idTipo,v_nombre,v_longitud,v_latitud,0,'Establecimiento del Grupo6');
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS LlenarServicios1;
DELIMITER $$
CREATE PROCEDURE LlenarServicios1(
) BEGIN
  DECLARE v_nombre VARCHAR(120);
DECLARE ex INT;
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Nombre2 FROM CSV1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from Servicio where nombre= v_nombre into ex;
    IF ex =0 THEN
   IF v_nombre != '' THEN
  select insertServicio(v_nombre);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarEstablecimientosServicios1;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientosServicios1 (
) BEGIN

  DECLARE v_nombre1 VARCHAR(120);
  DECLARE v_nombre2 VARCHAR(120);

  DECLARE v_idAtributo INT;
  DECLARE v_idEstablecimiento INT;
  DECLARE v_idServicio INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Nombre1,Nombre2 FROM CSV1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre1,v_nombre2;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombre2 != '' THEN
  select E.id from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstablecimiento=E.id AND V.Valor=v_nombre1 LIMIT 1 into v_idEstablecimiento;
  select S.id from Servicio S where S.nombre=v_nombre2 into v_idServicio;
  select insertEstablecimientoServicio(v_idServicio,v_idEstablecimiento,25);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS LlenarUsuarios1;
DELIMITER $$
CREATE PROCEDURE LlenarUsuarios1 (
) BEGIN
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_telefono VARCHAR(120);
  DECLARE v_correo VARCHAR(120);
  DECLARE v_password VARCHAR(120);
  DECLARE v_nombre VARCHAR(120);
  DECLARE ex INT;
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Nombre3, Nick,	Email,	Password FROM CSV1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre, v_usuario, v_correo, v_password;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  select count(*) from Usuario where usuario=v_usuario into ex;
  IF ex =0 THEN
   IF v_usuario != '' THEN
  select insertUsuario(3,v_usuario,v_nombre,'1994/12/21','',v_correo,1,v_password);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS Grupo1;
DELIMITER $$
CREATE PROCEDURE Grupo1 (
) BEGIN
call LlenarTipoEstablecimientos1();
call LlenarEstablecimientos1();
call LlenarServicios1();
call LlenarEstablecimientosServicios1();
call LlenarUsuarios1();
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarTipoEstablecimientos2;
DELIMITER $$
CREATE PROCEDURE LlenarTipoEstablecimientos2(
) BEGIN
  DECLARE v_nombre VARCHAR(120);
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE ex INT;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct establecimiento_tipo FROM CSV2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from TipoEstablecimiento where nombre = v_nombre into ex;
    IF ex=0 THEN
   IF v_nombre != '' THEN
  select insertTipoEstablecimiento(v_nombre);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarUsuarios2;
DELIMITER $$
CREATE PROCEDURE LlenarUsuarios2 (
) BEGIN
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_telefono VARCHAR(120);
  DECLARE v_correo VARCHAR(120);
  DECLARE v_password VARCHAR(120);
  DECLARE v_nombre VARCHAR(120);
  DECLARE v_rol VARCHAR(120);
  DECLARE ex INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct usuario_nombre,usuario_correo,usuario_telefono,usuario_rol,usuario_password FROM CSV2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre, v_correo, v_telefono, v_rol,v_password;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from Usuario Where usuario=v_nombre into ex;
    IF ex=0 THEN
   IF v_nombre != '' THEN
   IF v_rol='especial' THEN
  select insertUsuario(2,v_nombre,v_nombre,'1994/12/21',v_telefono,v_correo,1,v_password);
  ELSE
  select insertUsuario(3,v_nombre,v_nombre,'1994/12/21',v_telefono,v_correo,1,v_password);
  END IF;
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;




DROP PROCEDURE IF EXISTS LlenarEstablecimientos2;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientos2 (
) BEGIN

  DECLARE v_nombre VARCHAR(120);
  DECLARE v_latitud VARCHAR(120);
  DECLARE v_longitud VARCHAR(120);
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_nombreTipo VARCHAR(120);
  DECLARE v_descripcion VARCHAR(120);
  DECLARE v_oficial VARCHAR(120);
  DECLARE v_idUsuario INT;
  DECLARE v_idTipo INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct establecimiento_nombre,establecimiento_tipo,establecimiento_longitud,establecimiento_latitud,establecimiento_oficial FROM CSV2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre,v_nombreTipo, v_longitud, v_latitud, v_oficial;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombre != '' THEN
  IF v_oficial != 0 THEN
  select id from TipoEstablecimiento Where nombre=v_nombreTipo into v_idTipo;
  select insertUsuario(2,CONCAT('Grupo2 ',v_nombre),'Usuario Grupo 2','1994/12/21','','',1,'pokemon') INTO v_idUsuario;
  select insertEstablecimiento(v_idTipo,v_nombre,v_longitud,v_latitud,v_idUsuario,'Establecimiento del Grupo2');
  ELSE
  select id from TipoEstablecimiento Where nombre=v_nombreTipo into v_idTipo;
  select insertEstablecimiento(v_idTipo,v_nombre,v_longitud,v_latitud,0,'Establecimiento del Grupo2');
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarServicios2;
DELIMITER $$
CREATE PROCEDURE LlenarServicios2(
) BEGIN
  DECLARE v_nombre VARCHAR(120);
  DECLARE ex INT;
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct servicio_nombre FROM CSV2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from Servicio where nombre= v_nombre into ex;
    IF ex=0 THEN
   IF v_nombre != '' THEN
  select insertServicio(v_nombre);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS LlenarAtributos2;
DELIMITER $$
CREATE PROCEDURE LlenarAtributos2(
) BEGIN
  DECLARE v_nombre VARCHAR(120);

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct caracteristica_nombre FROM CSV2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
   IF v_nombre != '' THEN
  select insertAtributo(v_nombre,0);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS LlenarEstablecimientosServicios2;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientosServicios2 (
) BEGIN

  DECLARE v_nombre1 VARCHAR(120);
  DECLARE v_nombre2 VARCHAR(120);

  DECLARE v_idAtributo INT;
  DECLARE v_idEstablecimiento INT;
  DECLARE v_idServicio INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct establecimiento_nombre,servicio_nombre FROM CSV2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre1,v_nombre2;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombre2 != '' THEN
  select E.id from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstablecimiento=E.id AND V.Valor=v_nombre1 LIMIT 1 into v_idEstablecimiento;
  select S.id from Servicio S where S.nombre=v_nombre2 into v_idServicio;
  select insertEstablecimientoServicio(v_idServicio,v_idEstablecimiento,25);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarEstablecimientosAtributos2;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientosAtributos2 (
) BEGIN

  DECLARE v_nombree VARCHAR(120);
  DECLARE v_nombrec VARCHAR(120);
  DECLARE v_valor VARCHAR(120);
  DECLARE v_cantidad VARCHAR(120);

  DECLARE v_idAtributo INT;
  DECLARE v_idEstablecimiento INT;
  DECLARE v_idServicio INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct establecimiento_nombre,caracteristica_nombre,caracteristica_valor,caracteristica_Fid_servicio FROM CSV2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;
  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombree,v_nombrec,v_valor,v_cantidad;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombrec != '\N' THEN
  select E.id from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstablecimiento=E.id AND V.Valor=v_nombree LIMIT 1 into v_idEstablecimiento;
  select A.id from Atributo A where A.nombre=v_nombrec into v_idAtributo;

  select insertValor(v_idEstablecimiento,v_idAtributo,0,v_valor);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;




DROP PROCEDURE IF EXISTS LlenarComentarios2;
DELIMITER $$
CREATE PROCEDURE LlenarComentarios2 (
) BEGIN
  DECLARE v_nombre VARCHAR(120);
  DECLARE v_nombre2 VARCHAR(120);
  DECLARE v_contenido VARCHAR(120);
  DECLARE v_usuario VARCHAR(120);

  DECLARE v_idEstablecimiento INT;
  DECLARE v_idUsuario INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct usuario_nombre, establecimiento_nombre,comentario_id_comentario, comentario_contenido FROM CSV2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_usuario,v_nombre,v_nombre2,v_contenido;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_contenido != '\N' THEN
  select E.id from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstablecimiento=E.id AND V.valor=v_nombre LIMIT 1 into v_idEstablecimiento;
  select id from Usuario where usuario=v_usuario into v_idUsuario;
  select insertComentario(v_idEstablecimiento,v_idUsuario,v_contenido);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;

END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS Grupo2;
DELIMITER $$
CREATE PROCEDURE Grupo2 (
) BEGIN
call LlenarTipoEstablecimientos2();
call LlenarUsuarios2();
call LlenarEstablecimientos2();
call LlenarServicios2();
call LlenarAtributos2();
call LlenarEstablecimientosServicios2();
call LlenarEstablecimientosAtributos2();
call LlenarComentarios2();
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS LlenarTipoEstablecimientos3;
DELIMITER $$
CREATE PROCEDURE LlenarTipoEstablecimientos3(
) BEGIN
  DECLARE v_nombre VARCHAR(120);
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE ex INT;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Tipo_Establecimiento FROM CSV3;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    Select count(*) from TipoEstablecimiento WHERE nombre=v_nombre into ex;
    IF ex=0 THEN
   IF v_nombre != '' THEN
  select insertTipoEstablecimiento(v_nombre);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;




DROP PROCEDURE IF EXISTS LlenarServicios3;
DELIMITER $$
CREATE PROCEDURE LlenarServicios3(
) BEGIN
  DECLARE v_nombre VARCHAR(120);
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Servicio_Establecimiento FROM CSV3;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
   IF v_nombre != '' THEN
  select insertServicio(v_nombre);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;



END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarEstablecimientos3;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientos3 (
) BEGIN

  DECLARE v_nombre VARCHAR(120);
  DECLARE v_latitud VARCHAR(120);
  DECLARE v_longitud VARCHAR(120);
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_tipo VARCHAR(120);
  DECLARE v_descripcion VARCHAR(120);
  DECLARE v_oficial VARCHAR(120);
  DECLARE v_idUsuario INT;
  DECLARE v_idTipo INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Nombre,	Latitud, Longitud,	Tipo_Establecimiento,	Establecimiento_Oficial FROM CSV3;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre,v_latitud,v_longitud,v_tipo, v_oficial;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombre != '' THEN
  IF v_oficial ='Si' THEN
  select id from TipoEstablecimiento Where nombre=v_tipo into v_idTipo;
  select insertUsuario(2,CONCAT('Grupo3 ',v_nombre),'Usuario Grupo 3','1994/12/21','','',1,'pokemon') INTO v_idUsuario;
  select insertEstablecimiento(v_idTipo,v_nombre,v_longitud,v_latitud,v_idUsuario,'Establecimiento del Grupo3');
  ELSE
  select id from TipoEstablecimiento Where nombre=v_tipo into v_idTipo;
  select insertEstablecimiento(v_idTipo,v_nombre,v_longitud,v_latitud,0,'Establecimiento del Grupo3');
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS LlenarEstablecimientosServicios3;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientosServicios3 (
) BEGIN

  DECLARE v_nombre1 VARCHAR(120);
  DECLARE v_nombre2 VARCHAR(120);

  DECLARE v_idAtributo INT;
  DECLARE v_idEstablecimiento INT;
  DECLARE v_idServicio INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct Nombre,Servicio_Establecimiento FROM CSV3;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre1,v_nombre2;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombre2 != '' THEN
  select E.id from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstable=E.id AND V.Valor=v_nombre1 LIMIT 1 into v_idEstablecimiento;
  select S.id from Servicio S where S.nombre=v_nombre2 into v_idServicio;
  select insertEstablecimientoServicio(v_idServicio,v_idEstablecimiento,25);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS Grupo3;
DELIMITER $$
CREATE PROCEDURE Grupo3(
) BEGIN

call LlenarTipoEstablecimientos3();
call LlenarServicios3();
call LlenarEstablecimientos3();
call LlenarEstablecimientosServicios3();
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarTipoEstablecimientos4;
DELIMITER $$
CREATE PROCEDURE LlenarTipoEstablecimientos4(
) BEGIN
  DECLARE v_nombre VARCHAR(120);

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE ex INT;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct nombre_tipest FROM CSV4;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from TipoEstablecimiento where nombre = v_nombre into ex;
    IF ex=0 THEN
   IF v_nombre != '' THEN
  select insertTipoEstablecimiento(v_nombre);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS LlenarUsuarios4;
DELIMITER $$
CREATE PROCEDURE LlenarUsuarios4 (
) BEGIN
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_telefono VARCHAR(120);
  DECLARE v_correo VARCHAR(120);
  DECLARE v_password VARCHAR(120);
  DECLARE v_nombre VARCHAR(120);
  DECLARE v_rol VARCHAR(120);
  DECLARE ex INT;


  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct usuario,nombre_us,password FROM CSV4;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_usuario, v_nombre, v_password;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from Usuario Where usuario=v_nombre into ex;
    IF ex=0 THEN
   IF v_nombre != '' THEN
  select insertUsuario(1,v_usuario,v_nombre,'1994/12/21','Telefono Grupo4','Cosa@grupo4.com',1,v_password);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarEstablecimientos4;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientos4 (
) BEGIN

  DECLARE v_nombre VARCHAR(120);
  DECLARE v_latitud VARCHAR(120);
  DECLARE v_longitud VARCHAR(120);
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_nombreTipo VARCHAR(120);
  DECLARE v_descripcion VARCHAR(120);
  DECLARE v_oficial VARCHAR(120);
  DECLARE v_idUsuario INT;
  DECLARE v_idTipo INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR


  SELECT distinct nombre_est,latitud,longitud,descripcion_est,nombre_tipest FROM CSV4;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre, v_latitud, v_longitud, v_descripcion,v_nombreTipo;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombre != '' THEN

  select id from TipoEstablecimiento Where nombre=v_nombreTipo into v_idTipo;
  select insertUsuario(2,CONCAT('Grupo4 ',v_nombre),'Usuario Grupo 4','1994/12/21','','',1,'pokemon') INTO v_idUsuario;
  select insertEstablecimiento(v_idTipo,v_nombre,v_longitud,v_latitud,v_idUsuario,v_descripcion);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarServicios4;
DELIMITER $$
CREATE PROCEDURE LlenarServicios4(
) BEGIN
  DECLARE v_nombre VARCHAR(120);
  DECLARE ex INT;
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct nombre_ser FROM CSV4;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from Servicio where nombre= v_nombre into ex;
    IF ex=0 THEN
   IF v_nombre != '' THEN
  select insertServicio(v_nombre);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;




DROP PROCEDURE IF EXISTS LlenarAtributos4;
DELIMITER $$
CREATE PROCEDURE LlenarAtributos4(
) BEGIN
  DECLARE v_nombre VARCHAR(120);

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct nombre_car FROM CSV4;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
   IF v_nombre != '' THEN
  select insertAtributo(v_nombre,0);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarEstablecimientosServicios4;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientosServicios4 (
) BEGIN

  DECLARE v_nombre1 VARCHAR(120);
  DECLARE v_nombre2 VARCHAR(120);

  DECLARE v_idAtributo INT;
  DECLARE v_idEstablecimiento INT;
  DECLARE v_idServicio INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct nombre_est,nombre_ser FROM CSV4;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre1,v_nombre2;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombre2 != '' THEN
  select E.id from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstablecimiento=E.id AND V.Valor=v_nombre1 LIMIT 1 into v_idEstablecimiento;
  select S.id from Servicio S where S.nombre=v_nombre2 into v_idServicio;
  select insertEstablecimientoServicio(v_idServicio,v_idEstablecimiento,25);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;





DROP PROCEDURE IF EXISTS LlenarEstablecimientosAtributos4;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientosAtributos4 (
) BEGIN

  DECLARE v_nombree VARCHAR(120);
  DECLARE v_nombrec VARCHAR(120);
  DECLARE v_valor VARCHAR(120);
  DECLARE v_cantidad VARCHAR(120);

  DECLARE v_idAtributo INT;
  DECLARE v_idEstablecimiento INT;
  DECLARE v_idServicio INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct nombre_est,nombre_car,nombre_cat,servicio_detser FROM CSV4;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;
  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombree,v_nombrec,v_valor,v_cantidad;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  IF v_nombree != '\N' THEN
  select E.id from Establecimiento E, Valor V where V.idAtributo=1 AND V.idEstablecimiento=E.id AND V.Valor=v_nombree LIMIT 1 into v_idEstablecimiento;
  select A.id from Atributo A where A.nombre=v_nombrec into v_idAtributo;
  select insertValor(v_idEstablecimiento,v_idAtributo,0,v_valor);
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;





DROP PROCEDURE IF EXISTS Grupo4;
DELIMITER $$
CREATE PROCEDURE Grupo4 (
) BEGIN
call LlenarTipoEstablecimientos4();
call LlenarUsuarios4();
call LlenarEstablecimientos4();
call LlenarServicios4();
call LlenarAtributos4();
call LlenarEstablecimientosServicios4();
call LlenarEstablecimientosAtributos4();
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarUsuariosOwner6;
DELIMITER $$
CREATE PROCEDURE LlenarUsuariosOwner6 (
) BEGIN
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_telefono VARCHAR(120);
  DECLARE v_correo VARCHAR(120);
  DECLARE v_password VARCHAR(120);
  DECLARE v_nombre VARCHAR(120);
  DECLARE ex INT;
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct USERNAME_USER_CREADOR,	TELEFONO_USER_CREADOR,	CORREO_USER_CREADOR,	PASSWORD_USER_CREADOR,	NOMBRE_USER_CREADOR FROM CSV6;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_usuario, v_telefono, v_correo, v_password, v_nombre;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
    select count(*) from Usuario Where usuario=v_usuario into ex;
    IF ex=0 THEN
   IF v_usuario != '' THEN
  select insertUsuario(2,v_usuario,v_nombre,'',v_telefono,v_correo,1,v_password);
  END IF;
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS LlenarEstablecimientos6;
DELIMITER $$
CREATE PROCEDURE LlenarEstablecimientos6 (
) BEGIN

  DECLARE v_nombre VARCHAR(120);
  DECLARE v_latitud VARCHAR(120);
  DECLARE v_longitud VARCHAR(120);
  DECLARE v_usuario VARCHAR(120);
  DECLARE v_idUsuario INT;

  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR
  SELECT distinct NOMBRE_ESTABLECIMIENTO, LATITUD_ESTABLECIMIENTO, LONGITUD_ESTABLECIMIENTO,USERNAME_USER_CREADOR FROM CSV6;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;

  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_nombre, v_latitud, v_longitud, v_usuario;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
   IF v_nombre != '' THEN
  select id from Usuario Where usuario=v_usuario into v_idUsuario;
  select insertEstablecimiento(1,v_nombre,v_longitud,v_latitud,v_idUsuario,'Establecimiento del Grupo6');
  END IF;
  END LOOP get_runners;
  CLOSE runners_cursor;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS Grupo6;
DELIMITER $$
CREATE PROCEDURE Grupo6 (
) BEGIN
call LlenarUsuariosOwner();
call LlenarEstablecimientos();
END$$
DELIMITER ;
