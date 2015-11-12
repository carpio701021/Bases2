var multer = require('multer');
var storage = multer.diskStorage({
	destination: function(req, file, cb) {
		cb(null, '../uploads_from_server/')
	},
	filename: function(req, file, cb) {
		cb(null, "[" + file.fieldname + '-' + Date.now() + "]" + file.originalname)
	}
});
var upload = multer({
	storage: storage
});

var express = require('express');
var router = express.Router();


router.get('/', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		 res.redirect('/login?error=debe iniciar sesion primero');
	}

  res.render('admin/principal', { mivar: 'nombre',otra: '<button>caca </button>' });
});

router.get('/gestionDeDatos', function(req, res, next) {

	if (!(req.user_session && req.user_session.id)) {//componer
		 res.redirect('/login?error=debe iniciar sesion primero');
	}

  res.render('admin/gestionDeDatos', { mivar: 'nombre' });
});


router.post('/importarBD', upload.single('archToImport'), function(req, res, next) {
	// req.file is the `avatar` file
	// req.body will hold the text fields, if there were any
	console.log('req: ' + JSON.stringify(req.file));


	res.send(req.file.path);
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
	var tipo_usuario=2;
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
			res.render('/admin', { 				
				exito2: 'Usuario registrado con exito'
			});
		}else{
			res.render('/admin', { 				
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
