import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/biaya_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';


class EditBiayaPembayaranView extends GetView<BiayaPembayaranController> {
  
  @override
  Widget build(BuildContext context) {

    final arguments = Get.arguments;
    final jenisPembayaranController = Get.put(JenisPembayaranController());
    
    controller.nameBiaya.text = arguments['nama'];
    controller.selectedJenis.value = arguments['jenis'];
    controller.nameStudi.text = arguments['programStudi'];
    controller.biaya.text = arguments['biaya']; 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Biaya Pembayaran'),
        centerTitle: true,
      ),
      body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.nameBiaya,
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
            SizedBox(height: 20),
            TextField(
              controller: controller.nameStudi,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                labelText: 'Program Studi',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.biaya,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                labelText: 'Biaya Pembyaran',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // print('Name: ${controller.nameJenis.text}');
                // print('Kode: ${controller.kodeJenis.text}');
                // print('Selected: ${controller.selectedValue.value}');
                // print('Comment: ${controller.commentJenis.text}');
              },
              child: Text(
                      controller.isLoading.isFalse ? "Update" : "Loading")
            ),
          ]
      )
    );
  }
}
