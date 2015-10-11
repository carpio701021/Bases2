var express = require('express');
var router = express.Router();


router.get('/', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		 res.redirect('/login?error=debe iniciar sesion primero');
	}


	var dbconnection = require('../routes/dbconnection.js'); 
	var str_query = "select count(a.id) as valor from Usuario u, valor v, Atributo a"
					+" where a.id=4 and v.valor=u.id and v.idAtributo = a.id and u.id="+req.user_session.id;
	dbconnection.exe_query(
			str_query, 
			tiene_establecimiento,
			res);    	

	function tiene_establecimiento(resultados){
		var val = resultados[0]["valor"];
		res.render('usuario_admin/principal', { username: req.user_session.usuario,tiene_establecimiento: val });		
	}

  //res.render('usuario_admin/principal', { username: req.user_session.usuario,otra: '<button>caca </button>' });
});

module.exports = router;
