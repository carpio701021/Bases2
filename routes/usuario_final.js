var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		 res.redirect('/login?error=debe iniciar sesion primero');
	}

	function cargar( establecimientos ){
		console.log("est: " + generar_options(establecimientos));
		res.render('usuario_final/principal', { 
				establecimientos: generar_options(establecimientos)
			});
	}

	var busqueda = require('../routes/busqueda.js'); 
	busqueda.busquedaEstablecimientos(res,cargar);
  //res.render('usuario_final/principal', { mivar: 'nombre',otra: '<button>caca </button>' });
});

function generar_options(establecimientos){
	console.log(establecimientos[0]['AgruparBusqueda()']);
	var ests = JSON.parse(establecimientos[0]['AgruparBusqueda()']);
	var h = '';
	var group = '' ;
	for(e in ests){
		var b = false;
		if(ests[e].tipo!=group){ 
			b = true;
			h += "<optgroup label='" + ests[e].tipo + "'>";
		}
		h += "<option value='" + ests[e].id + "' title='" +  (JSON.stringify(ests[e])).replace(new RegExp('"', 'g'), '&quot;') + "'  >" ;
		h += ests[e].establecimiento;
		//option(value='3', title='{"id":2,"tipo":"Hotel","establecimiento":"Hotel Conquistador and Conference Center Guatemalas","tags":["Comida","Conferencias","Hospedaje"]}') putos
		h += '</option>'
		if(b) h += '</optgroup>'
	}
	h += '</optgroup>'
	return h;
}

function replacer(key, value) {
  if (typeof value === "string") {
    return undefined;
  }
  return value;
}	
	

module.exports = router;
