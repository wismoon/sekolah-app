import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? id;
  String? nim;
  String? nama;
  String? email;
  String? jurusan;
  String? fakultas;
  String? instansi;
  String? tahunAngkatan;
  String? tempatLahir;
  String? tanggalLahir;
  String? jenisKelamin;
  String? agama;
  String? alamat;
  String? createdAt;
  String? nomorTelepon;
  String? role;
  String? kota;
  String? kodePos;
  String? negara;

  Student(
      {this.id,
      this.nim,
      this.nama,
      this.email,
      this.jurusan,
      this.fakultas,
      this.instansi,
      this.tahunAngkatan,
      this.tempatLahir,
      this.tanggalLahir,
      this.jenisKelamin,
      this.agama,
      this.alamat,
      this.createdAt,
      this.nomorTelepon,
      this.kota,
      this.kodePos,
      this.negara,
      this.role});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nim = json['nim'];
    nama = json['nama'];
    email = json['email'];
    jurusan = json['jurusan'];
    fakultas = json['fakultas'];
    instansi = json['instansi'];
    tahunAngkatan = json['tahun-angkatan'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    jenisKelamin = json['jenis_kelamin'];
    agama = json['agama'];
    alamat = json['alamat'];
    createdAt = json['createdAt'];
    nomorTelepon = json['nomor_telepon'];
    role = json['role'];
    kota = json['kota'];
    kodePos = json['kodePos'];
    negara = json['negara'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nim'] = nim;
    data['nama'] = nama;
    data['email'] = email;
    data['jurusan'] = jurusan;
    data['fakultas'] = fakultas;
    data['instansi'] = instansi;
    data['tahun-angkatan'] = tahunAngkatan;
    data['tempat_lahir'] = tempatLahir;
    data['tanggal_lahir'] = tanggalLahir;
    data['jenis_kelamin'] = jenisKelamin;
    data['agama'] = agama;
    data['alamat'] = alamat;
    data['createdAt'] = createdAt;
    data['nomor_telepon'] = nomorTelepon;
    data['role'] = role;
    data['kota'] = kota;
    data['kodePos'] = kodePos;
    data['negara'] = negara;
    return data;
  }
  
  factory Student.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Student(
      id: doc.id,
      nim: data['nim'],
      nama: data['nama'],
      email: data['email'],
      jurusan: data['jurusan'],
      fakultas: data['fakultas'],
      instansi: data['instansi'],
      tahunAngkatan: data['tahun-angkatan'],
      tempatLahir: data['tempat_lahir'],
      tanggalLahir: data['tanggal_lahir'],
      jenisKelamin: data['jenis_kelamin'],
      agama: data['agama'],
      alamat: data['alamat'],
      createdAt: data['createdAt'],
      nomorTelepon: data['nomor_telepon'],
      role: data['role'],
      kota: data['kota'],
      kodePos: data['kodePos'],
      negara: data['negara'],
    );
  }
}
