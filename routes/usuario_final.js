var express = require('express');
var router = express.Router();
var busqueda = require('../routes/busqueda.js');

/* GET home page. */
router.get('/', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) { //componer
		res.redirect('/login?error=debe iniciar sesion primero');
	}

	function cargar(establecimientos) {
		res.render('usuario_final/principal', {
			establecimientos: establecimientos
		});
	}

	busqueda.busquedaEstablecimientos(res, cargar);
	//res.render('usuario_final/principal', { mivar: 'nombre',otra: '<button>caca </button>' });
});

/* GET home page. */
router.get('/establecimiento/plantilla_reservacion', function(req, res, next) {
	res.render('usuario_final/plantilla_reservacion',{
		idEstablecimiento: req.query.idEstablecimiento,
		idValor: req.query.idValor,
		nombre: req.query.nombre,
		valor: req.query.valor,
		cantidad: req.query.cantidad
	});
});


/* GET home page. */
var select_html = "";
var genera_html_tipos = function(tipos) {
	select_html = '<div><div class="form-group"><select name="tipo_establecimiento" id="tipo_establecimiento" class="form-control">';
	for (var index in tipos) {
		select_html = select_html + '<option value="' + tipos[index].id + '">' + tipos[index].nombre + '</option>';
	}
	select_html = select_html + '</select></div></div>';
}

router.get('/establecimiento_nuevo', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) { //componer
		res.redirect('/login?error=debe iniciar sesion primero');
	}


	var dbconnection = require('../routes/dbconnection.js');
	var str_query = "call selectAtributosOwner(" + req.user_session.id + ");";
	dbconnection.exe_query(
		str_query,
		tiene_establecimiento,
		res);

	function tiene_establecimiento(resultados) {
		//var obj= JSON.parse(resultados[0])
		var admin_general_html = '';
		var admin_caracteristicas_html = "";
		console.log(resultados[0])

		var str_query = "SELECT * FROM outguat.tipoestablecimiento;";
		var dbconnection = require('../routes/dbconnection.js');
		dbconnection.exe_query(str_query,
			tipos_establecimiento,
			res);

		function tipos_establecimiento(tipos) {
			genera_html_tipos(tipos);
			if (resultados[0].length == 0) {
				console.log("no tiene establecimiento")
				var val = 0;
			} else {
				console.log("SI TIENE")
				req.user_session.id_establecimiento = resultados[0][0].idEstablecimiento;
				console.log(resultados[0][0].idEstablecimiento)
					//req.user_session.id_establecimiento = 8;
				var val = 1;
			}
			console.log(tipos);
			console.log(select_html);
			res.render('usuario_final/establecimiento_nuevo', {
				username: req.user_session.usuario,
				tiene_establecimiento: val,
				tipos_establecimientos: select_html
			});
		}

	}

});


router.post('/establecimiento_nuevo/guardar', function(req, res, next) {

	var tipo = req.body.tipo_establecimiento;
	var nombre = "'" + req.body.nombre + "'";
	var longitud = "'" + req.body.longitud + "'";
	var latitud = "'" + req.body.latitud + "'";
	var id = req.user_session.id;
	var descripsion = "'" + req.body.descripsion + "'";
	var dbconnection = require('../routes/dbconnection.js');
	var str_query = "select insertEstablecimiento(" + tipo + "," + nombre + "," + longitud + "," + latitud + ',0' + "," + descripsion + ");";
	dbconnection.exe_query(
		str_query,
		actualizar,
		res);

	function actualizar(resultados) {
		res.redirect('/#'+JSON.stringify(resultados));
	}

});

/* GET home page. */
router.get('/establecimiento', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) { //componer
		res.redirect('/login?error=debe iniciar sesion primero');
	}

	if(!req.query.id) res.redirect('/');

	function selectServicio(comentarios) {
		function selectServicio(punteo_general) {
			function selectServicio(servicios) {
				function cargarEstablecimiento(est) {
					function cargar(establecimientos) {
						console.log("est: " + JSON.stringify('Servicios: ' + JSON.stringify(servicios)));
						res.render('usuario_final/establecimiento', {
							establecimientos: establecimientos,
							atributos: est[0],
							servicios: servicios[0],
							punteo_general: JSON.stringify(punteo_general[0]).split(':')[1].split('}')[0],
							comentarios: comentarios[0],
							establecimiento: req.query.id
						});
					}
					busqueda.busquedaEstablecimientos(res, cargar);
				}
				//llamada al objeto base de datos
				var dbconnection = require('../routes/dbconnection.js');
				//Metodo que realiza la consulta a la base de datos y devuelve:
				var str_query = "CALL selectAtributo(" + req.query.id + ");";
				dbconnection.exe_query(
					str_query,
					cargarEstablecimiento,
					res);
			}

			//llamada al objeto base de datos
			var dbconnection = require('../routes/dbconnection.js');
			//Metodo que realiza la consulta a la base de datos y devuelve:
			var str_query = "call selectServicio(" + req.query.id + "," + req.user_session.id + ");";
			dbconnection.exe_query(
				str_query,
				selectServicio,
				res);
		}
		//llamada al objeto base de datos
		var dbconnection = require('../routes/dbconnection.js');
		//Metodo que realiza la consulta a la base de datos y devuelve:
		var str_query = "select Calificar(" + req.query.id +  ");";
		dbconnection.exe_query(
			str_query,
			selectServicio,
			res);
	}
	//llamada al objeto base de datos
	var dbconnection = require('../routes/dbconnection.js');
	//Metodo que realiza la consulta a la base de datos y devuelve:
	var str_query = "call selectComentario(" + req.query.id +  ");";
	dbconnection.exe_query(
		str_query,
		selectServicio,
		res);


});


router.post('/establecimiento/comentar', function(req, res, next) {
	var idEstablecimiento = req.body.establecimiento;
	var idUsuario = req.user_session.id;
	var comentario = req.body.comentario;

	function insertarCalificacion(resultado) {
		console.log('Comentario posteado: ' + resultado);
		res.redirect('/establecimiento?id='+idEstablecimiento+'&resultado_comment=exito');
	}

	//llamada al objeto base de datos
	var dbconnection = require('../routes/dbconnection.js');
	//Metodo que realiza la consulta a la base de datos y devuelve:
	var str_query = "select outguat.insertComentario(" + 
		idEstablecimiento + ',' +
		idUsuario +  ',\'' +
		comentario + "');";
	dbconnection.exe_query(
		str_query,
		insertarCalificacion,
		res);
});


router.post('/establecimiento/reservar', function(req, res, next) {
	var idEstablecimiento = req.body.idEstablecimiento;
	var idUsuario = req.user_session.id;
	var idValor = req.body.idValor;
	var cantidad = req.body.cantidad;
	var fechaInicio = req.body.fhi;
	var fechaFin = req.body.fhf;

	function insertarCalificacion(resultado) {
		console.log('Resultado reservacion: ' + resultado);
		res.redirect('/establecimiento?id='+idEstablecimiento+'&resultado_reserva=exito');
	}

	//llamada al objeto base de datos
	var dbconnection = require('../routes/dbconnection.js');
	//Metodo que realiza la consulta a la base de datos y devuelve:
	var str_query = "select insertReserva(" + 
		idUsuario + "," +
		idValor +  ",'" +
		fechaInicio +  "','" +
		fechaFin +  "'," +
		cantidad + ");";
	dbconnection.exe_query(
		str_query,
		insertarCalificacion,
		res);
});



/* GET home page. */
router.get('/establecimiento/calificar_servicio', function(req, res, next) {
	//insertCalificacion(idEstablecimiento, idServicio, idUsuario, punteo);
	var idEstablecimiento = req.query.idEstablecimiento;
	var idServicio = req.query.idServicio;
	var idUsuario = req.user_session.id;
	var punteo = req.query.punteo;

	function insertarCalificacion(resultado) {
		console.log('Servicio calificado: ' + resultado);
		res.json(resultado);
	}

	//llamada al objeto base de datos
	var dbconnection = require('../routes/dbconnection.js');
	//Metodo que realiza la consulta a la base de datos y devuelve:
	var str_query = "select insertCalificacion(" + 
		idEstablecimiento + ',' +
		idServicio +  ',' +
		idUsuario +  ',' +
		punteo + ");";
	dbconnection.exe_query(
		str_query,
		insertarCalificacion,
		res);

});

module.exports = router;