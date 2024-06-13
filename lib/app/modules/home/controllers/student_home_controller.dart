import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import 'package:sekolah_app/app/services/invoice_service.dart';
import 'package:sekolah_app/app/services/payment_service.dart';

class StudentHomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final InvoiceService _service = InvoiceService();
  var invoiceList = <Invoice>[].obs;
  var isLoading = false.obs;
  var userNim = ''.obs;

  @override
  void onInit() {
    fetchUserNim();
    super.onInit();
  }

  void fetchUserNim() async {
    isLoading(true);
    try {
      String uid = auth.currentUser?.uid ?? '';
      if (uid.isNotEmpty) {
        DocumentSnapshot userDoc =
            await firestore.collection('siswa').doc(uid).get();
        if (userDoc.exists) {
          userNim.value = userDoc['nim'];
          fetchStudentInvoice(userNim.value);
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
    isLoading(true);
    try {
      var studentInvoices = await _service.fetchStudentInvoice(nim);
      if (studentInvoices.isEmpty) {
        Get.snackbar('Data Error', 'Failed to load data because is Empty');
      } else {
        invoiceList.value = studentInvoices;
        // print(
        //     "Fetched Jenis Pembayaran List: ${invoiceList.map((e) => e.toJson()).toList()}");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<Map<String, dynamic>> createPayment(String nomorPembayaran) async {
    isLoading.value = true;
    try {
      final response = await PaymentService.createPayment(nomorPembayaran);
      return response;
    } catch (e) {
      Get.snackbar('Error', 'Failed to create payment: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkPaymentStatus(String transactionId) async {
  try {
    Map<String, dynamic> statusResponse =
          await PaymentService.getPaymentStatus(transactionId);
      Get.snackbar(
          'Payment Status', 'Status: ${statusResponse['transaction_status']}');
  } catch (e) {
    Get.snackbar('Error', 'Failed to get payment status: $e');
    return null;
  }
}

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }
}
