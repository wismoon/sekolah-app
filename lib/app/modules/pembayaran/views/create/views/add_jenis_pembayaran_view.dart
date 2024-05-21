import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class AddJenisPembayaranView extends GetView<JenisPembayaranController> {
  const AddJenisPembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AddJenisPembayaranView'),
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
                labelText: 'Kode',
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
                        groupValue: controller.selectedValue.value,
                        onChanged: (String value) =>
                            controller.setSelected(value),
                      ),
                      const SizedBox(width: 16),
                      _buildRadioButton(
                        label: 'NON REGULAR',
                        value: 'NON REGULAR',
                        groupValue: controller.selectedValue.value,
                        onChanged: (String value) =>
                            controller.setSelected(value),
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
                labelText: 'Comment',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.isBusy.value ? null : () {
                print('Name: ${controller.nameJenis.text}');
                print('Kode: ${controller.kodeJenis.text}');
                print('Selected: ${controller.selectedValue.value}');
                print('Comment: ${controller.commentJenis.text}');
                controller.createJenisPembayaran();
              },
              child: controller.isBusy.value 
                ? CircularProgressIndicator()
                : Text('Submit'),
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
        onTap: () => onChanged(value),
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
