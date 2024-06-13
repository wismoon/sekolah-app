import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/models/periode_pembayaran_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/periode_pembayaran_controller.dart';

class AddPeriodePembayaranView extends GetView<PeriodePembayaranController> {
  const AddPeriodePembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final jenisPembayaranController = Get.put(JenisPembayaranController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Periode Pembayaran'),
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
              value: controller.selectedJenisPeriode.value.isEmpty
                  ? null
                  : controller.selectedJenisPeriode.value,
              items: jenisPembayaranController.jenisPembayaranList.map((jenis) {
                return DropdownMenuItem<String>(
                  value: jenis.nama,
                  child: Text(jenis.nama!),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedJenisPeriode(value);
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
            onPressed: controller.isBusy.value
                ? null
                : () {
                    String? emptyField = _validateFields();
                    if (emptyField == null) {
                      PeriodePembayaran periodePembayaran = PeriodePembayaran(
                        nama: controller.namePeriode.text,
                        jenis: [controller.selectedJenisPeriode.value],
                      );
                      controller.createPeriodePembayaran(periodePembayaran);
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
        ]));
  }

   String? _validateFields() {
    if (controller.namePeriode.text.isEmpty) return 'Periode Pembayaran';
    if (controller.selectedJenisPeriode.value.isEmpty) return 'Jenis Pembayaran';
    return null;
  }
}
