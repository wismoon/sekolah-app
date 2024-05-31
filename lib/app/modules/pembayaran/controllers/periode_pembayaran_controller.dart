import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/models/periode_pembayaran_model.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
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
        Get.snackbar('Data Error', 'Failed to load data because is Empty');
      } else {
        periodePembayaranList.value = periodePembayaran;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void createPeriodePembayaran(PeriodePembayaran periodePembayaran) async {
    isBusy.value = true;
    try {
      await _service.createPeriodePembayaran(periodePembayaran);
      print('Biaya Pembayaran created successfully');
      Get.snackbar('Success', 'Biaya Pembayaran created successfully');
      namePeriode.clear();
      selectedJenisPeriode.value = '';
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to create data: $e');
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
      Get.snackbar('Success', 'Jenis Pembayaran deleted successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isBusy(false);
    }
    fetchPeriodePembayaran();
  }

  void showBottomSheet(BuildContext context, PeriodePembayaran pembayaran) {
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
                Text('No: ${pembayaran.id}', style: TextStyle(fontSize: 20)),
                Text('Nama Pembayaran: ${pembayaran.nama}',
                    style: TextStyle(fontSize: 20)),
                Text('Periode Pembayaran: ${pembayaran.jenis}',
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
                            Routes.EDIT_Periode_PEMBAYARAN,
                            arguments: {
                              'id': pembayaran.id,
                              // 'id_akun': pembayaran.id_akun,
                              'nama': pembayaran.nama,
                              'jenis': pembayaran.jenis,
                            },
                          );
                        } catch (e) {
                          Get.snackbar('Error', 'Failed to load data: $e');
                        }
                      },
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        deletePeriodePembayaran(pembayaran.id!);
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Set the delete button color to red
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
}
