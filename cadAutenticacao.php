<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Set content type\ nheader('Content-Type: application/json');

// Include the shared DB connection
require_once 'conexao.php';
$con->set_charset("utf8");

// Get JSON input
$jsonParam = json_decode(file_get_contents('php://input'), true);

if (!$jsonParam) {
    echo json_encode(['success' => false, 'message' => 'Dados JSON inválidos ou ausentes.']);
    exit;
}

// Extract and validate data
$deTokenEndpoint = trim($jsonParam['deTokenEndpoint'] ?? '');
$deClientSecret  = trim($jsonParam['deClientSecret'] ?? '');
$deToken         = isset($jsonParam['deToken']) ? trim($jsonParam['deToken']) : null;
$idUsuario       = intval($jsonParam['idUsuario'] ?? 0);
$idGrantType     = intval($jsonParam['idGrantType'] ?? 0);

// Validate required fields
if (empty($deTokenEndpoint) || empty($deClientSecret) || $idUsuario <= 0 || $idGrantType <= 0) {
    echo json_encode(['success' => false, 'message' => 'Campos obrigatórios ausentes ou inválidos.']);
    exit;
}

// Prepare and bind
$stmt = $con->prepare(
    "INSERT INTO segAutenticacao 
     (deTokenEndpoint, deClientSecret, deToken, idUsuario, idGrantType) 
     VALUES (?, ?, ?, ?, ?)"
);

if (!$stmt) {
    echo json_encode(['success' => false, 'message' => 'Erro ao preparar a consulta: ' . $con->error]);
    exit;
}

$stmt->bind_param(
    "sssii",
    $deTokenEndpoint,
    $deClientSecret,
    $deToken,
    $idUsuario,
    $idGrantType
);

// Execute and return result
if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Registro de autenticação inserido com sucesso!', 'idAutenticacao' => $stmt->insert_id]);
} else {
    echo json_encode(['success' => false, 'message' => 'Erro no registro de autenticação: ' . $stmt->error]);
}

$stmt->close();
$con->close();

?>
