import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/biaya_pembayaran_controller.dart';
import 'package:sekolah_app/app/models/biayapembayaran_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class AddBiayaPembayaranView extends GetView<BiayaPembayaranController> {
  const AddBiayaPembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final jenisPembayaranController = Get.put(JenisPembayaranController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Biaya Pembayaran'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(children: [
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
            Obx(() {
              if (jenisPembayaranController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<String>(
                value: controller.selectedJenis.value.isEmpty
                    ? null
                    : controller.selectedJenis.value,
                items:
                    jenisPembayaranController.jenisPembayaranList.map((jenis) {
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
              controller: controller.nameSemester,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                labelText: 'Semester',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.nameTahunAngkatan,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                labelText: 'Tahun Angkatan',
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
              onPressed: controller.isBusy.value
                  ? null
                  : () {
                      String? emptyField = _validateFields();
                      if (emptyField == null) {
                        Biayapembayaran biayapembayaran = Biayapembayaran(
                          nama: controller.nameBiaya.text,
                          jenis: controller.selectedJenis.value,
                          programStudi: controller.nameStudi.text,
                          semester: controller.nameSemester.text,
                          tahunAngkatan: controller.nameTahunAngkatan.text,
                          biaya: controller.biaya.text,
                        );
                        controller.createBiayaPembayaran(biayapembayaran);
                        Navigator.pop(context);
                      } else {
                        Get.snackbar(
                          'Error',
                          '$emptyField cannot be empty',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
              child: Text(controller.isLoading.isFalse ? "Tambah" : "Loading"),
            ),
          ]),
        ));
  }

  String? _validateFields() {
    if (controller.nameBiaya.text.isEmpty) return 'Nama Biaya Pembayaran';
    if (controller.selectedJenis.value.isEmpty) return 'Jenis Pembayaran';
    if (controller.nameStudi.text.isEmpty) return 'Program Studi';
    if (controller.nameSemester.text.isEmpty) return 'Semester';
    if (controller.nameTahunAngkatan.text.isEmpty) return 'Tahun Angkatan';
    if (controller.biaya.text.isEmpty) return 'Biaya Pembayaran';
    return null;
  }
}
