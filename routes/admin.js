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
		str_query='call selectEstablecimiento()'
		dbconnection.exe_query(
			str_query,
			mandar_establecimientos,
			res)

		function mandar_establecimientos(establecimientoss){
			str_query='select * from tipoEstablecimiento'
			dbconnection.exe_query(
				str_query,
				mandar_tipos_establecimientos,
				res)
			function mandar_tipos_establecimientos(tiposs){
				str_query='call selectServicioTodos()'
				dbconnection.exe_query(
					str_query,
					mandar_servicios,
					res)
				function mandar_servicios(ser){
					res.render('admin/reportes', 
						{ mivar: 'nombre' ,
						usuarios: result,
						establecimientos: establecimientoss[0],
						tipos: tiposs,
						servicios: ser[0]
					});	
				}		
			}
		}

	}	

});


router.post('/importarBD', upload.single('archToImport'), function(req, res, next) {
	// req.file is the `avatar` file
	// req.body will hold the text fields, if there were any
	console.log('req: ' + JSON.stringify(req.file));


	res.send(req.file.path);
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

router.post('/exportar',function(req,res) {
	var dbconnection = require('../routes/dbconnection.js'); 
	str_query='call Taran();'
	dbconnection.exe_query(
		str_query,
		function(result){
			res.send(result)
		},
		res)
	// body...
})
router.post('/reportes/filtro1',function(req,res) {
	var dbconnection = require('../routes/dbconnection.js'); 
	str_query='call consulta11('+req.body.id_usuario+');'
	dbconnection.exe_query(
		str_query,
		c2,
		res)
	function c2(resultados1){
		str_query='call consulta12('+req.body.id_usuario+');'
		dbconnection.exe_query(
			str_query,
			c3,
			res)
		function c3(resultados2){
			str_query='call consulta13('+req.body.id_usuario+');'
			dbconnection.exe_query(
				str_query,
				function(resultados3){
					req.send({
						consulta1: resultados1,
						consulta2: resultados2,
						consulta3: resultados3
					}
						)
					}
				},
				res)
		}

	}
	// body...
})


router.post('/reportes/reporte4',function(req,res) {
	var dbconnection = require('../routes/dbconnection.js'); 
	var u=req.body.usuario
	var a=req.body.accion
	var f=req.body.fecha
	var e=req.body.establecimiento
	console.log("PARAMETROS**********")
	console.log(req.body.usuario)
	console.log(req.body.accion)	
	str_query='select * from Bitacora'
	if(u!='-1'||a!='-1'||e!='-1'||f!=''){
		str_query=str_query+" where "
		if(a!='-1'){
			str_query=str_query+" descripcion like '%"+a+"%'"
			if(u!='-1'||e!='-1'||f!=''){
				str_query=str_query+" and "
			}
		}
		if(u!='-1'){
			str_query=str_query+" idUsuario="+u
			if(e!='-1'||f!=''){
				str_query=str_query+" and "
			}
		}
		if(e!='-1'){
			str_query=str_query+" descripcion like '%"+e+"%'"
			if(f!=''){
				str_query=str_query+" and "	
			}
		}
		if(f!=''){
			str_query=str_query+" CAST(fecha AS char) like '%"+f+"%'"			
		}
	}	
	dbconnection.exe_query(
		str_query,
		function(result){
			str_query=str_query+" into OUTFILE  'D:/reportes/reporte4.csv' FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';"	
			dbconnection.exe_query(
				str_query,
				function(r){
					res.send(result)
				},
				res
				)			
		},
		res)
	// body...
})

router.post('/reportes/reporte5',function(req,res) {
	var dbconnection = require('../routes/dbconnection.js'); 	
	str_query="select * from Usuario "
	dbconnection.exe_query(
		str_query,
		function(result){
			str_query=str_query+" into OUTFILE  'D:/reportes/reporte5.csv' FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';"	
			dbconnection.exe_query(
				str_query,
				function(r){
					res.send(result)
				},
				res
				)			
		},
		res)
	// body...
})


router.post('/reportes/reporte3',function(req,res) {
	var dbconnection = require('../routes/dbconnection.js'); 
	console.log(req.body.nombre)
	console.log(req.body.tipo)
	console.log(req.body.esferas)
	console.log(req.body.servicio)
	var t = req.body.tipo
	var n = req.body.nombre
	var e = req.body.esferas
	var s = req.body.servicio

	str_query='select distinct E.id, E.idTipoEstablecimiento, E.calificacion, V.valor, T.nombre\
	from Establecimiento E, Valor V, tipoEstablecimiento T, Servicio S, EstablecimientoServicio ES\
	where V.idAtributo=1 AND V.idEstablecimiento=E.id and T.id=E.idTipoEstablecimiento\
	AND S.id=ES.idServicio AND ES.idEstablecimiento=E.id';
	if(t!='-1'){
		str_query=str_query+' and T.id='+t;
	}
	if(n!='-1'){
		str_query=str_query+' and V.valor like "%'+n+'%"';
	}
	if(s!='-1'){
		str_query=str_query+' and S.id='+s;
	}
	if(e!='-1'){
		str_query=str_query+' and calificacion='+e;
	}	
	dbconnection.exe_query(
		str_query,
		function(result){
			str_query=str_query+" into OUTFILE  'D:/reportes/reporte3.csv' FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';"	
			dbconnection.exe_query(
				str_query,
				function(r){
					res.send(result)
				},
				res
				)			
		},
		res)
	// body...
})


router.post('/reportes/reporte2',function(req,res) {
	var dbconnection = require('../routes/dbconnection.js'); 	
	var t = req.body.tipo		
	var s = req.body.servicio

	str_query='select distinct E.id, E.idTipoEstablecimiento, E.calificacion, V.valor, T.nombre\
	from Establecimiento E, Valor V, tipoEstablecimiento T, Servicio S, EstablecimientoServicio ES\
	where V.idAtributo=1 AND V.idEstablecimiento=E.id and T.id=E.idTipoEstablecimiento\
	AND S.id=ES.idServicio AND ES.idEstablecimiento=E.id';
	if(t!='-1'){
		str_query=str_query+' and T.id='+t;
	}	
	if(s!='-1'){
		str_query=str_query+' and S.id='+s;
	}
	str_query=str_query+' order by calificacion';	
	dbconnection.exe_query(
		str_query,
		function(result){
			str_query=str_query+" into OUTFILE  'D:/reportes/reporte2.csv' FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';"	
			dbconnection.exe_query(
				str_query,
				function(r){
					res.send(result)
				},
				res
				)			
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
