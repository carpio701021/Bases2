var express = require('express');
var router = express.Router();
var select_html="";



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
			req.user_session.id_establecimiento = resultados[0][0].idEstablecimiento;
			console.log(resultados[0][0].idEstablecimiento)
			//req.user_session.id_establecimiento = 8;
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
	var id= req.user_session.id;
	var descripsion = "'"+req.body.descripsion+"'";
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "call updateEstablecimiento("+id+","+tipo+","+nombre+","+longitud+","+latitud+","+descripsion+");";
	dbconnection.exe_query(
			str_query, 
			actualizar,
			res);    	

	function actualizar(resultados){		
		res.redirect('/usuario_admin');
	}

});

router.post('/actualizar_servicios',function(req,res,next){
	
	console.log("principio")
	var user= req.user_session.id;	
	var id_establecimiento =req.user_session.id_establecimiento;
	console.log("estab: "+id_establecimiento)
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "call selectServicioOwner("+user+");";
	dbconnection.exe_query(
			str_query, 
			comparar_servicios,
			res);    	

	function comparar_servicios(anteriores){		
		var options_servicios = req.body.servicios.split("-");
		for(var i = 0; i<options_servicios.length-1; i++){								
			var val_nuevo= options_servicios[i].split(",");
			var actualizo=false
			for(var a in anteriores[0]){				
				if(val_nuevo[0]==anteriores[0][a].id){//si esta en los dos listados update
					console.log("update "+val_nuevo[0]+" "+val_nuevo[1])
					str_query="call updateEstablecimientoServicio("+val_nuevo[0]+","+id_establecimiento+","+val_nuevo[1]+");"
					dbconnection.exe_query(str_query,function(){},res)
					actualizo=true
					break
				}
			}
			if(!actualizo){//si no actualizó se inserta
				console.log("inserta "+val_nuevo[0]+" "+val_nuevo[1])
				str_query="select insertEstablecimientoServicio("+val_nuevo[0]+","+id_establecimiento+","+val_nuevo[1]+");"
				dbconnection.exe_query(str_query,function(){},res)
			}								
		}					
		for(var a in anteriores[0]){			
			var encontro=false
			for(var i = 0; i<options_servicios.length-1; i++){								
				var val= options_servicios[i].split(",");
				if(val[0]==anteriores[0][a].id){//si esta en los dos rompe el ciclo y marca que lo encontro
					encontro=true
					break
				}				
			}			
			if(!encontro){//si no lo encontró lo elimina
				console.log("delete "+anteriores[0][a].id)
				str_query="select deleteEstablecimientoServicio("+id_establecimiento+","+anteriores[0][a].id+");"
				dbconnection.exe_query(str_query,function(){},res)
			}			
		}
		res.send('nitido');
	}
	
	/*
	for(var i = 0; i<options_servicios.length-1; i++){

		var val= options_servicios[i].split(",");
		console.log("servicio: id:"+val[0]+" porcentaje:"+val[1]);
	}	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "select insertEstablecimiento(";
	dbconnection.exe_query(
			str_query, 
			actualizar,
			res);    	

	function actualizar(resultados){		
		res.redirect('/usuario_admin');		
	}*/

});

router.post('/cargar_servicios',function(req,res,next){
	
	var user= req.user_session.id;	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "call selectServicioOwner("+user+");";
	dbconnection.exe_query(
			str_query, 
			consultar_servicios_todos,
			res);    	


	function consultar_servicios_todos(mis_servicios){			
		var str_query = "call selectServicioTodos();";
		dbconnection.exe_query(
				str_query, 
				mandar,
				res); 

		function mandar(servicios_todos){
			var a ={servicios_todos,mis_servicios}
			res.send(a);		
		}		
	}

});



router.post('/cargar_caracteristicas',function(req,res,next){
	var user= req.user_session.id;	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "call selectAtributosOwner("+req.user_session.id+");";
	dbconnection.exe_query(
			str_query, 
			cargar_sin_repetir,
			res);    	
	function cargar_sin_repetir(atributos_valores){							
		str_query = "call selectAtributosOwnerSinRepetir("+req.user_session.id+");";
		dbconnection.exe_query(
			str_query, 
			function(atributos_tipos){
				var a= {atributos_tipos,atributos_valores}
				res.send(a);
			},
			res);    			
	}
});

router.post('/cargar_caracteristicas_todas',function(req,res,next){	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "select * from outguat.atributo;";
	dbconnection.exe_query(
			str_query, 
			function(data){
				res.send(data)
			},
			res);    		
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
		res.send(resultados);		
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

router.post('/crear_servicio',function(req,res,next){	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "select outguat.insertServicio('"+req.body.nombre+"');";
	dbconnection.exe_query(
			str_query, 
			verificar,
			res);    	
	function verificar(se_pudo){							
		res.send(se_pudo);		
	}
});

router.post('/crear_atributo',function(req,res,next){	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var str_query = "select outguat.insertAtributo('"+req.body.nombre+"',0);";
	dbconnection.exe_query(
			str_query, 
			verificar,
			res);    	
	function verificar(se_pudo){							
		res.send(se_pudo);		
	}
});

router.post('/insertar_valor',function(req,res,next){	
	var dbconnection = require('../routes/dbconnection.js'); 	
	var estab=req.user_session.id_establecimiento
	console.log(estab)
	var id_atributo=req.body.id_atributo
	var cantidad = 0
	var valor=req.body.valor
	var str_query = "select outguat.insertValor("+estab+","+id_atributo+","+cantidad+",'"+valor+"');";
	dbconnection.exe_query(
			str_query, 
			verificar,
			res);    	
	function verificar(se_pudo){							
		res.send(se_pudo);		
	}
});

module.exports = router;

