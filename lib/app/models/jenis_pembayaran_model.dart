class JenisPembayaran {
  int? id;
  String? id_akun;
  String? nama;
  String? kode;
  String? pembayaran;
  String? keterangan;
  String? createdAt;
  String? updateAt;
  String? deletedAt;

  JenisPembayaran(
      {this.id,
      this.id_akun,
      this.nama,
      this.kode,
      this.pembayaran,
      this.keterangan,
      this.createdAt,
      this.updateAt,
      this.deletedAt});

  JenisPembayaran.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id_akun = json['id_akun'];
    nama = json['nama'];
    kode = json['kode'];
    pembayaran = json['pembayaran'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_akun'] = id_akun;
    data['nama'] = nama;
    data['kode'] = kode;
    data['pembayaran'] = pembayaran;
    data['keterangan'] = keterangan;
    data['created_at'] = createdAt;
    data['update_at'] = updateAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
