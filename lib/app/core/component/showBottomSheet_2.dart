import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/modules/home/controllers/student_home_controller.dart';

class InvoiceDetailSheet2 extends StatelessWidget {
  final Invoice invoice;
  final StudentHomeController paymentController =
      Get.put(StudentHomeController());
  InvoiceDetailSheet2({Key? key, required this.invoice}) : super(key: key);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
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
        ],
      ),
    );
  }
}
