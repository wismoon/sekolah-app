import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/models/transaction_model.dart';
import 'package:sekolah_app/app/services/invoice_service.dart';

class TagihanController extends GetxController {
  var showAdditionalButtons = false.obs;
  final InvoiceService _service = InvoiceService();
  var tagihanList = <Invoice>[].obs;
  var transactionList = <SiswaTransaction>[].obs;
  var historyList = <Invoice>[].obs;
  var isLoading = false.obs;
  var selectedIndex = 0.obs;
  PageController pageController = PageController();

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
        Get.snackbar(
          'Data Error',
          'Failed to load data because is Empty',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      } else {
        tagihanList.value = invoicePembayaran;
        print(
            "Fetched Jenis Pembayaran List: ${tagihanList.map((e) => e.toJson()).toList()}");
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  // Method to toggle the visibility
  void toggleButtons() =>
      showAdditionalButtons.value = !showAdditionalButtons.value;
  void hideButtons() => showAdditionalButtons.value = false;

  void onBottomNavTap(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }
}
