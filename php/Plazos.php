<?php
	header('Content-Type: application/json');

	require_once('DB.php');

	class Plazos extends DB
	{	
		private $pdo;
		
		function __construct()
		{
			$this->pdo = $this->connect();;
		}

		public function listarPlazos(){

			$st = $this->pdo->prepare("SELECT * FROM plazos");
			$st->setFetchMode(PDO::FETCH_ASSOC);
			$st->execute();
       		$data = [];
	        while ($row = $st->fetch()){
			    $data[] = $row;
			}
	        return $data;

		}  

	}

	switch ($_POST['opc']) {
		case '1':
			$plazos = new Plazos();
			$data = $plazos->listarPlazos();
			echo json_encode($data);
			break;
		
		default:
			# code...
			break;
	}

?><?php

	
?>