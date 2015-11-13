var multer = require('multer');
var storage = multer.diskStorage({
	destination: function(req, file, cb) {
		cb(null, '../uploads_from_server/')
	},
	filename: function(req, file, cb) {
		cb(null, "[" + file.fieldname + '-' + Date.now() + "]" + file.originalname)
	}
});
var upload = multer({
	storage: storage
});

var express = require('express');
var router = express.Router();


router.get('/', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		 res.redirect('/login?error=debe iniciar sesion primero');
	}

  res.render('admin/principal', { mivar: 'nombre',otra: '<button>caca </button>' });
});

router.get('/gestionDeDatos', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		res.redirect('/login?error=debe iniciar sesion primero');
	}

	res.render('admin/gestionDeDatos', { mivar: 'nombre' });
});


router.get('/reportes', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		res.redirect('/login?error=debe iniciar sesion primero');
	}
	var dbconnection = require('../routes/dbconnection.js'); 
	str_query='select * from Usuario where idTipoUsuario=2;'
	dbconnection.exe_query(
		str_query,
		mandar_usuarios,
		res)
	function mandar_usuarios(result){
		res.render('admin/reportes', 
			{ mivar: 'nombre' ,
			usuarios: result
		});	
	}	

});


router.post('/importarBD', upload.single('archToImport'), function(req, res, next) {
	// req.file is the `avatar` file
	// req.body will hold the text fields, if there were any
	console.log('req: ' + JSON.stringify(req.file));
	console.log('tipo: ' + req.body.tipo);


	str_query = "truncate table CSV"+req.body.tipo+";";
	var dbconnection = require('../routes/dbconnection.js'); 
	dbconnection.exe_query(
		str_query,
		function(result){

			str_query = "LOAD DATA LOCAL INFILE '"+req.file.path+"' INTO TABLE CSV1 FIELDS TERMINATED BY ',' IGNORE 1 LINES(id_Tipo_Establecimiento	,Nombre	,Estado	,Servicio_Default	,id_Establecimiento	,Nombre1	,Latitud	,Longitud	,is_Oficial	,Tipo	,Estado1	,Descripcion	,id_Servicio_Establecimiento	,id_Servicio	,id_Establecimiento1	,Prioridad	,Estado2	,id_Servicio1	,Nombre2	,Estado3	,id_Detalle_Tipo	,Etiqueta	,Tipo_Dato	,es_Reservable	,Metrica_Reserva	,id_Detalle_Servicio	,Estado4	,Valor	,Descripcion1	,id_Servicio_Establecimiento1	,Servicio_id_Servicio	,Hora_Check_In	,id_Establecimiento2	,id_Usuario	,Estado5	,id_Usuario1	,Nombre3	,Nick	,Email	,Estado6	,Password	,id_Usuario2	,id_Rol	,Estado7	,id_Rol1	,Nombre4	,Estado8	,id_Calificacion	,id_Categoria	,Valor1	,Fecha	,Comentario	,id_Servicio_Establecimiento2	,id_Categoria1	,Nombre5	,Tipo_Dato1	,Estado9	,id_Detalle_Categoria	,Valor2	,id_Categoria2	,Estado10	,id_Reserva	,Fecha_Inicio	,Fecha_Fin	,Aprobada	,Usuario_id_Usuario,id_Detalle_Servicio1);";
			if(req.body.tipo == 2) str_query = "LOAD DATA LOCAL INFILE '"+req.file.path+"' INTO TABLE CSV2 FIELDS TERMINATED BY ',' IGNORE 1 LINES(establecimiento_id_establecimiento,establecimiento_nombre,establecimiento_direccion,establecimiento_tipo,establecimiento_longitud,establecimiento_latitud,establecimiento_oficial,establecimiento_calificacion_general,establecimiento_dimension_id_establecimiento,establecimiento_dimension_id_dimension,establecimiento_dimension_id_categoria,categoria_id_categoria,categoria_nombre,categoria_descripcion,servicio_id_servicio,servicio_nombre, servicio_descripcion,caracteristica_id_caracteristica,caracteristica_nombre,caracteristica_valor,caracteristica_Fid_servicio,establecimiento_servicio_id_establecimiento_servicio,establecimiento_servicio_Fid_establecimiento,establecimiento_servicio_Fid_servicio,usuario_id_usuario,usuario_nombre,usuario_correo,usuario_telefono,usuario_rol,usuario_id_establecimiento,usuario_password,prereserva_id_prereserva,prereserva_horayfecha,prereserva_cantpersonas,prereserva_id_establecimiento_servicio,prereserva_id_usuario,comentario_id_comentario,comentario_contenido,comentario_calificacion,comentario_Fid_establecimiento_servicio);";
			if(req.body.tipo == 3) str_query = "LOAD DATA LOCAL INFILE '"+req.file.path+"' INTO TABLE CSV3 FIELDS TERMINATED BY ',' IGNORE 1 LINES(ID_Establecimiento,Nombre,Latitud, Longitud,Tipo_Establecimiento,Establecimiento_Oficial,Servicio_Establecimiento,Descripcion_Servicio,Calificacion,Comentario);";
			if(req.body.tipo == 4) str_query = "LOAD DATA LOCAL INFILE '"+req.file.path+"' INTO TABLE CSV4 FIELDS TERMINATED BY ',' IGNORE 1 LINES(calificacion	,punteo_cal	,usuario_cal	,servicio_cal	,comentario_cal	,caracteristica	,nombre_car	,duracion	,categoria	,dimension_cat	,nombre_cat	,servicio_detser	,caracteristica_detser	,dimension	,nombre_dim	,dimension_dimest	,establecimiento_dimest	,establecimiento	,nombre_est	,latitud,longitud	,descripcion_est	,punteo_est	,tipoest_est	,oficial	,reserva	,fecha	,usuario_res	,servicio_res	,servicio	,cupo	,punteo_ser	,establecimiento_ser	,tiposer_ser	,nombre_ser	,tipo_establecimiento	,nombre_tipest	,descripcion_tipest	,tipo_servicio	,nombre_tipser	,descripcion_tipser	,id_usuario	,usuario	,nombre_us	,apellido	,rol	,password);";
			if(req.body.tipo == 6) str_query = "LOAD DATA LOCAL INFILE '"+req.file.path+"' INTO TABLE CSV6 FIELDS TERMINATED BY ',' IGNORE 1 LINES(ESTABLECIMIENTO,	TELEFONO_ESTABLECIMIENTO,	DIRECCION_ESTABLECIMIENTO,	NOMBRE_ESTABLECIMIENTO	,LATITUD_ESTABLECIMIENTO,	LONGITUD_ESTABLECIMIENTO,	USERNAME_USER_CREADOR,	TELEFONO_USER_CREADOR	,CORREO_USER_CREADOR	,PASSWORD_USER_CREADOR	,NOMBRE_USER_CREADOR	,TIPONOMBRE_USER_CREADOR,NOMBRE_DIMENSION,	NOMBRE_ATRIBUTO	,DESCRIPCION_ATRIBUTO,	NOMBRE_SERVICIO,	DESCRIPCION_SERVICIO,NOMBRE_R_C	,SERVICIO_TRC,	ESTABLECIMIENTO_TRC,	VALOR_RC	,COMENTARIO_RC	,INICIO_RC	,FINAL_RC,USERNAME_USER_TRC	,TELEFONO_USER_TRC	,CORREO_USER_TRC	,PASSWORD_USER_TRC,	NOMBRE_USER_TRC	,  NOMBRE_TIPOUSUARIOTRC, OTRA);";
			var dbconnection = require('../routes/dbconnection.js'); 
			dbconnection.exe_query(
				str_query,
				function(result2){

					str_query = "call Grupo"+req.body.tipo+"()";
					var dbconnection = require('../routes/dbconnection.js'); 
					dbconnection.exe_query(
						str_query,
						function(result3){

							res.render('admin/principal', { exito2: 'Importado exitosamente < br / > ' + result + '< br / >' + result2 + '< br / >' + result3 });
						},
						res)



				},
				res)

		},
		res)

	//res.send(req.file.path);
	
});


var valor_insert = function(entrada){
	var index=[];
	for (var x in entrada[0]) {
		  index.push(x);
		  console.log(x);
	}		
	var val=entrada[0][index[0]]
	return val
}


router.post('/bitacora',function(req,res) {

	var dbconnection = require('../routes/dbconnection.js'); 
	str_query='call selectBitacora();'
	dbconnection.exe_query(
		str_query,
		function(result){
			res.send(result)
		},
		res)
	// body...
})

router.get('/bitacora',function(req,res) {
	var jsreport = require('jsreport');
	var dbconnection = require('../routes/dbconnection.js'); 
	str_query='call selectBitacora();'
	dbconnection.exe_query(
		str_query,
		function(result){

			jsreport.render("<h1>Hello world</h1> <br> " + result).then(function(out) {
				out.stream.pipe(res);
			}).catch(function(e) {    
				res.end(e.message);
			});

		},
		res)
	// body...
})

router.post('/exportar',function(req,res) {
	var dbconnection = require('../routes/dbconnection.js'); 
	str_query='call Taran();'
	dbconnection.exe_query(
		str_query,
		function(result){
			res.send(result)
		},
		res)
})
router.post('/reportes/filtro1',function(req,res) {
	var dbconnection = require('../routes/dbconnection.js'); 
	str_query='call selectEstablecimientosOwner('+req.body.id_usuario+');'
	dbconnection.exe_query(
		str_query,
		function(result){
			res.send(result[0])
		},
		res)
	// body...
})

router.post('/registrar',function(req,res) {
	var tipo_usuario=2;
	var nombre= "'"+req.body.nombre+"'";
	var correo= "'"+req.body.Correo+"'";
	var username= "'"+req.body.NombreUsuario+"'";
	var pass= "'"+req.body.Contrasenia+"'";	
	var tel= "'"+req.body.Telefono+"'";
	var FechaNacimiento= "'"+req.body.FechaNacimiento+"'";
	var genero= req.body.genero; //no se como
	console.log(req.body.genero)
	console.log("nom "+nombre+" mail: "+correo+" usern:"+username+" pas:"+pass+" tel:"+tel+" fecha:"+FechaNacimiento+" gen:"+genero);
	function registrar_usuario(exito){		

		if(valor_insert(exito)!='0'){
			res.render('admin/principal', { 				
				exito2: 'Usuario registrado con exito'
			});
		}else{
			res.render('admin/principal', { 				
				error2: 'Ocurrió un problema para registrar usuario'				
			});
		}
	}

	var dbconnection = require('../routes/dbconnection.js'); 
    var str_query = "select insertUsuario("+tipo_usuario+","+username+","+nombre+","+FechaNacimiento+","+tel
    	+","+correo+","+genero+","+pass+");";
	console.log(str_query);	
	dbconnection.exe_query(
			str_query, 
			registrar_usuario,
			res);    			
	// body...	
});


module.exports = router;
