import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';
import 'package:sekolah_app/app/services/jenis_pembayaran_service.dart';

class JenisPembayaranController extends GetxController {
  var pembayaranValue = ''.obs;
  var nameJenis = TextEditingController();
  var kodeJenis = TextEditingController();
  var commentJenis = TextEditingController();

  final JenisPembayaranService _service = JenisPembayaranService();
  var jenisPembayaranList = <JenisPembayaran>[].obs;
  var filteredPembayaranList = <JenisPembayaran>[].obs;
  var selectedFilter = 'All'.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments != null) {
      nameJenis.text = arguments['nama'] ?? '';
      kodeJenis.text = arguments['kode'] ?? '';
      pembayaranValue.value = arguments['pembayaran'] ?? '';
      commentJenis.text = arguments['keterangan'] ?? '';
    }
    fetchJenisPembayaran();
    ever(selectedFilter, (_) => filterPembayaranList());
    super.onInit();
  }

  @override
  void onClose() {
    nameJenis.dispose();
    kodeJenis.dispose();
    commentJenis.dispose();
    super.onClose();
  }

  void fetchJenisPembayaran() async {
    try {
      isLoading(true);
      var jenisPembayaran = await _service.fetchJenisPembayaran();
      if (jenisPembayaran.isEmpty) {
        Get.snackbar(
          'Data Error',
          'Gagal menampilkan data karena data kosong',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      } else {
        jenisPembayaranList.value = jenisPembayaran;
        filterPembayaranList();
        // print(
        //     "Fetched Jenis Pembayaran List: ${jenisPembayaranList.map((e) => e.toJson()).toList()}");
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  JenisPembayaran? getJenisPembayaranByNama(String nama) {
    var jenis =
        jenisPembayaranList.firstWhereOrNull((jenis) => jenis.nama == nama);
    // print("Selected Jenis Pembayaran for '$nama': ${jenis?.toJson()}");
    return jenis;
  }

  void filterPembayaranList() {
    if (selectedFilter.value == 'All') {
      filteredPembayaranList.value = jenisPembayaranList;
    } else {
      filteredPembayaranList.value = jenisPembayaranList
          .where((pembayaran) => pembayaran.pembayaran == selectedFilter.value)
          .toList();
    }
  }

  void updateJenisPembayaran(int id, String? id_akun) async {
    isLoading(true);
    try {
      print('Updating jenis pembayaran with ID: $id and id_akun: $id_akun');
      JenisPembayaran jenisPembayaran = JenisPembayaran(
        id: id,
        idAkun: id_akun,
        kode: kodeJenis.text,
        nama: nameJenis.text,
        pembayaran: pembayaranValue.value,
        keterangan: commentJenis.text,
      );

      print(
          'Data being sent for update: ${jsonEncode(jenisPembayaran.toJson())}');
      await _service.updateJenisPembayaran(jenisPembayaran, id_akun);

      Get.snackbar(
        'Success',
        'Jenis Pembayaran updated successfully',
        backgroundColor: AppColors.successColor,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error updating jenis pembayaran: $e');
      Get.snackbar(
        'Error',
        'Failed to update data: $e',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
    fetchJenisPembayaran();
  }

  void createJenisPembayaran(JenisPembayaran jenisPembayaran) async {
    isLoading(true);
    try {
      await _service.createJenisPembayaran(jenisPembayaran);
      print('Jenis Pembayaran created successfully');
      Get.snackbar(
        'Success',
        'Jenis Pembayaran created successfully',
        backgroundColor: AppColors.successColor,
        colorText: Colors.white,
      );
      nameJenis.clear();
      kodeJenis.clear();
      commentJenis.clear();
      pembayaranValue.value;
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
    fetchJenisPembayaran();
  }

  void deleteJenisPembayaran(int id) async {
    isLoading(true);
    try {
      await _service.deleteJenisPembayaran(id);
      Get.snackbar(
        'Success',
        'Jenis Pembayaran deleted successfully',
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
      isLoading(false);
    }
    fetchJenisPembayaran();
  }
}