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

	function selectServicio(servicios) {
		function cargarEstablecimiento(est) {
			function cargar(establecimientos) {
				console.log("est: " + JSON.stringify(servicios));
				res.render('usuario_final/establecimiento', {
					establecimientos: establecimientos,
					atributos: est[0],
					servicios: servicios[0]
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
	var str_query = "CALL selectServicio(" + req.query.id + "," + req.user_session.id + ");";
	dbconnection.exe_query(
		str_query,
		selectServicio,
		res);

});



module.exports = router;