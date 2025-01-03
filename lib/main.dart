import 'package:flutter/material.dart';
import '../pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpustakaan',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(), // Halaman utama
    );
  }
}
