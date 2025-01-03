import 'package:flutter/material.dart';
import 'package:perpus/services/api_service.dart'; // Sesuaikan path dengan proyek Anda

class PengembalianPage extends StatefulWidget {
  const PengembalianPage({super.key});

  @override
  _PengembalianPageState createState() => _PengembalianPageState();
}

class _PengembalianPageState extends State<PengembalianPage> {
  Future<List<dynamic>>? _pengembalianFuture;

  @override
  void initState() {
    super.initState();
    _pengembalianFuture = ApiService.getPengembalian(); // Memanggil API untuk mendapatkan data pengembalian
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengembalian'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _pengembalianFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data pengembalian'));
          } else {
            final pengembalian = snapshot.data!;
            return ListView.builder(
              itemCount: pengembalian.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('Pengembalian ID: ${pengembalian[index]['id_pengembalian']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID Peminjaman: ${pengembalian[index]['id_peminjaman']}'),
                        Text('Tanggal Pengembalian: ${pengembalian[index]['tgl_pengembalian']}'),
                        Text('Denda: ${pengembalian[index]['denda']}'),
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
