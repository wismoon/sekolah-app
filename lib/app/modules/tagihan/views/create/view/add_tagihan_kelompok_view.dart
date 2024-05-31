import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/tagihan/controllers/tagihan_kelompok_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/biaya_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/periode_pembayaran_controller.dart';

class AddTagihanKelompokView extends GetView<TagihanKelompokController> {
  const AddTagihanKelompokView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final jenisPembayaranController = Get.put(JenisPembayaranController());
    final periodePembayaranController = Get.put(PeriodePembayaranController());
    final biayaPembayaranController = Get.put(BiayaPembayaranController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('AddTagihanKelompokView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              final tahunAngkatanList = controller.students
                  .map((student) => student.tahunAngkatan ?? '')
                  .toSet()
                  .toList();
              print("Available Tahun Angkatan: $tahunAngkatanList");
              
              return DropdownSearch<String>(
                items: tahunAngkatanList,
                itemAsString: (String tahunAngkatan) => tahunAngkatan,
                onChanged: (String? selectedTahunAngkatan) {
                  if (selectedTahunAngkatan != null) {
                    controller.selectedTahunAngkatan.value = selectedTahunAngkatan;
                    print("Selected Tahun Angkatan: $selectedTahunAngkatan");
                  }
                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search Tahun Angkatan',
                    ),
                  ),
                  title: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Tahun Angkatan',
                          style: TextStyle(fontSize: 18.0)),
                    ),
                  ),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Tahun Angkatan',
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
                          }),
                      const SizedBox(width: 16),
                      _buildRadioButton(
                          label: 'Non Semester',
                          value: 'NON REGULAR',
                          groupValue: controller.selectedValue.value,
                          onChanged: (String value) {
                            controller.selectedValue.value = value;
                            controller.selectedJenis.value = '';
                          }),
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
                        controller.createInvoiceBulkPembayaran(
                            controller.selectedTahunAngkatan.value);
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
