import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class EditJenisPembayaranView extends GetView<JenisPembayaranController> {
  @override
  Widget build(BuildContext context) {
    double fieldWidth = MediaQuery.of(context).size.width - 40;
    final arguments = Get.arguments;

    controller.nameJenis.text = arguments['nama'];
    controller.nameJenis.text = arguments['nama'];
    controller.kodeJenis.text = arguments['kode'];
    controller.pembayaranValue.value = arguments['pembayaran'];
    controller.commentJenis.text = arguments['keterangan'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Jenis Pembayaran'),
          centerTitle: true,
        ),
        body: Obx(() => ListView(
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
                              },
                              width: fieldWidth / 2 - 12),
                          const SizedBox(width: 16),
                          _buildRadioButton(
                            label: 'NON REGULAR',
                            value: 'NON REGULAR',
                            groupValue: controller.pembayaranValue.value,
                            onChanged: (String value) {
                              controller.pembayaranValue.value = value;
                            },
                            width: fieldWidth / 2 - 12,
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                    labelText: 'Keterangan',
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      try {
                        controller.updateJenisPembayaran(
                            arguments['id']); // Pass the ID to the update method
                        Get.back();
                      } catch (e) {
                        Get.snackbar(
                            'Error', 'Failed to update jenis pembayaran: $e');
                      }
                    },
                    child: Text(
                        controller.isLoading.isFalse ? "Update" : "Loading")),
              ],
            )));
  }
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
