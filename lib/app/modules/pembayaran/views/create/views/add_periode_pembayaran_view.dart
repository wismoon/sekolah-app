import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/periode_pembayaran_controller.dart';

class AddPeriodePembayaranView extends GetView<PeriodePembayaranController> {
  const AddPeriodePembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddPeriodePembayaranView'),
        centerTitle: true,
      ),
      body:ListView(
          padding: EdgeInsets.all(20),
          children: [
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Name: ${controller.namePeriode.text}');
              },
              child: Text('Submit'),
            ),
          ]
        )
    );
  }
}
