<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Include the existing connection script
require_once 'conexao.php';
$con->set_charset("utf8");

// SQL sem filtro: retorna todos os registros da tabela segAutenticacao
$sql = "SELECT idAutenticacao, deTokenEndpoint, deClientSecret, deToken, idUsuario, idGrantType
        FROM segAutenticacao";

$stmt = $con->prepare($sql);
$stmt->execute();
$result = $stmt->get_result();

$response = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $response[] = array_map(fn($val) => mb_convert_encoding($val, 'UTF-8', 'ISO-8859-1'), $row);
    }
} else {
    $response[] = [
        "idAutenticacao" => 0,
        "deTokenEndpoint" => "",
        "deClientSecret" => "",
        "deToken" => "",
        "idUsuario" => 0,
        "idGrantType" => 0
    ];
}

header('Content-Type: application/json; charset=utf-8');
echo json_encode($response);

$stmt->close();
$con->close();

?>
