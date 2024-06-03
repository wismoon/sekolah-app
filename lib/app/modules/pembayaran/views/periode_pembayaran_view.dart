import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
      body:  Column(
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
                      onTap: () => controller.showBottomSheet(
                        context,
                        controller.periodePembayaranList[index],
                      ),
                      onDelete: () => controller.showDeleteConfirmation(
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
}
