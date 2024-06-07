import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
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

  var isBusy = false.obs;
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
          'Failed to load data because it is empty',
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
    try {
      isBusy(true);
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
      isBusy(false);
    }
    fetchJenisPembayaran();
  }

  void createJenisPembayaran(JenisPembayaran jenisPembayaran) async {
    isBusy.value = true;
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
      isBusy.value = false;
    }
    fetchJenisPembayaran();
  }

  void deleteJenisPembayaran(int id) async {
    isBusy(true);
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
      isBusy(false);
    }
    fetchJenisPembayaran();
  }

  void showBottomSheet(BuildContext context, JenisPembayaran pembayaran) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This is necessary for custom height
      builder: (context) {
        return FractionallySizedBox(
          heightFactor:
              0.5, // Adjust the height factor to make it half of the screen height
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Kode: ${pembayaran.kode}',
                    style: TextStyle(fontSize: 20)),
                Text('Nama Pembayaran: ${pembayaran.nama}',
                    style: TextStyle(fontSize: 20)),
                Text('Jenis Pembayaran: ${pembayaran.pembayaran}',
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Spacer(), // Push the buttons to the bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        try {
                          Navigator.pop(context);
                          Get.toNamed(
                            Routes.EDIT_Jenis_PEMBAYARAN,
                            arguments: {
                              'id': pembayaran.id,
                              'id_akun': pembayaran.idAkun,
                              'kode': pembayaran.kode,
                              'nama': pembayaran.nama,
                              'pembayaran': pembayaran.pembayaran,
                              'keterangan': pembayaran.keterangan
                            },
                          );
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            e.toString(),
                            backgroundColor: AppColors.errorColor,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors
                            .deleteColor, // Use the custom delete color
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showDeleteConfirmation(context, pembayaran);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDeleteConfirmation(
      BuildContext context, JenisPembayaran pembayaran) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${pembayaran.nama}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteJenisPembayaran(pembayaran.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
