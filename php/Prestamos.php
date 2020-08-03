<?php
	header('Content-Type: application/json');

	require_once('DB.php');

	class Prestamos extends DB
	{	
		private $pdo;
		
		function __construct()
		{
			$this->pdo = $this->connect();
		}

		public function listarPrestamos($search){

			$st = $this->pdo->prepare("SELECT p.*,c.nombre FROM prestamos p INNER JOIN clientes c ON p.cliente_id = c.id WHERE c.nombre LIKE '%".$search."%'");
			$st->setFetchMode(PDO::FETCH_ASSOC);
			$st->execute();
       		$data = [];
	        while ($row = $st->fetch()){
			    $data[] = $row;
			}
	        return $data;

		}  

		public function listarAmortizacion($idPrestamo){

			
	        $st = $this->pdo->prepare("SELECT p.*,c.nombre FROM prestamos_detalle p INNER JOIN prestamos pt ON p.prestamo_id = pt.id INNER JOIN clientes c on pt.cliente_id = c.id  WHERE p.prestamo_id = ?");
	        $st->bindParam(1, $idPrestamo);
			$st->setFetchMode(PDO::FETCH_ASSOC);
			$st->execute();
       		$data = [];
	        while ($row = $st->fetch()){
			    $data[] = $row;
			}
	        return $data;

		}  

		public function registarPrestamo($idCliente,$monto,$plazo){

			try {

				$st = $this->pdo->prepare("INSERT INTO prestamos (cliente_id, monto,plazos) VALUES (?,?,?)");
				$st->bindParam(1, $idCliente);
				$st->bindParam(2, $monto);
				$st->bindParam(3, $plazo);
				$st->execute();
				
				$stmt = $this->pdo->query("SELECT LAST_INSERT_ID()");
				$lastId = $stmt->fetchColumn();
				
				$this->registrarPagoDetalle($lastId,$monto,$plazo);
				$date = date("m-d-Y");
				$mod_date = strtotime($date."+ 15 days");
					$newdate = date("m-d-Y",$mod_date);
				return array("ok" => true,"data"=> $newdate);
			} catch (Exception $e) {
				 return array("ok" => false);
			}
	       

		}  

		public function registrarPagoDetalle($id,$monto,$plazo){

			try {
				$date_now = date('Y-m-d');
				$prestamo = $monto / $plazo;
				$st2 = $this->pdo->query("SELECT tasa_fin from configuracion");
				$config = $st2->fetchColumn();
				$interes = ($prestamo * $config)/100;
				$abono = $prestamo + $interes;

				for ($i=0; $i < $plazo ; $i++) { 

					$date_future = strtotime('+15 day', strtotime($date_now));
					$date_future = date('Y-m-d', $date_future);
					$st = $this->pdo->prepare("INSERT INTO prestamos_detalle (prestamo_id, fecha_pago,prestamo,interes,abono) VALUES (?,?,?,?,?)");
					$st->bindParam(1, $id);
					$st->bindParam(2, $date_future);
					$st->bindParam(3, $prestamo);
					$st->bindParam(4, $interes);
					$st->bindParam(5, $abono);
					$st->execute();
					$date_now = $date_future;
				}
			} catch (Exception $e) {

			}
	       

		}  


	}

	switch ($_POST['opc']) {
		case '1':
			$prestamos = new Prestamos();
			$data = $prestamos->listarPrestamos($_POST['search']);
			echo json_encode($data);
			break;
		case '2':
			$prestamos = new Prestamos();
			$idCliente = $_POST['idCliente'];
			$monto = $_POST['monto'];
			$plazo = $_POST['plazo'];
			$data = $prestamos->registarPrestamo($idCliente,$monto,$plazo);
			echo json_encode($data);
			break;
		case '3':
			$prestamos = new Prestamos();
			$idPrestamo = $_POST['idPrestamo'];
			$data = $prestamos->listarAmortizacion($idPrestamo);
			echo json_encode($data);
			break;
		default:
			echo json_encode(["dasdsa"]);
			break;
	}


?>