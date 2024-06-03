import 'package:get/get.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/services/invoice_service.dart';

class TagihanController extends GetxController {
  var showAdditionalButtons = false.obs;

  final InvoiceService _service = InvoiceService();
  var tagihanList = <Invoice>[].obs;

  var isBusy = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchInvoicePembayaran();
    super.onInit();
  }

  void fetchInvoicePembayaran() async {
    try {
      isLoading(true);
      var invoicePembayaran = await _service.fetchInvoicePembayaran();
      if (invoicePembayaran.isEmpty) {
        Get.snackbar('Data Error', 'Failed to load data because is Empty');
      } else {
        tagihanList.value = invoicePembayaran;
        print(
            "Fetched Jenis Pembayaran List: ${tagihanList.map((e) => e.toJson()).toList()}");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  // Method to toggle the visibility
  void toggleButtons() {
    showAdditionalButtons.value = !showAdditionalButtons.value;
  }
  
  void hideButtons() {
    showAdditionalButtons.value = false;
  }
}
