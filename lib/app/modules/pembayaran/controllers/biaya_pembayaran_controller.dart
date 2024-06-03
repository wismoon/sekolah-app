import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
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
        Get.snackbar('Data Error', 'Failed to load data because is Empty');
      } else {
        biayaPembayaranList.value = biayaPembayaran;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void createBiayaPembayaran(Biayapembayaran biayaPembayaran) async {
    isBusy.value = true;
    try {
      await _service.createBiayaPembayaran(biayaPembayaran);
      print('Biaya Pembayaran created successfully');
      Get.snackbar('Success', 'Biaya Pembayaran created successfully');
      nameBiaya.clear();
      nameStudi.clear();
      nameSemester.clear();
      nameTahunAngkatan.clear();
      biaya.clear();
      selectedJenis.value;
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isBusy.value = false;
    }
    fetchBiayaPembayaran();
  }

  void deleteBiayaPembayaran(int id) async {
    isBusy(true);
    try {
      await _service.deleteBiayaPembayaran(id);
      Get.snackbar('Success', 'Biaya Pembayaran deleted successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isBusy(false);
    }
    fetchBiayaPembayaran();
  }

  void showBottomSheet(BuildContext context, Biayapembayaran pembayaran) {
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
                Text('No: ${pembayaran.id.toString()}', style: TextStyle(fontSize: 20)),
                Text('Nama Pembayaran: ${pembayaran.nama}',
                    style: TextStyle(fontSize: 20)),
                Text('Jenis Pembayaran: ${pembayaran.jenis}',
                    style: TextStyle(fontSize: 20)),
                Text('Biaya Pembayaran: ${pembayaran.biaya}',
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
                            Routes.EDIT_Biaya_PEMBAYARAN,
                            arguments: {
                              'id': pembayaran.id,
                              // 'id_akun': pembayaran.id_akun,
                              'nama': pembayaran.nama,
                              'jenis': pembayaran.jenis,
                              'programStudi': pembayaran.programStudi,
                              'semester': pembayaran.semester,
                              'tahunAngkatan': pembayaran.tahunAngkatan,
                              'biaya': pembayaran.biaya
                            },
                          );
                        } catch (e) {
                          Get.snackbar('Error', 'Failed to load data: $e');
                        }
                      },
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: ()  {
                        Navigator.pop(context);
                        showDeleteConfirmation(context, pembayaran);
                      },
                      child: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.red, 
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

  
  void showDeleteConfirmation(BuildContext context, Biayapembayaran pembayaran) {
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
                deleteBiayaPembayaran(pembayaran.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
