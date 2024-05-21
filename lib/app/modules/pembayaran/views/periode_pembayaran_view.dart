import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/periode_pembayaran_controller.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class PeriodePembayaranView extends GetView<PeriodePembayaranController> {
  const PeriodePembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PeriodePembayaranView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Expanded(child: Text("No"))),
              DataColumn(label: Expanded(child: Text("Nama Pembayaran"))),
              DataColumn(label: Expanded(child: Text("Jenis Pembayaran"))),
            ],
            rows: controller.pembayaranList.map((pembayaran) {
              return _buildDataRow(context, pembayaran);
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed(Routes.ADD_Periode_PEMBAYARAN),
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
          child: Text(pembayaran["nama"]!),
        )),
        DataCell(InkWell(
          onTap: () => controller.showBottomSheet(context, pembayaran),
          child: Text(pembayaran["jenis"]!),
        )),
      ],
    );
  }
}
