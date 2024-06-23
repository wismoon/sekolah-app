import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/models/student_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';
import 'package:sekolah_app/app/services/invoice_service.dart';

class TagihanIndividuController extends GetxController {
  var selectedValue = ''.obs;
  var selectedJenis = ''.obs;
  var selectedPeriode = ''.obs;
  var selectedBiaya = ''.obs;
  var commentJenis = TextEditingController();
  var students = <Student>[].obs;
  var selectedStudent = Rx<Student?>(null);

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

  void createInvoicePembayaran() async {
    if (selectedStudent.value == null) {
      Get.snackbar(
        'Error',
        'Please select a student',
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

    final invoicePembayaran = Invoice(
      idAkun: jenisPembayaran?.idAkun,
      kode_pembayaran: jenisPembayaran?.kode,
      jenis_pembayaran: selectedJenis.value,
      nama_pembayaran: selectedPeriode.value,
      biaya_pembayaran: selectedBiaya.value,
      keterangan: commentJenis.text,
      nim: selectedStudent.value?.nim,
      nama: selectedStudent.value?.nama,
      program_studi: selectedStudent.value?.jurusan,
      fakultas: selectedStudent.value?.fakultas,
      instansi: selectedStudent.value?.instansi,
      email: selectedStudent.value?.email ?? '',
      telepon: selectedStudent.value?.nomorTelepon ?? '',
      alamat: selectedStudent.value?.alamat ?? '',
      kota: selectedStudent.value?.kota ?? '',
      kodePos: selectedStudent.value?.kodePos ?? '',
    );

    // print('Invoice Data: ${invoicePembayaran.toJson()}');

    isLoading.value = true;
    try {
      await _service.createInvoicePembayaran(invoicePembayaran);
      Get.snackbar(
        'Success',
        'Invoice created successfully',
        backgroundColor: AppColors.successColor,
        colorText: Colors.white,
      );
      clearForm();
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String generateNomorPembayaran(
      String kodeInstansi, String? kodePembayaran, String? nim) {
    return kodeInstansi +
        (kodePembayaran ?? '') +
        DateTime.now().year.toString().substring(2) +
        (nim ?? '');
  }

  void clearForm() {
    selectedStudent.value = null;
    selectedJenis.value = '';
    selectedPeriode.value = '';
    selectedBiaya.value = '';
    commentJenis.clear();
  }
}
