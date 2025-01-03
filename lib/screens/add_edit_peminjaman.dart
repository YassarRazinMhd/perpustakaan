import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddEditPeminjaman extends StatefulWidget {
  final Map<String, String>? peminjamanData; // Data untuk edit (null jika tambah)
  const AddEditPeminjaman({this.peminjamanData, super.key});

  @override
  _AddEditPeminjamanState createState() => _AddEditPeminjamanState();
}

class _AddEditPeminjamanState extends State<AddEditPeminjaman> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController idController;
  late TextEditingController nimController;
  late TextEditingController idBukuController;
  late TextEditingController tglPinjamController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController(
        text: widget.peminjamanData != null ? widget.peminjamanData!['id'] : '');
    nimController = TextEditingController(
        text: widget.peminjamanData != null ? widget.peminjamanData!['nim'] : '');
    idBukuController = TextEditingController(
        text: widget.peminjamanData != null ? widget.peminjamanData!['id_buku'] : '');
    tglPinjamController = TextEditingController(
        text: widget.peminjamanData != null ? widget.peminjamanData!['tgl_pinjam'] : '');
  }

  @override
  void dispose() {
    idController.dispose();
    nimController.dispose();
    idBukuController.dispose();
    tglPinjamController.dispose();
    super.dispose();
  }

  void saveData() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'id': idController.text,
        'nim': nimController.text,
        'id_buku': idBukuController.text,
        'tgl_pinjam': tglPinjamController.text,
      };

      try {
        if (widget.peminjamanData == null) {
          await ApiService.addPeminjaman(data);
        } else {
          await ApiService.updatePeminjaman(idController.text, data);
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
        title: Text(widget.peminjamanData == null ? 'Tambah Peminjaman' : 'Edit Peminjaman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID Peminjaman'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Peminjaman tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: idBukuController,
                decoration: const InputDecoration(labelText: 'ID Buku'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Buku tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tglPinjamController,
                decoration: const InputDecoration(labelText: 'Tanggal Pinjam'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal Pinjam tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveData,
                child: Text(widget.peminjamanData == null ? 'Tambah' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
