import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class AddJenisPembayaranView extends GetView<JenisPembayaranController> {
  const AddJenisPembayaranView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fieldWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Jenis Pembayaran'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
          SizedBox(
            width: fieldWidth,
            child: TextField(
              controller: controller.nameJenis,
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
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: fieldWidth,
            child: TextField(
              controller: controller.kodeJenis,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                labelText: 'Kode Pembayaran',
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildRadioButton(
                        label: 'REGULAR',
                        value: 'REGULAR',
                        groupValue: controller.pembayaranValue.value,
                        onChanged: (String value) {
                          controller.pembayaranValue.value = value;
                        },
                        width: fieldWidth / 2 - 12), // Adjust width for equal spacing
                    const SizedBox(width: 16),
                    _buildRadioButton(
                        label: 'NON REGULAR',
                        value: 'NON REGULAR',
                        groupValue: controller.pembayaranValue.value,
                        onChanged: (String value) {
                          controller.pembayaranValue.value = value;
                        },
                        width: fieldWidth / 2 - 12), // Adjust width for equal spacing
                  ],
                )),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: fieldWidth,
            child: TextField(
              controller: controller.commentJenis,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 3.0,
                  ),
                ),
                labelText: 'Keterangan',
              ),
              maxLines: 5,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: fieldWidth,
            child: ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      String? emptyField = _validateFields();
                      if (emptyField == null) {
                        JenisPembayaran jenisPembayaran = JenisPembayaran(
                          nama: controller.nameJenis.text,
                          kode: controller.kodeJenis.text,
                          pembayaran: controller.pembayaranValue.value,
                          keterangan: controller.commentJenis.text,
                        );
                        controller.createJenisPembayaran(jenisPembayaran);
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
          ),
        ],
        ));
  }

  String? _validateFields() {
    if (controller.nameJenis.text.isEmpty) return 'Jenis Pembayaran';
    if (controller.kodeJenis.text.isEmpty) return 'Kode Pembayaran';
    if (controller.pembayaranValue.value.isEmpty) return 'Pembayaran Type';
    if (controller.commentJenis.text.isEmpty) return 'Keterangan';
    return null;
  }

  Widget _buildRadioButton({
    required String label,
    required String value,
    required String groupValue,
    required double width,
    required ValueChanged<String> onChanged,
  }) {
    return GestureDetector(
        onTap: () {
          if (groupValue != value) {
            onChanged(value);
          }
        },
        child: Container(
          width: width,
          decoration: BoxDecoration(
            border: Border.all(
              color: groupValue == value ? Colors.blue : Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onChanged(newValue);
                  }
                },
              ),
              Text(label),
            ],
          ),
        ));
  }
}
