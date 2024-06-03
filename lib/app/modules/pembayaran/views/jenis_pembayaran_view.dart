import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';
import '../../../core/component/pembayaran_card.dart';

class JenisPembayaranView extends GetView<JenisPembayaranController> {
  final JenisPembayaranController controller =
      Get.put(JenisPembayaranController());

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
                items: <String>['All', 'REGULAR', 'NON-REGULAR']
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
                      onTap: () => controller.showBottomSheet(
                        context,
                        controller.filteredPembayaranList[index],
                      ),
                      onDelete: () => controller.showDeleteConfirmation(
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
}
