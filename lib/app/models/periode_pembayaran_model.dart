class PeriodePembayaran {
  int? id;
  String? nama;
  List<String>? jenis;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  PeriodePembayaran(
      {this.id,
      this.nama,
      this.jenis,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  PeriodePembayaran.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    jenis = json['jenis']?.cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['jenis'] = jenis;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
