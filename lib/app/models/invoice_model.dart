class Invoice {
  int? id;
  String? idAkun;
  String? nomorPembayaran;
  String? namaPembayaran;
  String? biayaPembayaran;
  String? kodePembayaran;
  String? keterangan;
  String? nim;
  String? nama;
  String? programStudi;
  String? fakultas;
  String? instansi;
  String? email;
  String? telepon;
  String? alamat;
  String? kota;
  String? kodePos;
  String? negara;

  Invoice(
      {this.id,
      this.idAkun,
      this.nomorPembayaran,
      this.namaPembayaran,
      this.biayaPembayaran,
      this.kodePembayaran,
      this.keterangan,
      this.nim,
      this.nama,
      this.programStudi,
      this.fakultas,
      this.instansi,
      this.email,
      this.telepon,
      this.alamat,
      this.kota,
      this.kodePos,
      this.negara});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idAkun = json['id_akun'];
    nomorPembayaran = json['nomor_pembayaran'];
    namaPembayaran = json['nama_pembayaran'];
    biayaPembayaran = json['biaya_pembayaran'];
    kodePembayaran = json['kode_pembayaran'];
    keterangan = json['keterangan'];
    nim = json['nim'];
    nama = json['nama'];
    programStudi = json['program_studi'];
    fakultas = json['fakultas'];
    instansi = json['instansi'];
    email = json['email'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    kota = json['kota'];
    kodePos = json['kode_pos'];
    negara = json['negara'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_akun'] = idAkun;
    data['nomor_pembayaran'] = nomorPembayaran;
    data['nama_pembayaran'] = namaPembayaran;
    data['biaya_pembayaran'] = biayaPembayaran;
    data['kode_pembayaran'] = kodePembayaran;
    data['keterangan'] = keterangan;
    data['nim'] = nim;
    data['nama'] = nama;
    data['program_studi'] = programStudi;
    data['fakultas'] = fakultas;
    data['instansi'] = instansi;
    data['email'] = email;
    data['telepon'] = telepon;
    data['alamat'] = alamat;
    data['kota'] = kota;
    data['kode_pos'] = kodePos;
    data['negara'] = negara;
    return data;
  }
}
