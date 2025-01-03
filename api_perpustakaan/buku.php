<?php

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once 'db_connect.php'; // Memanggil file koneksi database

// Fungsi untuk mengambil semua buku
function getBuku()
{
    global $pdo;
    $stmt = $pdo->query("SELECT * FROM buku");
    $buku = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($buku);
}

// Fungsi untuk menambah buku baru
function addBuku($data)
{
    global $pdo;
    $stmt = $pdo->prepare("INSERT INTO buku (judul, pengarang, penerbit, tahun_terbit) VALUES (?, ?, ?, ?)");
    $stmt->execute([$data->judul, $data->pengarang, $data->penerbit, $data->tahunTerbit]);
    echo json_encode(['message' => 'Buku berhasil ditambahkan']);
}

// Fungsi untuk menghapus buku berdasarkan ID
function deleteBuku($id)
{
    global $pdo;
    $stmt = $pdo->prepare("DELETE FROM buku WHERE id = ?");
    $stmt->execute([$id]);
    echo json_encode(['message' => 'Buku berhasil dihapus']);
}

// Routing berdasarkan metode HTTP
$requestMethod = $_SERVER['REQUEST_METHOD'];
$requestUri = str_replace('/projeck_perpus/buku.php', '', $_SERVER['REQUEST_URI']);
$requestUri = explode('/', trim($requestUri, '/'));

if ($requestUri[0] === 'buku') {
    if ($requestMethod === 'GET') {
        // GET: Ambil semua buku
        getBuku();
    } elseif ($requestMethod === 'POST') {
        // POST: Tambah buku baru
        $data = json_decode(file_get_contents('php://input'));
        addBuku($data);
    } elseif ($requestMethod === 'DELETE' && isset($requestUri[1])) {
        // DELETE: Hapus buku berdasarkan ID
        deleteBuku($requestUri[1]);
    } else {
        http_response_code(405);
        echo json_encode(['message' => 'Method Not Allowed']);
    }
} else {
    http_response_code(404);
    echo json_encode(['message' => 'Endpoint Not Found']);
}
