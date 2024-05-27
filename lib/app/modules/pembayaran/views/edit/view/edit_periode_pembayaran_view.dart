import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/periode_pembayaran_controller.dart';

class EditPeriodePembayaranView extends GetView<PeriodePembayaranController> {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final jenisPembayaranController = Get.put(JenisPembayaranController());

    // final jenisArgument = arguments['jenis'];
    controller.selectedJenis.value = arguments['jenis'].join(', ');
    controller.namePeriode.text = arguments['nama'];
    // controller.selectedJenis.value = arguments['jenis'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('EditPeriodePembayaranView'),
          centerTitle: true,
        ),
        body: ListView(padding: EdgeInsets.all(20), children: [
          TextField(
            controller: controller.namePeriode,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              labelText: 'Nama Pembayaran',
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            if (jenisPembayaranController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            return DropdownButtonFormField<String>(
              value: controller.selectedJenis.value.isEmpty
                  ? null
                  : controller.selectedJenis.value,
              items: jenisPembayaranController.jenisPembayaranList.map((jenis) {
                return DropdownMenuItem<String>(
                  value: jenis.nama,
                  child: Text(jenis.nama!),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedJenis(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                labelText: 'Jenis Pembayaran',
              ),
            );
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Name: ${controller.namePeriode.text}');
            },
            child: Text(controller.isLoading.isFalse ? "Update" : "Loading"),
          ),
        ]));
  }
}
