<?php
class DB{

    private $db;
    function __construct() 
    {
        $this->db = $this->connect();    
    }

    public function connect() 
    {
        $con = new PDO('mysql:host=localhost;dbname=rest_api;charset=utf8', 'root', '');
        $con->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
        $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
        return $con;
    }

    public function query($sql){
        
        $st =$this->db->prepare($sql);
        $st->setFetchMode(PDO::FETCH_ASSOC);
        $st->execute();
        $data = [];
        while ($row = $st->fetch()){
            $data[] = $row;
        }
        return $data;
    }
}