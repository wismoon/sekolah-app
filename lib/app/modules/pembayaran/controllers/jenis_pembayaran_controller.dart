import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class JenisPembayaranController extends GetxController {
  var selectedValue = 'REGULAR'.obs;
  var nameJenis = TextEditingController();
  var kodeJenis = TextEditingController();
  var commentJenis = TextEditingController();

  // var pembayaranList = <JenisPembayaran>[].obs;
  final List<Map<String, String>> pembayaranList = [
    {"no": "1", "kode": "12", "nama": "SPP", "jenis": "Regular"},
    {"no": "2", "kode": "13", "nama": "SPP", "jenis": "Regularrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"},
    {"no": "3", "kode": "14", "nama": "SPP", "jenis": "Regular"},
  ];

  var isBusy = false.obs;
  var isLoading = false.obs;

  void setSelected(String value) {
    selectedValue.value = value;
  }

  @override
  void onClose() {
    nameJenis.dispose();
    kodeJenis.dispose();
    commentJenis.dispose();
    super.onClose();
  }
  void onInit() {
    fetchPembayaranList();
    super.onInit();
  }

  Future<void> createJenisPembayaran() async {
    isBusy.value = true;
    final url = Uri.parse('http://192.168.1.11:3350/api/transaksi/jenisPembayaran');
    final body = jsonEncode({
      'nama': nameJenis.text,
      'kode': kodeJenis.text,
      'pembayaran': selectedValue.value,
      'keterangan': commentJenis.text,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer client-q6WtLyxA8xNsZls9',
          },
        body: body,
      );

      isBusy.value = false;

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Data has been created successfully');
        nameJenis.clear();
        kodeJenis.clear();
        commentJenis.clear();
        selectedValue.value = 'REGULAR';
        // Call method to refresh data if needed
        // await refreshDataPembayaran();
      } else {
        Get.snackbar('Error', 'Failed to create data');
      }
    } catch (e) {
      isBusy.value = false;
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
  
  void fetchPembayaranList() async {
    isLoading.value = true;

    final url = Uri.parse('http://192.168.1.11:3350/api/transaksi/listJenisPembayaran');

     try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer client-q6WtLyxA8xNsZls9',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) {
          Get.snackbar('Data Error', 'Failed to load data because is Empty');
        }else {
          // pembayaranList.value = List<JenisPembayaran>.from(data.map((item) => JenisPembayaran.fromJson(item)));
        }
      } else {
        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showBottomSheet(BuildContext context, Map<String, String> pembayaran) {
    showModalBottomSheet(
      context: context,
     isScrollControlled: true, // This is necessary for custom height
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5, // Adjust the height factor to make it half of the screen height
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text('No: ${pembayaran.id}', style: TextStyle(fontSize: 20)),
                // Text('Kode: ${pembayaran.kode}', style: TextStyle(fontSize: 20)),
                // Text('Nama Pembayaran: ${pembayaran.nama}', style: TextStyle(fontSize: 20)),
                // Text('Jenis Pembayaran: ${pembayaran.pembayaran}', style: TextStyle(fontSize: 20)),
                Text('No: ${pembayaran["no"]}', style: TextStyle(fontSize: 20)),
                Text('Kode: ${pembayaran["kode"]}', style: TextStyle(fontSize: 20)),
                Text('Nama Pembayaran: ${pembayaran["nama"]}', style: TextStyle(fontSize: 20)),
                Text('Jenis Pembayaran: ${pembayaran["jenis"]}', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Spacer(), // Push the buttons to the bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle edit action here
                        Navigator.pop(context);
                        
                      },
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle delete action here
                        Navigator.pop(context);
                        // Add your delete logic here
                      },
                      child: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Set the delete button color to red
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
