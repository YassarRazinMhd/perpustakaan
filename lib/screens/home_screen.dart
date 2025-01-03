import 'package:flutter/material.dart';
import 'anggota_screen.dart';
import 'buku_screen.dart';
import 'peminjaman_screen.dart';
import 'add_edit_pengembalian.dart'; // Pastikan ini adalah file yang benar

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Anggota'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnggotaScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Buku'),
            leading: const Icon(Icons.book),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BukuScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Peminjaman'),
            leading: const Icon(Icons.shopping_cart),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PeminjamanScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Pengembalian'),
            leading: const Icon(Icons.done),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddEditPengembalian()), // Pastikan ini adalah screen yang benar
              );
            },
          ),
        ],
      ),
    );
  }
}