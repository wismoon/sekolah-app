import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/models/student_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';
import 'package:sekolah_app/app/services/invoice_service.dart';

class TagihanKelompokController extends GetxController {
  var selectedValue = ''.obs;
  var selectedJenis = ''.obs;
  var selectedPeriode = ''.obs;
  var selectedBiaya = ''.obs;
  var commentJenis = TextEditingController();
  var selectedTahunAngkatan = ''.obs;
  var selectedJurusan = ''.obs;
  var students = <Student>[].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final JenisPembayaranController jenisPembayaranController = Get.find();
  final InvoiceService _service = InvoiceService();

  var invoicePembayaranList = <Invoice>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    fetchStudents();
    super.onInit();
  }

  void fetchStudents() async {
    isLoading(true);
    try {
      QuerySnapshot querySnapshot = await firestore.collection('siswa').get();
      students.value = querySnapshot.docs
          .map((doc) => Student.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch students: $e',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  void createInvoiceBulkPembayaran(String tahunAngkatan, String? jurusan) async {
    print("Selected Tahun Angkatan: $tahunAngkatan");
    final filteredStudents = students
        .where((student) => student.tahunAngkatan == tahunAngkatan && (jurusan == null || jurusan.isEmpty || student.jurusan == jurusan)).toList();
    print("Filtered Students: ${filteredStudents.length}");

    if (filteredStudents.isEmpty) {
      Get.snackbar(
        'Error',
        'No students found for the selected tahun angkatan',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }
    if (selectedJenis.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select jenis pembayaran',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }
    final jenisPembayaran =
        jenisPembayaranController.getJenisPembayaranByNama(selectedJenis.value);

    if (selectedPeriode.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select periode pembayaran',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }
    if (selectedBiaya.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select biaya pembayaran',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }

    for (var student in filteredStudents) {
      final invoicePembayaran = Invoice(
          jenis_pembayaran: selectedJenis.value,
          biaya_pembayaran: selectedBiaya.value,
          nama_pembayaran: selectedPeriode.value,
          idAkun: jenisPembayaran?.idAkun,
          kode_pembayaran: jenisPembayaran?.kode,
          keterangan: commentJenis.text,
          nim: student.nim,
          nama: student.nama,
          program_studi: student.jurusan,
          fakultas: student.fakultas,
          instansi: student.instansi,
          email: student.email,
          telepon: student.nomorTelepon,
          alamat: student.alamat,
          kota: student.kota,
          kodePos: student.kodePos,
          negara: student.negara,
          individu: [
            {
              "nim": student.nim,
              "nama": student.nama,
              "email": student.email,
              "jurusan": student.jurusan,
              "fakultas": student.fakultas,
              "instansi": student.instansi,
              "tahun_angkatan": student.tahunAngkatan,
              "jenis_kelamin": student.jenisKelamin ?? '',
              "tempat_lahir": student.tempatLahir ?? '',
              "tanggal_lahir": student.tanggalLahir ?? '',
            }
          ]);

      print('Invoice Data: ${invoicePembayaran.toJson()}');

      isLoading(true);
      try {
        await _service.createInvoiceBulkPembayaran(invoicePembayaran);
        Get.snackbar(
          'Success',
          'Invoice created successfully',
          backgroundColor: AppColors.successColor,
          colorText: Colors.white,
        );
      } catch (e) {
        print('Error: $e');
        Get.snackbar('Error', e.toString());
      } finally {
        isLoading(false);
      }
    }

    void clearForm() {
      selectedTahunAngkatan.value = '';
      selectedJenis.value = '';
      selectedPeriode.value = '';
      selectedBiaya.value = '';
      commentJenis.clear();
    }
  }
}
