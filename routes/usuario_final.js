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
		var str_query = "select calificar(" + req.query.id +  ");";
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