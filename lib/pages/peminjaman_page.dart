import 'package:flutter/material.dart';
import 'package:perpus/services/api_service.dart'; // Sesuaikan path dengan proyek Anda

class PeminjamanPage extends StatefulWidget {
  const PeminjamanPage({super.key});

  @override
  _PeminjamanPageState createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  Future<List<dynamic>>? _peminjamanFuture;

  @override
  void initState() {
    super.initState();
    _peminjamanFuture = ApiService.getPeminjaman(); // Memanggil API untuk mendapatkan data peminjaman
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Peminjaman'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _peminjamanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data peminjaman'));
          } else {
            final peminjaman = snapshot.data!;
            return ListView.builder(
              itemCount: peminjaman.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('Peminjaman ID: ${peminjaman[index]['id_peminjaman']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID Anggota: ${peminjaman[index]['id_anggota']}'),
                        Text('ID Buku: ${peminjaman[index]['id_buku']}'),
                        Text('Tanggal Pinjam: ${peminjaman[index]['tgl_pinjam']}'),
                        Text('Tanggal Kembali: ${peminjaman[index]['tgl_kembali']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
