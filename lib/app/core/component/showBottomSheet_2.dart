import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/modules/home/controllers/student_home_controller.dart';

class InvoiceDetailSheet2 extends StatelessWidget {
  final Invoice invoice;
  final StudentHomeController paymentController =
      Get.put(StudentHomeController());
  InvoiceDetailSheet2({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM yyyy, HH:mm:ss').format(invoice.created_at!);
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 5,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          Text(
            "Tagihan",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade300,
          ),
          SizedBox(height: 20),
          Text(
            "${invoice.jenis_pembayaran}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "${invoice.nomor_pembayaran}",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Divider(height: 40, thickness: 1),
          _buildDetailRow("No Pembayaran", invoice.nomor_pembayaran!),
          _buildDetailRow("Jenis Pembayaran", invoice.jenis_pembayaran!),
          _buildDetailRow("Nama Pembayaran", invoice.nama_pembayaran!),
          _buildDetailRow("Biaya Pembayaran", _formatCurrency(invoice.biaya_pembayaran!)),
          _buildDetailRow(
              "Keterangan", _truncateKeterangan(invoice.keterangan ?? "-")),
          _buildDetailRow(
            "Waktu dan Tanggal",
            formattedDate,
          ),
          Divider(height: 40, thickness: 1),
          _buildDetailRow("Total", _formatCurrency(invoice.biaya_pembayaran!)),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement print/share logic here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("Print Tagihan"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label :",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(String amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatter.format(int.parse(amount));
  }

  String _truncateKeterangan(String keterangan) {
    List<String> words = keterangan.split(' ');
    if (words.length > 3) {
      return words.take(3).join(' ') + '...';
    }
    return keterangan;
  }
}
