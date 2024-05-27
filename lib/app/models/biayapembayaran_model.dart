class Biayapembayaran {
  int? id;
  String? idakun;
  String? nama;
  String? jenis;
  String? programStudi;
  String? semester;
  String? tahunAngkatan;
  String? biaya;
  String? createdAt;
  String? updateAt;
  String? deletedAt;

  Biayapembayaran(
      {this.id,
      this.idakun,
      this.nama,
      this.jenis,
      this.programStudi,
      this.semester,
      this.tahunAngkatan,
      this.biaya,
      this.createdAt,
      this.updateAt,
      this.deletedAt});

  Biayapembayaran.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idakun = json['id_akun'];
    nama = json['nama'];
    jenis = json['jenis'];
    programStudi = json['program_studi'];
    semester = json['semester'];
    tahunAngkatan = json['tahun_angkatan'];
    biaya = json['biaya'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_akun'] = idakun;
    data['nama'] = nama;
    data['jenis'] = jenis;
    data['program_studi'] = programStudi;
    data['semester'] = semester;
    data['tahun_angkatan'] = tahunAngkatan;
    data['biaya'] = biaya;
    data['created_at'] = createdAt;
    data['update_at'] = updateAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
