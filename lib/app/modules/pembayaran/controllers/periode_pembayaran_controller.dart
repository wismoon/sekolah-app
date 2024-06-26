import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/periode_pembayaran_model.dart';
import 'package:sekolah_app/app/services/periode_pembayaran_service.dart';

class PeriodePembayaranController extends GetxController {
  var namePeriode = TextEditingController();
  var selectedJenisPeriode = ''.obs;

  final PeriodePembayaranService _service = PeriodePembayaranService();
  var periodePembayaranList = <PeriodePembayaran>[].obs;

  var isBusy = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments != null) {
      namePeriode.text = arguments['nama'] ?? '';
      selectedJenisPeriode.value = arguments['jenis'] ?? '';
    }
    fetchPeriodePembayaran();
    super.onInit();
  }

  @override
  void onClose() {
    namePeriode.dispose();
    super.onClose();
  }

  void fetchPeriodePembayaran() async {
    try {
      isLoading(true);
      var periodePembayaran = await _service.fetchPeriodePembayaran();
      if (periodePembayaran.isEmpty) {
        Get.snackbar(
          'Data Error',
          'Failed to load data because is Empty',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      } else {
        periodePembayaranList.value = periodePembayaran;
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

  void createPeriodePembayaran(PeriodePembayaran periodePembayaran) async {
    isBusy.value = true;
    try {
      await _service.createPeriodePembayaran(periodePembayaran);
      print('Biaya Pembayaran created successfully');
      Get.snackbar(
        'Success',
        'Biaya Pembayaran created successfully',
        backgroundColor: AppColors.successColor,
        colorText: Colors.white,
      );
      namePeriode.clear();
      selectedJenisPeriode.value = '';
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Failed to create data: $e',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isBusy.value = false;
    }
    fetchPeriodePembayaran();
  }

  void updatePeriodePembayaran(PeriodePembayaran periodePembayaran) async {
    await _service.updatePeriodePembayaran(periodePembayaran);
    fetchPeriodePembayaran();
  }

  void deletePeriodePembayaran(int id) async {
    isBusy(true);
    try {
      await _service.deletePeriodePembayaran(id);
      Get.snackbar(
        'Success',
        'Periode Pembayaran deleted successfully',
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
    fetchPeriodePembayaran();
  }
}
