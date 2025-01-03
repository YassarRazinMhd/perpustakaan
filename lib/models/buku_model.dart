class Buku {
  final int id;
  final String judul;
  final String pengarang;
  final String penerbit;

  Buku({
    required this.id,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
  });

  // Fungsi untuk membuat objek Buku dari JSON
  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'],
      judul: json['judul'],
      pengarang: json['pengarang'],
      penerbit: json['penerbit'],
    );
  }

  // Fungsi untuk mengubah objek Buku menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'pengarang': pengarang,
      'penerbit': penerbit,
    };
  }
}
