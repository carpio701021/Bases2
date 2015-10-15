var express = require('express');
var router = express.Router();
var select_html="";

var generar_html_general=function(tuplas){
	var s='<div class="container">\
  <form name="FormCrearEstablecimiento" action="/usuario_admin/actualizar_general" method="POST" accept-charset="utf-8">\
    <div class="row">\
      <div class="col-sm-6">\
        <h2 align="center">\
          <Strong>Información General</Strong>\
        </h2>\
        <div class="row">\
          <div align="right" class="col-sm-3">\
            <label for="nombre" style="padding:5px">Nombre:</label>\
          </div>\
          <div class="col-sm-9">\
            <input type="text" name="nombre" class="form-control" value="'+tuplas[0].valor+'"/>\
          </div>\
        </div>\
        <div class="row">\
          <div align="right" class="col-sm-3">\
            <label for="tipo_establecimiento" style="padding:5px">Tipo:</label>\
          </div>\
          <div class="col-sm-7">\
            <div style="padding:5px">\
              '+select_html+'\
            </div>\
          </div>\
          <div class="col-sm-2">\
            <div style="padding:5px" align="left">\
              <button type="button" onClick="agregar_tipo();" class="btn btn-sm btn-success">agregar</button>\
            </div>\
          </div>\
        </div>\
        <div class="row">\
          <div align="right" class="col-sm-3">\
            <label for="descripsion" style="padding:5px">Descripción:</label>\
          </div>\
          <div class="col-sm-9">\
            <div style="padding:2px">\
              <textarea name="descripsion" class="form-control">'+tuplas[4].valor+' </textarea>\
            </div>\
          </div>\
        </div>\
        <div class="row">\
          <div align="right" class="col-sm-3">\
            <label for="longitud" style="padding:5px">Longitud:</label>\
          </div>\
          <div class="col-sm-2">\
            <input type="number" name="longitud" style="width:115px" class="form-control" value="'+tuplas[1].valor+'"/>\
          </div>\
          <div align="right" class="col-sm-2">\
            <label for="latitud" style="padding:5px 5px 5px 35px">Latitud:</label>\
          </div>\
          <div class="col-sm-2">\
            <input type="number" name="latitud" style="width:115px" class="form-control" value="'+tuplas[2].valor+'"/>\
          </div>\
        </div>\
        <div class="row">\
          <div class="col-sm-9"></div>\
          <div class="col-sm-3">\
            <div align="right" style="padding:5px">\
              <input type="submit" value="Guardar" style="width:100%" class="btn btn-primary"/>\
            </div>\
          </div>\
        </div>\
      </div>\
    </div>\
  </form>\
</div>';	
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
		
		var str_query ="SELECT * FROM outguat.tipoestablecimiento;";
		var dbconnection = require('../routes/dbconnection.js'); 
		dbconnection.exe_query(str_query,
			tipos_establecimiento,
			res);
		function tipos_establecimiento(tipos){
		genera_html_tipos(tipos);	
		if(resultados[0].length==0){
			console.log("no tiene establecimiento")
			var val = 0;		
		}else{
			console.log("SI TIENE")			
			var val = 1;				
		}
		console.log(tipos);		
		console.log(select_html);
		res.render('usuario_admin/principal', { username: req.user_session.usuario,
			tiene_establecimiento: val,
			tipos_establecimientos: select_html
			});		
	}

	}


  //res.render('usuario_admin/principal', { username: req.user_session.usuario,otra: '<button>caca </button>' });
});

var genera_html_tipos=function(tipos){
	select_html='<div><div class="form-group"><select name="tipo_establecimiento" id="tipo_establecimiento" class="form-control">';
		for(var index in tipos){
			select_html=select_html+'<option value="'+tipos[index].id+'">'+tipos[index].nombre+'</option>';
		}  
	select_html=select_html+'</select></div></div>';	
}

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

router.post('/actualizar_general',function(req,res,next){
	
	var tipo = req.body.tipo_establecimiento;
	var nombre= "'"+req.body.nombre+"'";
	var longitud= "'"+req.body.longitud+"'";
	var latitud= "'"+req.body.latitud+"'";	
	var oficial= req.user_session.id;
	var descripsion = "'"+req.body.descripsion+"'";
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "select insertEstablecimiento("+tipo+","+nombre+","+longitud+","+latitud+","+oficial+","+descripsion+");";
	dbconnection.exe_query(
			str_query, 
			actualizar,
			res);    	

	function actualizar(resultados){		
		res.redirect('/usuario_admin');		
	}

});

router.post('/actualizar_servicios',function(req,res,next){
	
	var tipo = req.body.tipo_establecimiento;
	var nombre= "'"+req.body.nombre+"'";
	var longitud= "'"+req.body.longitud+"'";
	var latitud= "'"+req.body.latitud+"'";	
	var oficial= req.user_session.id;
	var descripsion = "'"+req.body.descripsion+"'";
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "select insertEstablecimiento("+tipo+","+nombre+","+longitud+","+latitud+","+oficial+","+descripsion+");";
	dbconnection.exe_query(
			str_query, 
			actualizar,
			res);    	

	function actualizar(resultados){		
		res.redirect('/usuario_admin');		
	}

});

router.post('/cargar_servicios',function(req,res,next){
	
	var user= req.user_session.id;	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "call selectServicioOwner("+user+");";
	dbconnection.exe_query(
			str_query, 
			generar_html_servicios,
			res);    	


	function generar_html_servicios(mis_servicios){	
		var html_mis_servicios='<select id="select_mis_servicios" name="select_mis_servicios" \
		size="4" style="width:100%" class="input-group-lg" onChange="seleccionar_servicio()">';
		for(var i = 0;i < mis_servicios[0].length; i++){
			html_mis_servicios=html_mis_servicios+'<option class="list-group-item" value=\'{"id":"'
			+mis_servicios[0][i].id+'","calificacion":"5","nombre":"'+mis_servicios[0][i].nombre+'"}\'>'+mis_servicios[0][i].nombre+'</option>'			
		}		
		html_mis_servicios=html_mis_servicios+'</select>';
		
		var s='<div class="container">\
  <form name="FormCrearEstablecimiento" action="/usuario_admin/actualizar_servicios" method="POST" accept-charset="utf-8">\
    <div class="row">\
      <div class="col-sm-7">\
        <h2 align="center">\
          <Strong>Administrar Servicios</Strong>\
        </h2>\
        <div class="row">\
          <div align="center" class="col-sm-4">\
            <div class="panel panel-info">\
              <div style="background-color:#A9D0F5;" class="panel-heading">\
                <h3 class="panel-title">Servicios mi tipo</h3>\
              </div>\
              <div class="panel-body">\
                <div class="list-group">\
                  <select size="4" style="width:100%" class="input-group-lg">\
                    <option class="list-group-item">item</option>\
                    <option class="list-group-item">o1</option>\
                    <option class="list-group-item">o2</option>\
                    <option class="list-group-item">o3</option>\
                    <option class="list-group-item">o4																												</option>\
                    <option class="list-group-item">o5</option>\
                    <option class="list-group-item">o6</option>\
                    <option class="list-group-item">o7</option>\
                  </select>\
                </div>\
              </div>\
            </div>\
          </div>\
          <div align="center" class="col-sm-3">\
            <div style="padding: 10px 0px 0px 0px">\
              <div class="row">\
                <div class="col-sm-4">\
                  <button name="btn_crear_servicio" style="width:35px" onClick="agregar_servicio();" class="btn btn-sm btn-success">+	</button>\
                </div>\
                <div class="col-sm-4">\
                  <button name="btn_sumar_servicio" style="width:35px;background-color:#E0F8F7;" class="btn btn-sm btn-default">>>												</button>\
                </div>\
                <div class="col-sm-4">\
                  <button name="btn_restar_servicio" style="width:35px;" class="btn btn-sm btn-danger">-	</button>\
                </div>\
              </div>\
            </div>\
          </div>\
          <div align="center" class="col-sm-4">\
            <div class="panel panel-info">\
              <div style="background-color:#E0F8F7;" class="panel-heading">\
                <h3 class="panel-title">Mis Servicios</h3>\
              </div>\
              <div class="panel-body">\
                <div class="list-group">\
                  '+html_mis_servicios+'\
                </div>\
              </div>\
            </div>\
          </div>\
        </div>\
        <div class="row">\
          <div class="col-sm-7"></div>\
          <div class="col-sm-3">\
            <div align="right" style="padding:5px">\
              <input type="submit" value="Guardar" style="width:100%" class="btn btn-primary"/>\
            </div>\
          </div>\
        </div>\
      </div>\
    </div>\
  </form>\
</div>';
		
		res.send(s);		
	}

});


router.post('/cargar_general',function(req,res,next){
	
	var user= req.user_session.id;	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "call selectAtributosOwner("+req.user_session.id+");";
	dbconnection.exe_query(
			str_query, 
			generar_general,
			res);    	


	function generar_general(resultados){					
		admin_general_html=generar_html_general(resultados[0]);
		res.send(admin_general_html);		
	}

});



module.exports = router;

