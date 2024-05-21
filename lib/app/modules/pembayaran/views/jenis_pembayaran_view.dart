import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class JenisPembayaranView extends GetView<JenisPembayaranController> {
  final JenisPembayaranController controller =
      Get.put(JenisPembayaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('JenisPembayaranView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.pembayaranList.isEmpty) {
                  return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Expanded(child: Text("No"))),
                    DataColumn(label: Expanded(child: Text("Kode"))),
                    DataColumn(label: Expanded(child: Text("Nama Pembayaran"))),
                    DataColumn(label: Expanded(child: Text("Jenis Pembayaran"))),
                  ],
                  rows: controller.pembayaranList.map((pembayaran) {
                    return _buildDataRow(context, pembayaran);
                  }).toList());
                }
                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Expanded(child: Text("No"))),
                    DataColumn(label: Expanded(child: Text("Kode"))),
                    DataColumn(label: Expanded(child: Text("Nama Pembayaran"))),
                    DataColumn(label: Expanded(child: Text("Jenis Pembayaran"))),
                  ],
                  rows: controller.pembayaranList.map((pembayaran) {
                    return _buildDataRow(context, pembayaran);
                  }).toList(),
                );
              },
            ),
          ),
        ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () => Get.toNamed(Routes.ADD_Jenis_PEMBAYARAN),
              label: const Text("add"),
              icon: const Icon(Icons.add)),
        );
  }

  DataRow _buildDataRow(BuildContext context, Map<String, String> pembayaran) {
    return DataRow(
      cells: <DataCell>[
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran["no"]!),
        )),
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran["no"]!),
        )),
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran["no"]!),
        )),
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran["no"]!),
        )),
      ],
    );
  }
}
