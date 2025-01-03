import 'package:flutter/material.dart';
import 'package:perpus/services/api_service.dart'; // Sesuaikan path dengan proyek Anda

class BukuPage extends StatefulWidget {
  const BukuPage({super.key});

  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  Future<List<dynamic>>? _bukuFuture;

  @override
  void initState() {
    super.initState();
    _bukuFuture = ApiService.getBuku(); // Memanggil API untuk mendapatkan data buku
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _bukuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data buku'));
          } else {
            final buku = snapshot.data!;
            return ListView.builder(
              itemCount: buku.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(buku[index]['judul']), // Menampilkan judul buku
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID Buku: ${buku[index]['id_buku']}'),
                        Text('Pengarang: ${buku[index]['pengarang']}'),
                        Text('Penerbit: ${buku[index]['penerbit']}'),
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
