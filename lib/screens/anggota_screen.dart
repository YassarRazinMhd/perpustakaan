import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'add_edit_anggota.dart';

class AnggotaScreen extends StatefulWidget {
  const AnggotaScreen({super.key});

  @override
  _AnggotaScreenState createState() => _AnggotaScreenState();
}

class _AnggotaScreenState extends State<AnggotaScreen> {
  List<dynamic> anggotaList = [];

  @override
  void initState() {
    super.initState();
    fetchAnggota();
  }

  void fetchAnggota() async {
    final data = await ApiService.getAnggota();
    setState(() {
      anggotaList = data;
    });
  }

  void deleteAnggota(String nim) async {
    try {
      await ApiService.deleteAnggota(nim);
      fetchAnggota(); // Refresh data
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anggota'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddEditAnggota()),
              );
              if (result == true) fetchAnggota();
            },
          ),
        ],
      ),
      body: anggotaList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: anggotaList.length,
              itemBuilder: (context, index) {
                final anggota = anggotaList[index];
                return ListTile(
                  title: Text(anggota['nama']),
                  subtitle: Text(anggota['alamat']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditAnggota(
                                anggotaData: Map<String, String>.from(anggota),
                              ),
                            ),
                          );
                          if (result == true) fetchAnggota();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteAnggota(anggota['nim']),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
