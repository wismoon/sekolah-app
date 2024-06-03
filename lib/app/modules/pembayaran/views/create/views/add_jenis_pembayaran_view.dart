import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class AddJenisPembayaranView extends GetView<JenisPembayaranController> {
  const AddJenisPembayaranView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Jenis Pembayaran'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
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
            SizedBox(height: 20),
            TextField(
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
            SizedBox(
              height: 20,
            ),
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
                        }
                      ),
                      const SizedBox(width: 16),
                      _buildRadioButton(
                        label: 'NON REGULAR',
                        value: 'NON REGULAR',
                        groupValue: controller.pembayaranValue.value,
                        onChanged: (String value) {
                            controller.pembayaranValue.value = value;
                        }
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            TextField(
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.isBusy.value
                  ? null
                  : () {
                      JenisPembayaran jenisPembayaran = JenisPembayaran(
                        nama: controller.nameJenis.text,
                        kode: controller.kodeJenis.text,
                        pembayaran: controller
                            .pembayaranValue.value, // REGULAR or NON REGULAR
                        keterangan: controller.commentJenis.text,
                      );
                      controller.createJenisPembayaran(jenisPembayaran);
                      Navigator.pop(context);
                    },
              child: Text(
                      controller.isLoading.isFalse ? "Tambah" : "Loading")
            ),
          ],
        ));
  }

  Widget _buildRadioButton({
    required String label,
    required String value,
    required String groupValue,
    required ValueChanged<String> onChanged,
  }) {
    return GestureDetector(
        onTap: () {
          if (groupValue != value) {
            onChanged(value);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: groupValue == value ? Colors.blue : Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          margin: EdgeInsets.all(4.0),
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
