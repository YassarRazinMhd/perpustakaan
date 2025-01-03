import 'package:flutter/material.dart';
import 'package:perpus/services/api_service.dart'; // Ganti dengan path yang sesuai

class AnggotaPage extends StatefulWidget {
  const AnggotaPage({super.key});

  @override
  _AnggotaPageState createState() => _AnggotaPageState();
}

class _AnggotaPageState extends State<AnggotaPage> {
  Future<List<dynamic>>? _anggotaFuture;

  @override
  void initState() {
    super.initState();
    _anggotaFuture = ApiService.getAnggota(); // Memanggil API untuk mendapatkan data anggota
  }

  void _addAnggota() {
    // Navigasi ke halaman input anggota
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TambahAnggotaPage()), // Buat halaman TambahAnggotaPage
    ).then((value) {
      // Refresh data setelah kembali dari halaman input
      setState(() {
        _anggotaFuture = ApiService.getAnggota();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Anggota'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addAnggota,
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _anggotaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data anggota'));
          } else {
            final anggota = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('NIM')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Alamat')),
                  DataColumn(label: Text('Jenis Kelamin')),
                ],
                rows: anggota.map((item) {
                  return DataRow(cells: [
                    DataCell(Text(item['nim'] ?? '-')),
                    DataCell(Text(item['nama'] ?? '-')),
                    DataCell(Text(item['alamat'] ?? '-')),
                    DataCell(Text(item['jenis_kelamin'] ?? '-')),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class TambahAnggotaPage extends StatelessWidget {
  const TambahAnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Halaman untuk input anggota baru
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Anggota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'NIM'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Jenis Kelamin'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logika untuk menyimpan data anggota baru
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

