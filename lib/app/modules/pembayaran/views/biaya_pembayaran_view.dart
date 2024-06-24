import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/biayapembayaran_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/biaya_pembayaran_controller.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import '../../../core/component/biaya_pembayaran_card.dart';

class BiayaPembayaranView extends GetView<BiayaPembayaranController> {
  final BiayaPembayaranController controller =
      Get.put(BiayaPembayaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biaya Pembayaran'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: controller.biayaPembayaranList.length,
                  itemBuilder: (context, index) {
                    return BiayaPembayaranCard(
                      pembayaran: controller.biayaPembayaranList[index],
                      onTap: () => _showBottomSheet(
                        context,
                        controller.biayaPembayaranList[index],
                      ),
                      onDelete: () => _showDeleteConfirmation(
                        context,
                        controller.biayaPembayaranList[index],
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
        onPressed: () => Get.toNamed(Routes.ADD_Biaya_PEMBAYARAN),
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Biayapembayaran pembayaran) {
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
                _buildDetailRow('Nama Pembayaran', pembayaran.nama!),
                _buildDetailRow('Jenis Pembayaran', pembayaran.jenis!),
                _buildDetailRow('Biaya Pembayaran', _formatCurrency(pembayaran.biaya!)),
                Spacer(), // Push the buttons to the bottom
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deleteColor,
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
      BuildContext context, Biayapembayaran pembayaran) {
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
                controller.deleteBiayaPembayaran(pembayaran.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _formatCurrency(String amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatter.format(int.parse(amount));
  }
}
