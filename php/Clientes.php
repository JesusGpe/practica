<?php
	header('Content-Type: application/json');

	require_once('DB.php');

	class Clientes extends DB
	{	
		private $pdo;
		
		function __construct()
		{
			$this->pdo = $this->connect();;
		}

		public function listarClientes($search){

			$st = $this->pdo->prepare("SELECT * FROM clientes");
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
			$clientes = new Clientes();
			$data = $clientes->listarClientes($_POST['search']);
			echo json_encode($data);
			break;
		
		default:
			# code...
			break;
	}

?>