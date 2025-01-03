import 'package:flutter/material.dart';
import '../services/api_service.dart';

class PeminjamanScreen extends StatefulWidget {
  const PeminjamanScreen({super.key});

  @override
  _PeminjamanScreenState createState() => _PeminjamanScreenState();
}

class _PeminjamanScreenState extends State<PeminjamanScreen> {
  late Future<List<dynamic>> peminjamanList;

  @override
  void initState() {
    super.initState();
    peminjamanList = ApiService.getPeminjaman();
  }

  void _refreshPeminjamanList() {
    setState(() {
      peminjamanList = ApiService.getPeminjaman();
    });
  }

  void _deletePeminjaman(String id) async {
    try {
      await ApiService.deletePeminjaman(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Peminjaman berhasil dihapus!')),
      );
      _refreshPeminjamanList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus peminjaman: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Peminjaman'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: peminjamanList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data peminjaman.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final peminjaman = snapshot.data![index];
                return ListTile(
                  title: Text('Tanggal Pinjam: ${peminjaman['tanggal_pinjam']}'),
                  subtitle: Text('Anggota: ${peminjaman['anggota']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deletePeminjaman(peminjaman['id']),
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
