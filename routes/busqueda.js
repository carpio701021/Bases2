var express = require('express');
var router = express.Router();
var dbconnection = require('../routes/dbconnection.js');


exports.busquedaEstablecimientos = function(res, callback) {

	function resbusqueda(establecimientos) {
		callback(generar_options(establecimientos));
	}

	var str_query = "select AgruparBusqueda();";
	dbconnection.exe_query(
		str_query,
		resbusqueda,
		res
	);

}


var generar_options = function(establecimientos) {
	//console.log(establecimientos[0]['AgruparBusqueda()']);
	var ests = JSON.parse(establecimientos[0]['AgruparBusqueda()']);
	var h = '';
	var group = '';
	for (e in ests) {
		var b = false;
		if (ests[e].tipo != group) {
			b = true;
			h += "<optgroup label='" + ests[e].tipo + "'>";
		}
		h += "<option value='" + ests[e].id + "' title='" + (JSON.stringify(ests[e])).replace(new RegExp('"', 'g'), '&quot;') + "'  >";
		h += ests[e].establecimiento;
		//option(value='3', title='{"id":2,"tipo":"Hotel","establecimiento":"Hotel Conquistador and Conference Center Guatemalas","tags":["Comida","Conferencias","Hospedaje"]}') putos
		h += '</option>'
		if (b) h += '</optgroup>'
	}
	h += '</optgroup>'
	return h;
}