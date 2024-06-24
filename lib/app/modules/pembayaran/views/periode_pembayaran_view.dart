import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/periode_pembayaran_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/periode_pembayaran_controller.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import '../../../core/component/periode_pembayaran_card.dart';

class PeriodePembayaranView extends GetView<PeriodePembayaranController> {
  final PeriodePembayaranController controller =
      Get.put(PeriodePembayaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periode Pembayaran'),
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
                  itemCount: controller.periodePembayaranList.length,
                  itemBuilder: (context, index) {
                    return PeriodePembayaranCard(
                      pembayaran: controller.periodePembayaranList[index],
                      onTap: () => _showBottomSheet(
                        context,
                        controller.periodePembayaranList[index],
                      ),
                      onDelete: () => _showDeleteConfirmation(
                        context,
                        controller.periodePembayaranList[index],
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
        onPressed: () => Get.toNamed(Routes.ADD_Periode_PEMBAYARAN),
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, PeriodePembayaran pembayaran) {
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
                const SizedBox(
                  height: 20,
                ),
                _buildDetailRow('Nama Pembayaran', pembayaran.nama ?? ''),
                _buildDetailRow('Periode Pembayaran', pembayaran.jenis ?? ''),
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

  Widget _buildDetailRow(String label, dynamic value) {
    String displayValue;
    if (value is List<String>) {
      // Join the list into a single string with comma and space
      displayValue = value.join(', ');
    } else {
      // Otherwise, use value directly as string
      displayValue = value.toString();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label :",
            style: TextStyle(fontSize: 20),
          ),
          Flexible(
            child: Text(
              displayValue,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, PeriodePembayaran pembayaran) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${pembayaran.nama}?'),
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
                controller.deletePeriodePembayaran(pembayaran.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
