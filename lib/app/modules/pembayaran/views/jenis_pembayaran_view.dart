import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/core/component/pembayaran_card.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class JenisPembayaranView extends GetView<JenisPembayaranController> {
  // final JenisPembayaranController controller =
  //     Get.put(JenisPembayaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Pembayaran'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return DropdownButton<String>(
                value: controller.selectedFilter.value,
                onChanged: (String? newValue) {
                  controller.selectedFilter.value = newValue!;
                  controller.filterPembayaranList(); // Trigger filtering
                },
                items: <String>['All', 'REGULAR', 'NON REGULAR']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: controller.filteredPembayaranList.length,
                  itemBuilder: (context, index) {
                    return PembayaranCard(
                      pembayaran: controller.filteredPembayaranList[index],
                      onTap: () => _showBottomSheet(
                        context,
                        controller.filteredPembayaranList[index],
                      ),
                      onDelete: () => _showDeleteConfirmation(
                        context,
                        controller.filteredPembayaranList[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.ADD_Jenis_PEMBAYARAN),
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showBottomSheet(
      BuildContext context, JenisPembayaran pembayaran) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 5,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(height: 20,),
                _buildDetailRow("Kode Pembayaran", pembayaran.kode!),
                _buildDetailRow("Nama Pembayaran", pembayaran.nama!),
                _buildDetailRow("Jenis Pembayaran", pembayaran.pembayaran!),
                Spacer(),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
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
                      ),
                      const SizedBox(height: 10), // Add space between buttons
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deleteColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _showDeleteConfirmation(context, pembayaran);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label :",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, JenisPembayaran pembayaran) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content:
              Text('Apakah anda yakin ingin menghapus ${pembayaran.nama}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Hapus',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deleteColor,
              ),
              onPressed: () {
                controller.deleteJenisPembayaran(pembayaran.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
