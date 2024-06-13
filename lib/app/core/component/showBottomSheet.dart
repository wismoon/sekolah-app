import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/modules/home/controllers/student_home_controller.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import 'package:sekolah_app/app/services/payment_service.dart';

class InvoiceDetailSheet extends StatelessWidget {
  final Invoice invoice;
  final StudentHomeController paymentController =
      Get.put(StudentHomeController());
  InvoiceDetailSheet({Key? key, required this.invoice}) : super(key: key);

  Future<void> _handlePayment() async {
    try {
      // // Check the payment status first using nomorPembayaran as transactionId
      // final status =
      //     await PaymentService.getPaymentStatus(invoice.nomor_pembayaran!);

      // if (status['transaction_status'] == 'settlement') {
      //   Get.snackbar('Info', 'The invoice has already been paid.');
      //   return;
      // }

      // If the payment is not settled, create a new payment
      final response =
          await PaymentService.createPayment(invoice.nomor_pembayaran!);
      final redirectUrl = response['data']['dataPembayaran']['redirect_url'];

      // Debugging print statement
      print('Navigating to PaymentView with URL: $redirectUrl');
      Get.toNamed(Routes.PAYMENT, parameters: {'url': redirectUrl});
    } catch (e) {
      print('Payment error: $e');
      if (e
          .toString()
          .contains('Order ID atau Transaction ID tidak ditemukan')) {
        Get.snackbar('Error', 'Transaction ID not found.');
      } else if (e
          .toString()
          .contains('Terjadi kesalahan, gagal membuat pembayaran')) {
        Get.snackbar('Error', 'Failed to create payment.');
      } else {
        Get.snackbar('Error', 'An unexpected error occurred.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Student: ${invoice.nama}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Jenis Pembayaran: ${invoice.jenis_pembayaran}",
              style: TextStyle(fontSize: 16)),
          Text("Periode Pembayaran: ${invoice.nama_pembayaran}",
              style: TextStyle(fontSize: 16)),
          Text("Biaya Pembayaran: ${invoice.biaya_pembayaran}",
              style: TextStyle(fontSize: 16)),
          Text("Keterangan: ${invoice.keterangan}",
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton.icon(
                    onPressed: _handlePayment,
                    icon: Icon(Icons.payment),
                    label: Text("Pay"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement print/share logic here
                    },
                    icon: Icon(Icons.share),
                    label: Text("Print/Share"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
