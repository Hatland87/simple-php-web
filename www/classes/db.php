<?php

class DB 
{
    private $host = "db";  // When using docker-compose this needs to be the service name of the db in the docker-compose yml
    private $user = "root";
    private $pwd = "test";
    private $dbName = "recipes";

    protected function connect() 
    {
        $pdo = new PDO("mysql:host=$this->host;dbname=$this->dbName", $this->user, $this->pwd);
        $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        if (!$pdo)
        {
            die("Connection failed: "); //TODO gt pdo connection error
        } else
            return $pdo;
    }
}
?>