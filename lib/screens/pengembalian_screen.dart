import 'package:flutter/material.dart';
import '../services/api_service.dart';

class PengembalianScreen extends StatefulWidget {
  const PengembalianScreen({super.key});

  @override
  _PengembalianScreenState createState() => _PengembalianScreenState();
}

class _PengembalianScreenState extends State<PengembalianScreen> {
  late Future<List<dynamic>> pengembalianList;

  @override
  void initState() {
    super.initState();
    pengembalianList = ApiService.getPengembalian();
  }

  void _refreshPengembalianList() {
    setState(() {
      pengembalianList = ApiService.getPengembalian();
    });
  }

  void _deletePengembalian(String id) async {
    try {
      await ApiService.deletePengembalian(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengembalian berhasil dihapus!')),
      );
      _refreshPengembalianList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus pengembalian: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengembalian'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: pengembalianList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data pengembalian.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pengembalian = snapshot.data![index];
                return ListTile(
                  title: Text('Tanggal Pengembalian: ${pengembalian['tanggal_pengembalian']}'),
                  subtitle: Text('Peminjaman: ${pengembalian['peminjaman']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deletePengembalian(pengembalian['id']),
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
