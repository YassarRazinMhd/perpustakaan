import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
static const String baseUrl = 'http://localhost/perpustakaan/';

  // ========================= ANGOTA =========================
  // GET Data Anggota
  static Future<List<dynamic>> getAnggota() async {
    final response = await http.get(Uri.parse('$baseUrl/anggota.php'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load anggota data');
    }
  }
  

  // POST Data Anggota (Tambah)
  static Future<void> addAnggota(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/anggota.php'),
      body: data,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add anggota');
    }
  }

  // PUT Data Anggota (Edit)
  static Future<void> updateAnggota(String nim, Map<String, String> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/anggota.php?nim=$nim'),
      body: data,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update anggota');
    }
  }

  // DELETE Data Anggota
  static Future<void> deleteAnggota(String nim) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/anggota.php?nim=$nim'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete anggota');
    }
  }

  // ========================= BUKU =========================
  // GET Data Buku
  static Future<List<dynamic>> getBuku() async {
    final response = await http.get(Uri.parse('$baseUrl/buku.php'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load buku data');
    }
  }

  // POST Data Buku (Tambah)
  static Future<void> addBuku(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/buku.php'),
      body: data,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add buku');
    }
  }

  // PUT Data Buku (Edit)
  static Future<void> updateBuku(String id, Map<String, String> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/buku.php?id=$id'),
      body: data,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update buku');
    }
  }

  // DELETE Data Buku
  static Future<void> deleteBuku(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/buku.php?id=$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete buku');
    }
  }

  // ========================= PEMINJAMAN =========================
  // GET Data Peminjaman
  static Future<List<dynamic>> getPeminjaman() async {
    final response = await http.get(Uri.parse('$baseUrl/peminjaman.php'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load peminjaman data');
    }
  }

  // POST Data Peminjaman (Tambah)
  static Future<void> addPeminjaman(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/peminjaman.php'),
      body: data,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add peminjaman');
    }
  }

  // PUT Data Peminjaman (Edit)
  static Future<void> updatePeminjaman(String id, Map<String, String> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/peminjaman.php?id=$id'),
      body: data,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update peminjaman');
    }
  }

  // DELETE Data Peminjaman
  static Future<void> deletePeminjaman(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/peminjaman.php?id=$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete peminjaman');
    }
  }

  // ========================= PENGEMBALIAN =========================
  // GET Data Pengembalian
  static Future<List<dynamic>> getPengembalian() async {
    final response = await http.get(Uri.parse('$baseUrl/pengembalian.php'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pengembalian data');
    }
  }

  // POST Data Pengembalian (Tambah)
  static Future<void> addPengembalian(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pengembalian.php'),
      body: data,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add pengembalian');
    }
  }

  // PUT Data Pengembalian (Edit)
  static Future<void> updatePengembalian(String id, Map<String, String> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pengembalian.php?id=$id'),
      body: data,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update pengembalian');
    }
  }

  // DELETE Data Pengembalian
  static Future<void> deletePengembalian(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/pengembalian.php?id=$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete pengembalian');
    }
  }
}
