import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/biaya_pembayaran_controller.dart';


class AddBiayaPembayaranView extends GetView<BiayaPembayaranController> {
  const AddBiayaPembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddBiayaPembayaranView'),
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
            SizedBox(height: 20),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Jenis Pembayaran',
                ),
                value: controller.selectedJenisPembayaran.value.isEmpty
                    ? null
                    : controller.selectedJenisPembayaran.value,
                items: controller.jenisPembayaranList.map((String jenis) {
                  return DropdownMenuItem<String>(
                    value: jenis,
                    child: Text(jenis),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  controller.selectedJenisPembayaran.value = newValue ?? '';
                },
              ),
            ),
            SizedBox(height: 20),
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
                labelText: 'Program Studi',
              ),
            ),
            SizedBox(height: 20),
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
              child: Text('Submit'),
            ),
          ]
      )
    );
  }
}
