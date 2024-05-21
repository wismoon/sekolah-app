import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeriodePembayaranController extends GetxController {
  var nameJenis = TextEditingController();
  final TextEditingController namePeriode = TextEditingController();
  final RxString selectedJenisPembayaran = ''.obs;
  final RxList<String> jenisPembayaranList = <String>[].obs;
  final List<Map<String, String>> pembayaranList = [
    {"no": "1", "nama": "SPP", "jenis": "Regular"},
    {
      "no": "2",
      "nama": "SPP",
      "jenis": "Regularrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"
    },
    {"no": "3", "nama": "SPP", "jenis": "Regular"},
  ];

  @override
  void onClose() {
    nameJenis.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchJenisPembayaran();
  }

  void fetchJenisPembayaran() async {
    final dataFromApi = await fetchFromApi();
    jenisPembayaranList.assignAll(dataFromApi);
  }

  Future<List<String>> fetchFromApi() async {
    // Replace this with your actual API call
    await Future.delayed(Duration(seconds: 2));
    return ['Jenis 1', 'Jenis 2', 'Jenis 3']; // Replace with actual data from your API
  }

  void showBottomSheet(BuildContext context, Map<String, String> pembayaran) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This is necessary for custom height
      builder: (context) {
        return FractionallySizedBox(
          heightFactor:
              0.5, // Adjust the height factor to make it half of the screen height
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('No: ${pembayaran["no"]}', style: TextStyle(fontSize: 20)),
                Text('Nama Pembayaran: ${pembayaran["nama"]}',
                    style: TextStyle(fontSize: 20)),
                Text('Jenis Pembayaran: ${pembayaran["jenis"]}',
                    style: TextStyle(fontSize: 20)),
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
                        backgroundColor:
                            Colors.red, // Set the delete button color to red
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
