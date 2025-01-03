<?php

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once 'db_connect.php'; // Koneksi database

// Fungsi untuk mengambil semua anggota
function getAnggota()
{
    global $pdo;
    try {
        $stmt = $pdo->query("SELECT * FROM anggota");
        $anggota = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($anggota);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
}

// Fungsi untuk mengambil anggota berdasarkan ID
function getAnggotaById($id)
{
    global $pdo;
    try {
        $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
        $stmt->execute([$id]);
        $anggota = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($anggota) {
            echo json_encode($anggota);
        } else {
            http_response_code(404);
            echo json_encode(['message' => 'Anggota tidak ditemukan']);
        }
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
}

// Fungsi untuk menambah anggota baru
function addAnggota($data)
{
    global $pdo;
    try {
        $stmt = $pdo->prepare("INSERT INTO anggota (nim, nama, alamat, jenis_kelamin) VALUES (?, ?, ?, ?)");
        $stmt->execute([$data->nim, $data->nama, $data->alamat, $data->jenis_kelamin]);
        http_response_code(201); // Status 201 untuk data berhasil dibuat
        echo json_encode(['message' => 'Anggota berhasil ditambahkan']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
}

// Fungsi untuk memperbarui anggota berdasarkan ID
function updateAnggota($id, $data)
{
    global $pdo;
    try {
        $stmt = $pdo->prepare("UPDATE anggota SET nim = ?, nama = ?, alamat = ?, jenis_kelamin = ? WHERE id = ?");
        $stmt->execute([$data->nim, $data->nama, $data->alamat, $data->jenis_kelamin, $id]);
        echo json_encode(['message' => 'Anggota berhasil diperbarui']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
}

// Fungsi untuk menghapus anggota berdasarkan ID
function deleteAnggota($id)
{
    global $pdo;
    try {
        $stmt = $pdo->prepare("DELETE FROM anggota WHERE id = ?");
        $stmt->execute([$id]);
        echo json_encode(['message' => 'Anggota berhasil dihapus']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
}

// Routing
$requestMethod = $_SERVER['REQUEST_METHOD'];
$requestUri = str_replace('/projeck_perpus/anggota.php/anggota', '', $_SERVER['REQUEST_URI']);
$requestUri = explode('/', trim($requestUri, '/'));

if (empty($requestUri[0])) {
    if ($requestMethod === 'GET') {
        getAnggota(); // Menangani GET untuk semua anggota
    } else {
        http_response_code(405); // Method Not Allowed
        echo json_encode(['message' => 'Method Not Allowed']);
    }
} elseif ($requestUri[0] === 'anggota') {
    if ($requestMethod === 'GET' && isset($requestUri[1])) {
        getAnggotaById($requestUri[1]); // Menangani GET untuk anggota berdasarkan ID
    } elseif ($requestMethod === 'POST') {
        $data = json_decode(file_get_contents('php://input'));
        if ($data && isset($data->nim, $data->nama, $data->alamat, $data->jenis_kelamin)) {
            addAnggota($data); // Menangani POST untuk menambahkan anggota baru
        } else {
            http_response_code(400); // Bad Request jika data tidak valid
            echo json_encode(['message' => 'Data tidak valid atau atribut kurang']);
        }
    } elseif ($requestMethod === 'PUT' && isset($requestUri[1])) {
        $data = json_decode(file_get_contents('php://input'));
        if ($data && isset($data->nim, $data->nama, $data->alamat, $data->jenis_kelamin)) {
            updateAnggota($requestUri[1], $data); // Menangani PUT untuk memperbarui anggota berdasarkan ID
        } else {
            http_response_code(400); // Bad Request jika data tidak valid
            echo json_encode(['message' => 'Data tidak valid atau atribut kurang']);
        }
    } elseif ($requestMethod === 'DELETE' && isset($requestUri[1])) {
        deleteAnggota($requestUri[1]); // Menangani DELETE untuk menghapus anggota berdasarkan ID
    } else {
        http_response_code(405); // Method Not Allowed jika metode tidak dikenali
        echo json_encode(['message' => 'Method Not Allowed']);
    }
} else {
    http_response_code(404); // Endpoint tidak ditemukan
    echo json_encode(['message' => 'Endpoint Not Found']);
}
