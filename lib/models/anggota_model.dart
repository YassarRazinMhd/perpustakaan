class Anggota {
  final int id;
  final String nim;
  final String nama;
  final String alamat;
  final String jenisKelamin;

  Anggota({
    required this.id,
    required this.nim,
    required this.nama,
    required this.alamat,
    required this.jenisKelamin,
  });

  // Fungsi untuk membuat objek Anggota dari JSON
  factory Anggota.fromJson(Map<String, dynamic> json) {
    return Anggota(
      id: json['id'],
      nim: json['nim'],
      nama: json['nama'],
      alamat: json['alamat'],
      jenisKelamin: json['jenis_kelamin'],
    );
  }

  // Fungsi untuk mengubah objek Anggota menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nim': nim,
      'nama': nama,
      'alamat': alamat,
      'jenis_kelamin': jenisKelamin,
    };
  }
}
