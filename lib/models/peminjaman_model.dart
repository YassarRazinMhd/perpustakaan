class Peminjaman {
  final int id;
  final int anggotaId;
  final int bukuId;
  final String tanggalPinjam;
  final String tanggalKembali;

  Peminjaman({
    required this.id,
    required this.anggotaId,
    required this.bukuId,
    required this.tanggalPinjam,
    required this.tanggalKembali,
  });

  // Fungsi untuk membuat objek Peminjaman dari JSON
  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'],
      anggotaId: json['anggota_id'],
      bukuId: json['buku_id'],
      tanggalPinjam: json['tanggal_pinjam'],
      tanggalKembali: json['tanggal_kembali'],
    );
  }

  // Fungsi untuk mengubah objek Peminjaman menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'anggota_id': anggotaId,
      'buku_id': bukuId,
      'tanggal_pinjam': tanggalPinjam,
      'tanggal_kembali': tanggalKembali,
    };
  }
}
