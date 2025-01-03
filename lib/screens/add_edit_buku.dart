import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddEditBuku extends StatefulWidget {
  final Map<String, String>? bukuData; // Data untuk edit (null jika tambah)
  const AddEditBuku({this.bukuData, super.key});

  @override
  _AddEditBukuState createState() => _AddEditBukuState();
}

class _AddEditBukuState extends State<AddEditBuku> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController idController;
  late TextEditingController judulController;
  late TextEditingController pengarangController;
  late TextEditingController penerbitController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController(
        text: widget.bukuData != null ? widget.bukuData!['id'] : '');
    judulController = TextEditingController(
        text: widget.bukuData != null ? widget.bukuData!['judul'] : '');
    pengarangController = TextEditingController(
        text: widget.bukuData != null ? widget.bukuData!['pengarang'] : '');
    penerbitController = TextEditingController(
        text: widget.bukuData != null ? widget.bukuData!['penerbit'] : '');
  }

  @override
  void dispose() {
    idController.dispose();
    judulController.dispose();
    pengarangController.dispose();
    penerbitController.dispose();
    super.dispose();
  }

  void saveData() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'id': idController.text,
        'judul': judulController.text,
        'pengarang': pengarangController.text,
        'penerbit': penerbitController.text,
      };

      try {
        if (widget.bukuData == null) {
          await ApiService.addBuku(data);
        } else {
          await ApiService.updateBuku(idController.text, data);
        }
        Navigator.pop(context, true); // Berhasil, kembali ke layar sebelumnya
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bukuData == null ? 'Tambah Buku' : 'Edit Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID Buku'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Buku tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: judulController,
                decoration: const InputDecoration(labelText: 'Judul Buku'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul Buku tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: pengarangController,
                decoration: const InputDecoration(labelText: 'Pengarang Buku'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pengarang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: penerbitController,
                decoration: const InputDecoration(labelText: 'Penerbit Buku'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Penerbit tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveData,
                child: Text(widget.bukuData == null ? 'Tambah' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
