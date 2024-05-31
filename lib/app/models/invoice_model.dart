class Invoice {
  int? id;
  String? idAkun;
  String? nomor_pembayaran;
  String? nama_pembayaran;
  String? biaya_pembayaran;
  String? jenis_pembayaran;
  String? kode_pembayaran;
  String? keterangan;
  String? nim;
  String? nama;
  String? program_studi;
  String? fakultas;
  String? instansi;
  String? email;
  String? telepon;
  String? alamat;
  String? kota;
  String? kodePos;
  String? negara;
  List<Map<String, dynamic>>? individu;

  Invoice(
      {this.id,
      this.idAkun,
      this.nomor_pembayaran,
      this.nama_pembayaran,
      this.biaya_pembayaran,
      this.jenis_pembayaran,
      this.kode_pembayaran,
      this.keterangan,
      this.nim,
      this.nama,
      this.program_studi,
      this.fakultas,
      this.instansi,
      this.email,
      this.telepon,
      this.alamat,
      this.kota,
      this.kodePos,
      this.negara,
      this.individu});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idAkun = json['id_akun'];
    nomor_pembayaran = json['nomor_pembayaran'];
    nama_pembayaran = json['nama_pembayaran'];
    biaya_pembayaran = json['biaya_pembayaran'];
    jenis_pembayaran = json['jenis_pembayaran'];
    kode_pembayaran = json['kode_pembayaran'];
    keterangan = json['keterangan'];
    nim = json['nim'];
    nama = json['nama'];
    program_studi = json['program_studi'];
    fakultas = json['fakultas'];
    instansi = json['instansi'];
    email = json['email'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    kota = json['kota'];
    kodePos = json['kode_pos'];
    negara = json['negara'];
    if (json['individu'] != null) {
      individu = List<Map<String, dynamic>>.from(json['individu']);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_akun'] = idAkun;
    data['nomor_pembayaran'] = nomor_pembayaran;
    data['nama_pembayaran'] = nama_pembayaran;
    data['biaya_pembayaran'] = biaya_pembayaran;
    data['jenis_pembayaran'] = jenis_pembayaran;
    data['kode_pembayaran'] = kode_pembayaran;
    data['keterangan'] = keterangan;
    data['nim'] = nim;
    data['nama'] = nama;
    data['program_studi'] = program_studi;
    data['fakultas'] = fakultas;
    data['instansi'] = instansi;
    data['email'] = email;
    data['telepon'] = telepon;
    data['alamat'] = alamat;
    data['kota'] = kota;
    data['kode_pos'] = kodePos;
    data['negara'] = negara;
    if (individu != null) {
      data['individu'] = individu;
    }
    return data;
  }
}
