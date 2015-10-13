var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		 res.redirect('/login?error=debe iniciar sesion primero');
	}

  res.render('usuario_final/principal', { mivar: 'nombre',otra: '<button>caca </button>' });
});


module.exports = router;
