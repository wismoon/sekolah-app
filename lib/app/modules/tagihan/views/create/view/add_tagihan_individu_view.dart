import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sekolah_app/app/models/student_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/biaya_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/periode_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/tagihan/controllers/tagihan_individu_controller.dart';

class AddTagihanIndividuView extends GetView<TagihanIndividuController> {
  const AddTagihanIndividuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final jenisPembayaranController = Get.put(JenisPembayaranController());
    final periodePembayaranController = Get.put(PeriodePembayaranController());
    final biayaPembayaranController = Get.put(BiayaPembayaranController());
    double fieldWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Tagihan Individu'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return DropdownSearch<Student>(
                items: controller.students,
                itemAsString: (Student student) => student.nama!,
                onChanged: (Student? selectedStudent) {
                  controller.selectedStudent.value = selectedStudent;
                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search Student',
                    ),
                  ),
                  title: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Students', style: TextStyle(fontSize: 18.0)),
                    ),
                  ),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Student',
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Center(
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildRadioButton(
                          label: 'Semester',
                          value: 'REGULAR',
                          groupValue: controller.selectedValue.value,
                          onChanged: (String value) {
                            controller.selectedValue.value = value;
                            controller.selectedJenis.value = '';
                          },
                          width: fieldWidth / 2 - 12),
                      const SizedBox(width: 16),
                      _buildRadioButton(
                          label: 'Non Semester',
                          value: 'NON REGULAR',
                          groupValue: controller.selectedValue.value,
                          onChanged: (String value) {
                            controller.selectedValue.value = value;
                            controller.selectedJenis.value = '';
                          },width: fieldWidth / 2 - 12),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (jenisPembayaranController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              final filteredJenisPembayaran = jenisPembayaranController
                  .jenisPembayaranList
                  .where((jenis) =>
                      jenis.pembayaran == controller.selectedValue.value)
                  .toList();

              if (filteredJenisPembayaran.every(
                  (jenis) => jenis.nama != controller.selectedJenis.value)) {
                controller.selectedJenis.value = '';
              }

              return DropdownButtonFormField<String>(
                value: controller.selectedJenis.value.isEmpty
                    ? null
                    : controller.selectedJenis.value,
                items: filteredJenisPembayaran.map((jenis) {
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
            Obx(() {
              if (jenisPembayaranController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<String>(
                value: controller.selectedPeriode.value.isEmpty
                    ? null
                    : controller.selectedPeriode.value,
                items: periodePembayaranController.periodePembayaranList
                    .map((periode) {
                  return DropdownMenuItem<String>(
                    value: periode.nama,
                    child: Text(periode.nama!),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedPeriode(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Periode Pembayaran',
                ),
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              if (jenisPembayaranController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<String>(
                value: controller.selectedBiaya.value.isEmpty
                    ? null
                    : controller.selectedBiaya.value,
                items:
                    biayaPembayaranController.biayaPembayaranList.map((biaya) {
                  return DropdownMenuItem<String>(
                    value: biaya.nama,
                    child: Text(biaya.nama!),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedBiaya(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Biaya Pembayaran',
                ),
              );
            }),
            SizedBox(height: 20),
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
                onPressed: controller.isLoading.value
                    ? () {
                        controller.createInvoicePembayaran();
                        Navigator.pop(context);
                      }
                    : null,
                child:
                    Text(controller.isLoading.isFalse ? "Loading" : "Tambah")),
          ],
        ));
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
