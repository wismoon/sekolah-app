import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/models/transaction_model.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import 'package:sekolah_app/app/services/invoice_service.dart';
import 'package:sekolah_app/app/services/payment_service.dart';

class StudentHomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final InvoiceService _service = InvoiceService();
  var invoiceList = <Invoice>[].obs;
  var transactionList = <SiswaTransaction>[].obs;
  var isLoading = false.obs;
  var userNim = ''.obs;
  var selectedIndex = 0.obs;
  PageController pageController = PageController();

  @override
  void onInit() {
    fetchUserNim();
    super.onInit();
  }

  void fetchUserNim() async {
    try {
      isLoading(true);
      String uid = auth.currentUser?.uid ?? '';
      if (uid.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore.collection('siswa').doc(uid).get();
        if (userDoc.exists) {
          userNim.value = userDoc['nim'];
          fetchStudentInvoice(userNim.value);
          fetchTransactions(uid);
        } else {
          Get.snackbar('Error', 'User data not found');
        }
      } else {
        Get.snackbar('Error', 'User is not logged in');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchStudentInvoice(String nim) async {
    try {
      isLoading(true);
      var studentInvoices = await _service.fetchStudentInvoice(nim);
      if (studentInvoices.isEmpty) {
        Get.snackbar('Data Error', 'Failed to load data because it is empty');
      } else {
        invoiceList.value = studentInvoices;

        // Check the payment status for each invoice and update the status
        for (var invoice in invoiceList) {
          var statusResponse = await checkPaymentStatus(invoice.nomor_pembayaran! + '-1');
          invoice.transactionStatus = statusResponse['transaction_status'];
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchTransactions(String uid) async {
    try {
      isLoading(true);
      var transactionSnapshot = await firestore
          .collection('siswa')
          .doc(uid)
          .collection('transactions')
          .get();

      transactionList.value = transactionSnapshot.docs
          .map((doc) => SiswaTransaction.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch transactions: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<Map<String, dynamic>> createPayment(String nomorPembayaran) async {
    isLoading.value = true;
    try {
      final response = await PaymentService.createPayment(nomorPembayaran);
      final transactionStatus = await checkPaymentStatus(nomorPembayaran + '-1');
      await storeTransactionDetails(transactionStatus);

      return response;
    } catch (e) {
      Get.snackbar('Error', 'Failed to create payment: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> checkPaymentStatus(String transactionId) async {
    try {
      Map<String, dynamic> statusResponse = await PaymentService.getPaymentStatus(transactionId);

      await storeTransactionDetails(statusResponse['data']);

      // Get.snackbar('Payment Status', 'Status: ${statusResponse['transaction_status']}');
      return statusResponse;
    } catch (e) {
      // Get.snackbar('Error', 'Failed to get payment status: $e');
      return {};
    }
  }

  Future<void> storeTransactionDetails(Map<String, dynamic> transactionData) async {
    try {
      String uid = auth.currentUser?.uid ?? '';
      if (uid.isNotEmpty) {
        String transactionId = transactionData['transaction_id'];

        // Check if a transaction with this ID already exists
        var existingTransaction = await firestore
            .collection('siswa')
            .doc(uid)
            .collection('transactions')
            .where('transaction_id', isEqualTo: transactionId)
            .get();

        if (existingTransaction.docs.isEmpty) {
          // Extract specific fields from transactionData
          Map<String, dynamic> dataToStore = {
            'transaction_id': transactionId,
            'transaction_status': transactionData['transaction_status'],
            'transaction_time': transactionData['transaction_time'],
            'gross_amount': transactionData['gross_amount'],
            'currency': transactionData['currency'],
            'order_id': transactionData['order_id'],
            'payment_type': transactionData['payment_type'],
            'status_message': transactionData['status_message'],
            'merchant_id': transactionData['merchant_id'],
            'settlement_time': transactionData['settlement_time'] ?? '',
            'expiry_time': transactionData['expiry_time'] ?? '',
            'custom_field1': transactionData['custom_field1'],
            'custom_field2': transactionData['custom_field2'],
            'custom_field3': transactionData['custom_field3'],
          };

          // Store data in Firestore under the user's transactions subcollection
          await firestore
              .collection('siswa')
              .doc(uid)
              .collection('transactions')
              .add(dataToStore);

          // Show success message using GetX's snackbar
          Get.snackbar('Success', 'Transaction details stored in Firestore');
        } 
      } else {
        // Show error message if user is not logged in
        Get.snackbar('Error', 'User is not logged in');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to store transaction details: $e');
    }
  }

  // void fetchUserData() async {
  //   try {
  //     isLoading(true); // Show loading indicator
  //     String uid = auth.currentUser?.uid ?? '';
  //     if (uid.isNotEmpty) {
  //       DocumentSnapshot userDoc =
  //           await firestore.collection('siswa').doc(uid).get();
  //       if (userDoc.exists) {
  //         userNim.value = userDoc['nim'];
  //         print("Fetching user data");
  //         await fetchStudentData(userNim.value, uid);
  //       } else {
  //         Get.snackbar('Error', 'User data not found');
  //       }
  //     } else {
  //       Get.snackbar('Error', 'User is not logged in');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch user data: $e');
  //   } finally {
  //     isLoading(false); // Hide loading indicator
  //   }
  // }

  // Future<void> fetchStudentData(String nim, String uid) async {
  //   print("Fetching student data for NIM: $nim");
  //   try {
  //     var studentInvoices = await _service.fetchStudentInvoice(nim);
  //     var transactionSnapshot = await firestore
  //         .collection('siswa')
  //         .doc(uid)
  //         .collection('transactions')
  //         .get();
  //     var transactions = transactionSnapshot.docs
  //         .map((doc) => SiswaTransaction.fromDocumentSnapshot(doc))
  //         .toList();

  //     print('Fetched ${invoiceList.length} invoices');
  //     print('Fetched ${transactionList.length} transactions');

  //     if (studentInvoices.isEmpty) {
  //       Get.snackbar('Data Error', 'Failed to load data because it is Empty');
  //     } else {
  //       invoiceList.value = studentInvoices;
  //     }
  //     transactionList.value = transactions;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch student data: $e');
  //   }
  // }

  // Future<Map<String, dynamic>> createPayment(String nomorPembayaran) async {
  //   isLoading.value = true;
  //   try {
  //     print('Creating payment for: $nomorPembayaran');
  //     final response = await PaymentService.createPayment(nomorPembayaran);
  //     print('Payment created, response: $response');
  //     final transactionStatus =
  //         await checkPaymentStatus(nomorPembayaran + '-1');
  //     await storeTransactionDetails(transactionStatus['data']);
  //     return response;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to create payment: $e');
  //     rethrow;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<Map<String, dynamic>> checkPaymentStatus(String transactionId) async {
  //   try {
  //     print('Checking payment status for: $transactionId');
  //     Map<String, dynamic> statusResponse =
  //         await PaymentService.getPaymentStatus(transactionId);
  //     print('Payment status response: $statusResponse');
  //     if (statusResponse.containsKey('data')) {
  //       await storeTransactionDetails(statusResponse['data']);
  //     } else {
  //       Get.snackbar('Error', 'Invalid payment status response');
  //     }
  //     return statusResponse;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to get payment status: $e');
  //     return {};
  //   }
  // }

  // Future<void> storeTransactionDetails(
  //     Map<String, dynamic> transactionData) async {
  //   try {
  //     String uid = auth.currentUser?.uid ?? '';
  //     if (uid.isNotEmpty) {
  //       print('Storing transaction details: $transactionData');
  //       String transactionId = transactionData['transaction_id'];
  //       var existingTransaction = await firestore
  //           .collection('siswa')
  //           .doc(uid)
  //           .collection('transactions')
  //           .where('transaction_id', isEqualTo: transactionId)
  //           .get();

  //       if (existingTransaction.docs.isEmpty) {
  //         Map<String, dynamic> dataToStore = {
  //           'transaction_id': transactionData['transaction_id'],
  //           'transaction_status': transactionData['transaction_status'],
  //           'transaction_time': transactionData['transaction_time'],
  //           'gross_amount': transactionData['gross_amount'],
  //           'currency': transactionData['currency'],
  //           'order_id': transactionData['order_id'],
  //           'payment_type': transactionData['payment_type'],
  //           'status_message': transactionData['status_message'],
  //           'merchant_id': transactionData['merchant_id'],
  //           'settlement_time': transactionData['settlement_time'] ?? '',
  //           'expiry_time': transactionData['expiry_time'] ?? '',
  //           'custom_field1': transactionData['custom_field1'],
  //           'custom_field2': transactionData['custom_field2'],
  //           'custom_field3': transactionData['custom_field3'],
  //         };

  //         // Store data in Firestore under the user's transactions subcollection
  //         await firestore
  //             .collection('siswa')
  //             .doc(uid)
  //             .collection('transactions')
  //             .add(dataToStore);

  //         print('Transaction details stored successfully');

  //         // Fetch updated transactions
  //         await fetchStudentData(userNim.value, uid);

  //         // Show success message using GetX's snackbar
  //         Get.snackbar('Success', 'Transaction details stored in Firestore');
  //       } else {
  //         print('Transaction already exists in Firestore');
  //       }
  //     } else {
  //       // Show error message if user is not logged in
  //       Get.snackbar('Error', 'User is not logged in');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to store transaction details: $e');
  //   }
  // }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }

  void onBottomNavTap(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }
}
