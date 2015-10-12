var express = require('express');
var router = express.Router();

var generar_html_general=function(tuplas){
	var s='<div class="container"> \
  <h2 align="center">\
    <Strong>Información General\
      <form name="FormCrearEstablecimiento" action="/usuario_admin/crear" method="POST" accept-charset="utf-8">\
        <table>\
          <tr>\
            <td align="right" style="width:20%">\
              <label for="nombre" style="padding:5px">Nombre:</label>\
            </td>\
            <td>\
              <input type="text" name="nombre" class="form-control"/>\
            </td>\
          </tr>\
          <tr>\
            <td align="right">\
              <label for="tipo_establecimiento" style="padding:10px">Tipo:</label>\
            </td>\
            <td></td>\
            <td align="right">\
              <button type="button" style="width:100%;padding:1px" onClick="agregar_tipo();" class="btn btn-primary">agregar</button>\
            </td>\
          </tr>\
          <tr>\
            <td align="right" style="width:20%">\
              <label for="descripsion" style="padding:10px">Descripsión:</label>\
            </td>\
            <td>\
              <textarea name="descripsion" class="form-control">								</textarea>\
            </td>\
          </tr>\
        </table>\
        <table>\
          <tr>\
            <td style="width:18%" align="right">\
              <label for="longitud" style="padding:10px">Longitud:</label>\
            </td>\
            <td style="width:15%">\
              <input type="number" name="longitud" class="form-control"/>\
            </td>\
            <td align="left" style="width:10%">\
              <label for="latitud" style="padding:10px">Latitud:</label>\
            </td>\
            <td align="left" style="width:15%">\
              <input type="number" name="latitud" class="form-control"/>\
            </td>\
            <td align="center">\
              <input type="submit" value="Crear" style="width:45%" class="btn btn-lg btn-primary"/>\
            </td>\
          </tr>\
        </table>\
      </form>\
    </Strong>\
  </h2>\
</div>';
	for(var i = 0;i <3; i++){				
		s=s+'<p>'+tuplas[i].nombre+' '+tuplas[i].valor+' </p>';
	}
	s=s+'<p>'+tuplas[4].nombre+' '+tuplas[4].valor+' </p>';	
	return s;
}

var generar_html_caracteristicas=function(tuplas){
	var s="";
	for(var i = 5;i < tuplas.length; i++){
		s=s+"<p> a"+tuplas[i].nombre+""+tuplas[i].valor+""+tuplas[i].cantidad+" </p>"
	}
	return s;
}

router.get('/', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		 res.redirect('/login?error=debe iniciar sesion primero');
	}


	var dbconnection = require('../routes/dbconnection.js'); 
	var str_query = "call selectAtributosOwner("+req.user_session.id+");";
	dbconnection.exe_query(
			str_query, 
			tiene_establecimiento,
			res);    	

	function tiene_establecimiento(resultados){
		//var obj= JSON.parse(resultados[0])
		var admin_general_html='';
		var admin_caracteristicas_html="";
		console.log(resultados[0])		
		if(resultados[0].length==0){
			console.log("no tiene establecimiento")
			var val = 0;		
		}else{
			console.log("SI TIENE")
			admin_general_html=generar_html_general(resultados[0]);
			admin_caracteristicas_html=generar_html_caracteristicas(resultados[0]);
			var val = 1;				
		}
		
		var str_query ="SELECT * FROM outguat.tipoestablecimiento;";
		var dbconnection = require('../routes/dbconnection.js'); 
		dbconnection.exe_query(str_query,
			tipos_establecimiento,
			res);
		function tipos_establecimiento(tipos){
		console.log(tipos);
		var select_html='<div><div style="padding:10px" class="form-group"><select name="tipo_establecimiento" id="tipo_establecimiento" class="form-control">';
		for(var index in tipos){
			select_html=select_html+'<option value="'+tipos[index].id+'">'+tipos[index].nombre+'</option>';
		}     
    
		var select_html=select_html+'</select></div></div>';
		console.log(select_html);
		res.render('usuario_admin/principal', { username: req.user_session.usuario,
			tiene_establecimiento: val,
			tipos_establecimientos: select_html,
			html_administrar_general: admin_general_html,
			html_administrar_caracteristicas: admin_caracteristicas_html,
			});		
	}

	}


  //res.render('usuario_admin/principal', { username: req.user_session.usuario,otra: '<button>caca </button>' });
});

router.post('/crear',function(req,res,next){
	

	var dbconnection = require('../routes/dbconnection.js'); 	
	var tipo = req.body.tipo_establecimiento;
	var nombre= "'"+req.body.nombre+"'";
	var longitud= "'"+req.body.longitud+"'";
	var latitud= "'"+req.body.latitud+"'";	
	var oficial= req.user_session.id;
	var descripsion = "'"+req.body.descripsion+"'";

	var str_query = "select insertEstablecimiento("+tipo+","+nombre+","+longitud+","+latitud+","+oficial+","+descripsion+");";
	dbconnection.exe_query(
			str_query, 
			crear,
			res);    	

	function crear(resultados){		
		res.redirect('/usuario_admin');		
	}

});

router.post('/crear_tipo',function(req,res,next){
	
	var nombre=req.body.nombre;
	var dbconnection = require('../routes/dbconnection.js'); 	
	console.log(nombre);

	var str_query = "select insertTipoEstablecimiento('"+nombre+"');";
	dbconnection.exe_query(
			str_query, 
			crear,
			res);    	

	function crear(resultados){				
		var a =valor_insert(resultados)+"";
		console.log(a)
		res.send(a);	
	}
	

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
module.exports = router;
