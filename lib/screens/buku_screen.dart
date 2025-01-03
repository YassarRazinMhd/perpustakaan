import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BukuScreen extends StatefulWidget {
  const BukuScreen({super.key});

  @override
  _BukuScreenState createState() => _BukuScreenState();
}

class _BukuScreenState extends State<BukuScreen> {
  late Future<List<dynamic>> bukuList;

  @override
  void initState() {
    super.initState();
    bukuList = ApiService.getBuku();
  }

  void _refreshBukuList() {
    setState(() {
      bukuList = ApiService.getBuku();
    });
  }

  void _deleteBuku(String id) async {
    try {
      await ApiService.deleteBuku(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Buku berhasil dihapus!')),
      );
      _refreshBukuList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus buku: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: bukuList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data buku.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final buku = snapshot.data![index];
                return ListTile(
                  title: Text(buku['judul']),
                  subtitle: Text('Pengarang: ${buku['pengarang']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteBuku(buku['id']),
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
