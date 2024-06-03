import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
                      onTap: () => controller.showBottomSheet(
                        context,
                        controller.biayaPembayaranList[index],
                      ),
                      onDelete: () => controller.showDeleteConfirmation(
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
}
