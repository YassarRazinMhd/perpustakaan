class Pengembalian {
  final int id;
  final int peminjamanId;
  final String tanggalKembali;
  final bool terlambat;

  Pengembalian({
    required this.id,
    required this.peminjamanId,
    required this.tanggalKembali,
    required this.terlambat,
  });

  // Fungsi untuk membuat objek Pengembalian dari JSON
  factory Pengembalian.fromJson(Map<String, dynamic> json) {
    return Pengembalian(
      id: json['id'],
      peminjamanId: json['peminjaman_id'],
      tanggalKembali: json['tanggal_kembali'],
      terlambat: json['terlambat'],
    );
  }

  // Fungsi untuk mengubah objek Pengembalian menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'peminjaman_id': peminjamanId,
      'tanggal_kembali': tanggalKembali,
      'terlambat': terlambat,
    };
  }
}
