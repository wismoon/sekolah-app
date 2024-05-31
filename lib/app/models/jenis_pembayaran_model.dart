class JenisPembayaran {
  int? id;
  String? idAkun;
  String? nama;
  String? kode;
  String? pembayaran;
  String? keterangan;
  String? createdAt;
  String? updateAt;
  String? deletedAt;

  JenisPembayaran(
      {this.id,
      this.idAkun,
      this.nama,
      this.kode,
      this.pembayaran,
      this.keterangan,
      this.createdAt,
      this.updateAt,
      this.deletedAt});

  JenisPembayaran.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idAkun = json['id_akun'];
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
    data['id_akun'] = idAkun;
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
