class Listjenispembayaran {
  String? id;
  String? nama;
  String? kode;

  Listjenispembayaran({this.id, this.nama, this.kode});

  Listjenispembayaran.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kode = json['kode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['kode'] = kode;
    return data;
  }
}
