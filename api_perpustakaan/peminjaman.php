<?php

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT');
header('Access-Control-Allow-Headers: Content-Type');

require_once 'db_connect.php'; // Memanggil file koneksi database

// Fungsi untuk mengambil semua peminjaman
function getPeminjaman() {
    global $pdo;
    $stmt = $pdo->query("
        SELECT peminjaman.id, peminjaman.tanggal_pinjam, peminjaman.tanggal_kembali, 
               peminjaman.anggota_id, peminjaman.buku_id, 
               buku.judul AS buku_judul, buku.pengarang AS buku_pengarang, buku.penerbit AS buku_penerbit, buku.tahun_terbit AS buku_tahun_terbit, 
               anggota.nim AS anggota_nim, anggota.nama AS anggota_nama, anggota.alamat AS anggota_alamat
        FROM peminjaman
        JOIN buku ON peminjaman.buku_id = buku.id
        JOIN anggota ON peminjaman.anggota_id = anggota.id
    ");
    $peminjaman = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Mengubah hasil query menjadi struktur JSON yang sesuai dengan model Peminjaman
    foreach ($peminjaman as &$p) {
        $p['buku'] = [
            'judul' => $p['buku_judul'],
            'pengarang' => $p['buku_pengarang'],
            'penerbit' => $p['buku_penerbit'],
            'tahun_terbit' => $p['buku_tahun_terbit'],
        ];
        $p['anggota'] = [
            'nim' => $p['anggota_nim'],
            'nama' => $p['anggota_nama'],
            'alamat' => $p['anggota_alamat'],
        ];
        unset($p['buku_judul'], $p['buku_pengarang'], $p['buku_penerbit'], $p['buku_tahun_terbit']);
        unset($p['anggota_nim'], $p['anggota_nama'], $p['anggota_alamat']);
    }

    echo json_encode($peminjaman);
}

// Fungsi untuk menambah peminjaman baru
function createPeminjaman($data) {
    global $pdo;
    $stmt = $pdo->prepare("
        INSERT INTO peminjaman (buku_id, anggota_id, tanggal_pinjam, tanggal_kembali, status) 
        VALUES (?, ?, ?, ?, ?)
    ");
    $stmt->execute([$data->buku_id, $data->anggota_id, $data->tanggal_pinjam, $data->tanggal_kembali, $data->status]);
    echo json_encode(['message' => 'Peminjaman berhasil ditambahkan']);
}

// Fungsi untuk mengupdate peminjaman berdasarkan ID
function updatePeminjaman($id, $data) {
    global $pdo;
    $stmt = $pdo->prepare("
        UPDATE peminjaman 
        SET buku_id = ?, anggota_id = ?, tanggal_pinjam = ?, tanggal_kembali = ?, status = ? 
        WHERE id = ?
    ");
    $stmt->execute([$data->buku_id, $data->anggota_id, $data->tanggal_pinjam, $data->tanggal_kembali, $data->status, $id]);
    echo json_encode(['message' => 'Peminjaman berhasil diperbarui']);
}

// Routing berdasarkan metode HTTP
$requestMethod = $_SERVER['REQUEST_METHOD'];
$requestUri = str_replace('/projeck_perpus/peminjaman.php', '', $_SERVER['REQUEST_URI']);
$requestUri = explode('/', trim($requestUri, '/'));

if ($requestUri[0] === 'peminjaman') {
    if ($requestMethod === 'GET') {
        // GET: Ambil semua peminjaman
        getPeminjaman();
    } elseif ($requestMethod === 'POST') {
        // POST: Tambah peminjaman baru
        $data = json_decode(file_get_contents('php://input'));
        createPeminjaman($data);
    } elseif ($requestMethod === 'PUT' && isset($requestUri[1])) {
        // PUT: Perbarui peminjaman berdasarkan ID
        $data = json_decode(file_get_contents('php://input'));
        updatePeminjaman($requestUri[1], $data);
    } else {
        http_response_code(405);
        echo json_encode(['message' => 'Method Not Allowed']);
    }
} else {
    http_response_code(404);
    echo json_encode(['message' => 'Endpoint Not Found']);
}
