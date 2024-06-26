import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/services/biaya_pembayaran_service.dart';
import 'package:sekolah_app/app/models/biayapembayaran_model.dart';

class BiayaPembayaranController extends GetxController {
  var nameBiaya = TextEditingController();
  var selectedJenis = ''.obs;
  var nameStudi = TextEditingController();
  var nameSemester = TextEditingController();
  var nameTahunAngkatan = TextEditingController();
  var biaya = TextEditingController();

  final BiayaPembayaranService _service = BiayaPembayaranService();
  var biayaPembayaranList = <Biayapembayaran>[].obs;

  var isBusy = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments != null) {
      nameBiaya.text = arguments['nama'] ?? '';
      selectedJenis.value = arguments['jenis'] ?? '';
      nameStudi.text = arguments['programStudi'] ?? '';
      nameSemester.text = arguments['semester'] ?? '';
      nameTahunAngkatan.text = arguments['tahunAngkatan'] ?? '';
      biaya.text = arguments['biaya'] ?? '';
    }
    fetchBiayaPembayaran();
    super.onInit();
  }

  @override
  void onClose() {
    nameBiaya.dispose();
    nameStudi.dispose();
    nameSemester.dispose();
    nameTahunAngkatan.dispose();
    biaya.dispose();
    super.onClose();
  }

  void fetchBiayaPembayaran() async {
    try {
      isLoading(true);
      var biayaPembayaran = await _service.fetchBiayaPembayaran();
      if (biayaPembayaran.isEmpty) {
        Get.snackbar(
          'Data Error',
          'Failed to load data because is Empty',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      } else {
        biayaPembayaranList.value = biayaPembayaran;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal terhubung ke server',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  void createBiayaPembayaran(Biayapembayaran biayaPembayaran) async {
    isBusy.value = true;
    try {
      await _service.createBiayaPembayaran(biayaPembayaran);
      print('Biaya Pembayaran created successfully');
      Get.snackbar(
        'Success',
        'Biaya Pembayaran created successfully',
        backgroundColor: AppColors.successColor,
        colorText: Colors.white,
      );
      nameBiaya.clear();
      nameStudi.clear();
      nameSemester.clear();
      nameTahunAngkatan.clear();
      biaya.clear();
      selectedJenis.value;
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isBusy.value = false;
    }
    fetchBiayaPembayaran();
  }

  void deleteBiayaPembayaran(int id) async {
    isBusy(true);
    try {
      await _service.deleteBiayaPembayaran(id);
      Get.snackbar(
        'Success',
        'Biaya Pembayaran deleted successfully',
        backgroundColor: AppColors.successColor,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isBusy(false);
    }
    fetchBiayaPembayaran();
  }
}
