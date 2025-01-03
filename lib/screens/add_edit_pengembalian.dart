import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddEditPengembalian extends StatefulWidget {
  final Map<String, String>? pengembalianData; // Data untuk edit (null jika tambah)
  const AddEditPengembalian({this.pengembalianData, super.key});

  @override
  _AddEditPengembalianState createState() => _AddEditPengembalianState();
}

class _AddEditPengembalianState extends State<AddEditPengembalian> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController idController;
  late TextEditingController idPeminjamanController;
  late TextEditingController tglKembaliController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController(
        text: widget.pengembalianData != null ? widget.pengembalianData!['id'] : '');
    idPeminjamanController = TextEditingController(
        text: widget.pengembalianData != null ? widget.pengembalianData!['id_peminjaman'] : '');
    tglKembaliController = TextEditingController(
        text: widget.pengembalianData != null ? widget.pengembalianData!['tgl_kembali'] : '');
  }

  @override
  void dispose() {
    idController.dispose();
    idPeminjamanController.dispose();
    tglKembaliController.dispose();
    super.dispose();
  }

  void saveData() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'id': idController.text,
        'id_peminjaman': idPeminjamanController.text,
        'tgl_kembali': tglKembaliController.text,
      };

      try {
        if (widget.pengembalianData == null) {
          await ApiService.addPengembalian(data);
        } else {
          await ApiService.updatePengembalian(idController.text, data);
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
        title: Text(widget.pengembalianData == null ? 'Tambah Pengembalian' : 'Edit Pengembalian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID Pengembalian'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Pengembalian tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: idPeminjamanController,
                decoration: const InputDecoration(labelText: 'ID Peminjaman'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Peminjaman tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tglKembaliController,
                decoration: const InputDecoration(labelText: 'Tanggal Kembali'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal Kembali tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveData,
                child: Text(widget.pengembalianData == null ? 'Tambah' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
