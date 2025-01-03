import 'package:flutter/material.dart';
import 'anggota_page.dart';
import 'buku_page.dart';
import 'peminjaman_page.dart';
import 'pengembalian_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            // Menu Anggota
            _buildMenuCard(
              context,
              icon: Icons.group,
              title: 'Anggota',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnggotaPage()),
                );
              },
            ),
            // Menu Buku
            _buildMenuCard(
              context,
              icon: Icons.book,
              title: 'Buku',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BukuPage()),
                );
              },
            ),
            // Menu Peminjaman
            _buildMenuCard(
              context,
              icon: Icons.assignment,
              title: 'Peminjaman',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PeminjamanPage()),
                );
              },
            ),
            // Menu Pengembalian
            _buildMenuCard(
              context,
              icon: Icons.assignment_return,
              title: 'Pengembalian',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PengembalianPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
