<?php

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once 'db_connect.php'; // Memanggil file koneksi database

// Fungsi untuk mengambil semua pengembalian
function getPengembalian()
{
    global $pdo;
    $stmt = $pdo->query("SELECT pengembalian.id, pengembalian.tanggal_dikembalikan, pengembalian.terlambat, pengembalian.denda, 
               pengembalian.peminjaman_id, peminjaman.buku_id, peminjaman.anggota_id, 
               anggota.nama AS nama_anggota, buku.judul AS judul_buku
        FROM pengembalian
        JOIN peminjaman ON pengembalian.peminjaman_id = peminjaman.id
        JOIN anggota ON peminjaman.anggota_id = anggota.id
        JOIN buku ON peminjaman.buku_id = buku.id
    ");
    $pengembalian = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Menyesuaikan hasil query dengan model Pengembalian Flutter
    foreach ($pengembalian as &$p) {
        $p['peminjaman'] = [
            'id' => $p['peminjaman_id'],
            'buku_id' => $p['buku_id'],
            'anggota_id' => $p['anggota_id'],
        ];
        $p['nama_anggota'] = $p['nama_anggota'];
        $p['judul_buku'] = $p['judul_buku'];

        unset($p['peminjaman_id'], $p['buku_id'], $p['anggota_id'], $p['nama_anggota'], $p['judul_buku']);
    }

    echo json_encode($pengembalian);
}

// Fungsi untuk menambah pengembalian baru
function createPengembalian($data)
{
    global $pdo;

    // Ambil tanggal kembali dari tabel peminjaman berdasarkan peminjaman_id
    $stmt = $pdo->prepare("SELECT tanggal_kembali FROM peminjaman WHERE id = ?");
    $stmt->execute([$data->peminjaman_id]);
    $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($peminjaman) {
        $tanggal_kembali = $peminjaman['tanggal_kembali'];

        // Menghitung keterlambatan (selisih hari antara tanggal dikembalikan dan tanggal kembali)
        $tanggal_dikembalikan = new DateTime($data->tanggal_dikembalikan);
        $tanggal_kembali_date = new DateTime($tanggal_kembali);
        $interval = $tanggal_dikembalikan->diff($tanggal_kembali_date);
        $terlambat = $interval->days;

        // Jika terlambat, hitung denda (misalnya 5000 per hari)
        $denda = 0;
        if ($tanggal_dikembalikan > $tanggal_kembali_date) {
            $denda = $terlambat * 5000; // 5000 per hari
        }

        // Insert data pengembalian
        $stmt = $pdo->prepare("
            INSERT INTO pengembalian (peminjaman_id, tanggal_dikembalikan, terlambat, denda, status) 
            VALUES (?, ?, ?, ?, ?)
        ");
        $stmt->execute([$data->peminjaman_id, $data->tanggal_dikembalikan, $terlambat, $denda, 'dikembalikan']);

        // Mengembalikan pesan sukses
        echo json_encode(['message' => 'Pengembalian berhasil ditambahkan']);
    } else {
        echo json_encode(['message' => 'Peminjaman tidak ditemukan']);
    }
}


// Fungsi untuk menghapus pengembalian berdasarkan ID
function deletePengembalian($id)
{
    global $pdo;
    $stmt = $pdo->prepare("DELETE FROM pengembalian WHERE id = ?");
    $stmt->execute([$id]);
    echo json_encode(['message' => 'Pengembalian berhasil dihapus']);
}

// Routing berdasarkan metode HTTP
$requestMethod = $_SERVER['REQUEST_METHOD'];
$requestUri = str_replace('/projeck_perpus/pengembalian.php', '', $_SERVER['REQUEST_URI']);
$requestUri = explode('/', trim($requestUri, '/'));

if ($requestUri[0] === 'pengembalian') {
    if ($requestMethod === 'GET') {
        // GET: Ambil semua pengembalian
        getPengembalian();
    } elseif ($requestMethod === 'POST') {
        // POST: Tambah pengembalian baru
        $data = json_decode(file_get_contents('php://input'));
        createPengembalian($data);
    } elseif ($requestMethod === 'DELETE' && isset($requestUri[1])) {
        // DELETE: Hapus pengembalian berdasarkan ID
        deletePengembalian($requestUri[1]);
    } else {
        http_response_code(405);
        echo json_encode(['message' => 'Method Not Allowed']);
    }
} else {
    http_response_code(404);
    echo json_encode(['message' => 'Endpoint Not Found']);
}
