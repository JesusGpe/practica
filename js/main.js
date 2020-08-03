var monto;
var plazo;
var idCliente;

$(document).ready(function(){

	listarPrestamos("");
	llenarComboClientes("");
	llenarComboMontos();

	$("#btnBuscar").click(function(){
		listarPrestamos($("#txtBuscar").val());
	});

	$("#btnAgregar").click(function(){
		$("#registroPestamo").hide();
		$("#agregarPrestamo").removeClass('d-none');
	});
	$("#regresar").click(function(){
		$("#registroPestamo").removeClass('d-none');
		$("#tablaAmortizacion").addClass('d-none');
	});
	$("#btnCancelar").click(function(){
		if(confirm("¿Desea cancelar?")){
			$("#registroPestamo").show();
			$("#agregarPrestamo").addClass('d-none');
		}
		
	});

	$('#comboMonto').on('change', function () {
	 	let arr = this.value.split('-');
	 	console.log(arr[0]);
	 	monto = arr[1];
	 	plazo = arr[0];
	 	$("#txtPlazo").val(arr[0]);

	 
	});

	$('#comboClientes').on('change', function () {
	 	console.log(this.value);

	 	idCliente = this.value;
	});


	$("#formPrestramo").submit(function(event){
		event.preventDefault();
		if(idCliente == null){
			alert("Seleccione un cliente");
			return;
		}
		if(monto == null){
			alert("Seleccione un monto");
			return;
		}
		
		var data = {
			monto: monto,
			idCliente : idCliente,
			plazo:plazo,
			opc:'2'
		}
		console.log(data);
		$.ajax({
			url: 'php/Prestamos.php',
			method: 'POST',
			data: data,
			success: function(data) {
					
				alert("Prestamo guardado correctamente");
				listarPrestamos("");
			},
			error: function() {
		        console.log("No se ha podido obtener la información");
		    }
		});
	});
});


function listarPrestamos(search){
	$.ajax({
			url: 'php/Prestamos.php',
			method: 'POST',
			data: {opc : '1',search:search},
			success: function(data) {
				$("#dataTable").html("");
				if(data.length > 0){

					let tableHtml = "";
					data.forEach(function(item,index){
						tableHtml += "<tr>";
						tableHtml += "<td>"+item.nombre+"</td>";
						tableHtml += "<td>"+item.monto+"</td>";	
						tableHtml += "<td>"+item.plazos+"</td>";
						tableHtml += "<td><button class='btn btn-secondary btn-sm' onclick=listarAmortizacion("+item.id+")>&#9776;</button></td>";
						tableHtml += "</tr>";
	
					});
					$("#dataTable").append(tableHtml);
				}
			},
			error: function() {
		        console.log("No se ha podido obtener la información");
		    }
		});
}
function listarAmortizacion(idPrestamo){
	$("#tablaAmortizacion").removeClass('d-none');
	$("#registroPestamo").addClass('d-none');
	$.ajax({
			url: 'php/Prestamos.php',
			method: 'POST',
			data: {opc : '3',idPrestamo : idPrestamo},
			success: function(data) {
				console.log(data);
				$("#amortizacion").html("");
				if(data.length > 0){
					let noPago = 0;
					let total = 0.0;
					let totalInteres = 0.0;
					let totalAbono = 0.0;
					let cliente;
					let tableHtml = "";
					data.forEach(function(item,index){
						noPago++;
						cliente = item.nombre;
						total = total +  parseFloat(item.prestamo);
						totalInteres += parseFloat(item.interes);
						totalAbono += parseFloat(item.abono);
						tableHtml += "<tr>";
						tableHtml += "<td>"+noPago+"</td>";
						tableHtml += "<td>"+item.fecha_pago+"</td>";	
						tableHtml += "<td>"+item.prestamo+"</td>";
						tableHtml += "<td>"+item.interes+"</td>";
						tableHtml += "<td>"+item.abono+"</td>";
						tableHtml += "</tr>";
	
					});
					let footerHtml = "<tr>";
					footerHtml +="<th></th>"
					footerHtml += "<th scope='row'>Totales</th>";
					footerHtml += "<td>"+Math.floor(total)+"</td>";
					footerHtml += "<td>"+totalInteres+"</td>";
					footerHtml += "<td>"+Math.floor(totalAbono)+"</td>";
				 	footerHtml += "</tr>";
				 	$("#footer").html("");
				 	$("#footer").append(footerHtml);
					$("#amortizacion").append(tableHtml);
					$("#cliente").html("</h5>Cliente: "+cliente+"</h5>");
					$("#noPago").html("</h5>No Pago: "+noPago+"</h5>");
				}
			},
			error: function() {
		        console.log("No se ha podido obtener la información");
		    }
		});
}



function llenarComboClientes(search){
	$.ajax({
			url: 'php/Clientes.php',
			method: 'POST',
			data: {opc : '1',search:search},
			success: function(data) {
					data.forEach(function(item,index){
						$("#comboClientes").append('<option value="'+item.id+'">'+item.nombre+'</option>');
								
					});
				console.log(data);
			},
			error: function() {
		        console.log("No se ha podido obtener la información");
		    }
		});
}

function llenarComboMontos(){
	$.ajax({
			url: 'php/Plazos.php',
			method: 'POST',
			data: {opc : '1'},
			success: function(data) {
					data.forEach(function(item,index){
						$("#comboMonto").append('<option value="'+item.plazo +"-"+ item.monto +'">'+item.monto+'</option>');
					});
				console.log(data);
			},
			error: function() {
		        console.log("No se ha podido obtener la información");
		    }
		});
}
