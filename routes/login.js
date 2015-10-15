var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
	if (req.user_session && req.user_session.id){
		req.user_session.reset();
		res.redirect('/login');
	}else{
		res.render('login', { 
			title: 'Iniciar Sesión'
		});
	}
});


//metodo que verifica el usuario y la contraseña
router.post('/', function(req, res) {


    
	var validar_login = function (respuestabd){
		//validamos si el login es exitoso

		console.log(respuestabd);
		if(respuestabd[0].length>0){
			//si es exitoso se guarda la cookie con los datos del usuario
			req.user_session.usuario = req.body.c_user;
			req.user_session.id =respuestabd[0][0].id;
			req.user_session.idTipoUsuario = respuestabd[0][0].idTipoUsuario;
			req.user_session.active = false;
			var tipo_usuario = req.user_session.idTipoUsuario;
			if(tipo_usuario==1){ //usuario admin
				res.redirect('/admin')
			}else{
				if(tipo_usuario==2){ //usuario owner
					res.redirect('/usuario_admin');
				}
				else{ //usuario final
					res.redirect('/');	
				}
			}
			//redireccion a la pagina de inicio del usuario (segun su tipo de usuario)		
			//res.render('index',{ title : 'Sesion iniciada',resultado : JSON.stringify(params.rrows)});
		}else{
			//Si no inicia sesion muestra el error
			res.render('login', { 
				title: 'Iniciar Sesión',
				error: 'Usuario o contraseña invalidos'
			});
			//res.render('index',{ title : 'Sesion No iniciada',resultado : JSON.stringify(params.rrows)});
		}
    };



	var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;

	console.log('Logueo con ip: '+ip);

	if(!(req.body.c_user && req.body.password)){
		return res.render('login', { 
			title: 'Iniciar Sesión',
			error: 'Debe llenar todas las casillas'
		});
	}

	//llamada al objeto base de datos
    var dbconnection = require('../routes/dbconnection.js');
    
	//Metodo que realiza la consulta a la base de datos y devuelve:
    // aqui la consulta con los datos (req.body.c_user ,req.body.password) son los parametros
    var str_query = "CALL logUsuario('"+req.body.c_user+"', '"+req.body.password+"');";
	dbconnection.exe_query(
			str_query, 
			validar_login,
			res);    	

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

router.post('/registrar',function(req,res) {
	var tipo_usuario=3;
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
			res.render('login', { 
				title: 'Iniciar Sesión',
				exito2: 'Usuario registrado con exito'
			});
		}else{
			res.render('login', { 
				title: 'Iniciar Sesión',
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