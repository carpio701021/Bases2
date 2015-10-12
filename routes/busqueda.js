var express = require('express');
var router = express.Router();
var dbconnection = require('../routes/dbconnection.js'); 


exports.busquedaEstablecimientos = function( res, callback ){

	var str_query = "select AgruparBusqueda();";
	dbconnection.exe_query(
			str_query, 
			callback,
			res);    	
	
}