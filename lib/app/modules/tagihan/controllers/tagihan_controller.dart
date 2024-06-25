import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/core/constant/color.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/models/transaction_model.dart';
import 'package:sekolah_app/app/services/invoice_service.dart';
import 'package:sekolah_app/app/services/payment_service.dart';

class TagihanController extends GetxController {
  var showAdditionalButtons = false.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final InvoiceService _service = InvoiceService();
  var tagihanList = <Invoice>[].obs;
  var filteredTagihanList = <Invoice>[].obs;
  var transactionList = <SiswaTransaction>[].obs;
  var historyList = <Invoice>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;

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
        fetchTransactions();
        for (var invoice in tagihanList) {
          var statusResponse =
              await checkPaymentStatus(invoice.nomor_pembayaran! + '-1');
          invoice.transactionStatus = statusResponse['transaction_status'];
        }
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

  void fetchTransactions() async {
    try {
      isLoading(true);
      var querySnapshot = await firestore.collection('siswa').get();

      for (var doc in querySnapshot.docs) {
        var uid = doc.id;
        var transactionSnapshot = await firestore
            .collection('siswa')
            .doc(uid)
            .collection('transactions')
            .get();

        transactionList.addAll(transactionSnapshot.docs
            .map((doc) => SiswaTransaction.fromDocumentSnapshot(doc))
            .toList());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch transactions: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<Map<String, dynamic>> checkPaymentStatus(String transactionId) async {
    try {
      Map<String, dynamic> statusResponse =
          await PaymentService.getPaymentStatus(transactionId);
      // Get.snackbar('Payment Status', 'Status: ${statusResponse['transaction_status']}');
      return statusResponse;
    } catch (e) {
      // Get.snackbar('Error', 'Failed to get payment status: $e');
      return {};
    }
  }

  void searchInvoice(String query) {
    if (query.isEmpty) {
      filteredTagihanList.assignAll(tagihanList);
    } else {
      filteredTagihanList.assignAll(
        tagihanList.where((invoice) =>
          (invoice.nama != null && invoice.nama!.toLowerCase().contains(query.toLowerCase())) ||
          (invoice.transactionStatus != null && invoice.transactionStatus!.toLowerCase().contains(query.toLowerCase())) ||
          (invoice.nama_pembayaran != null && invoice.nama_pembayaran!.toLowerCase().contains(query.toLowerCase())) ||
          (invoice.nama_pembayaran != null && invoice.nama_pembayaran!.toLowerCase().contains(query.toLowerCase())) ||
          (invoice.jenis_pembayaran != null && invoice.jenis_pembayaran!.toLowerCase().contains(query.toLowerCase()))
        )
      );
    }
  }
  
  // Method to toggle the visibility
  void toggleButtons() =>
      showAdditionalButtons.value = !showAdditionalButtons.value;
  void hideButtons() => showAdditionalButtons.value = false;
}
