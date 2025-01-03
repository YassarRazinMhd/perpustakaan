import 'package:flutter/material.dart';
import '../services/api_service.dart';  // Pastikan path ini benar

class AddEditAnggota extends StatefulWidget {
  final Map<String, String>? anggotaData; // Data untuk edit (null jika tambah)
  const AddEditAnggota({this.anggotaData, super.key});

  @override
  _AddEditAnggotaState createState() => _AddEditAnggotaState();
}

class _AddEditAnggotaState extends State<AddEditAnggota> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nimController;
  late TextEditingController namaController;
  late TextEditingController alamatController;
  late TextEditingController jenisKelaminController;

  @override
  void initState() {
    super.initState();
    nimController = TextEditingController(
        text: widget.anggotaData != null ? widget.anggotaData!['nim'] : '');
    namaController = TextEditingController(
        text: widget.anggotaData != null ? widget.anggotaData!['nama'] : '');
    alamatController = TextEditingController(
        text: widget.anggotaData != null ? widget.anggotaData!['alamat'] : '');
    jenisKelaminController = TextEditingController(
        text: widget.anggotaData != null ? widget.anggotaData!['jenis_kelamin'] : '');
  }

  @override
  void dispose() {
    nimController.dispose();
    namaController.dispose();
    alamatController.dispose();
    jenisKelaminController.dispose();
    super.dispose();
  }

  void saveData() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'nim': nimController.text,
        'nama': namaController.text,
        'alamat': alamatController.text,
        'jenis_kelamin': jenisKelaminController.text,
      };

      try {
        if (widget.anggotaData == null) {
          // Menambahkan anggota baru
          await ApiService.addAnggota(data);
        } else {
          // Memperbarui data anggota yang ada
          await ApiService.updateAnggota(nimController.text, data);
        }
        // Kembali ke halaman sebelumnya setelah data berhasil disimpan
        Navigator.pop(context, true);
      } catch (e) {
        // Menampilkan pesan kesalahan jika terjadi error
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anggotaData == null ? 'Tambah Anggota' : 'Edit Anggota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: jenisKelaminController,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis Kelamin tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveData,
                child: Text(widget.anggotaData == null ? 'Tambah' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
