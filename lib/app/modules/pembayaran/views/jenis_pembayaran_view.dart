import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class JenisPembayaranView extends GetView<JenisPembayaranController> {
  final JenisPembayaranController controller =
      Get.put(JenisPembayaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Jenis Pembayaran View'),
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
                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Expanded(child: Text("No"))),
                    DataColumn(label: Expanded(child: Text("Kode"))),
                    DataColumn(label: Expanded(child: Text("Nama Pembayaran"))),
                    DataColumn(label: Expanded(child: Text("Jenis Pembayaran"))),
                  ],
                  rows: controller.jenisPembayaranList.map((pembayaran) {
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

  DataRow _buildDataRow(BuildContext context, JenisPembayaran pembayaran) {
    return DataRow(
      cells: <DataCell>[
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran.id.toString()),
        )),
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran.kode ?? ''),
        )),
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran.nama ?? ''),
        )),
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran.pembayaran ?? ''),
        )),
      ],
    );
  }
}
