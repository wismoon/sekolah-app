import 'package:flutter/material.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;

  const InvoiceCard({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Student: ${invoice.nama}"),
            Text("Jenis Pembayaran: ${invoice.jenis_pembayaran}"),
            Text("Periode Pembayaran: ${invoice.nama_pembayaran}"),
            Text("Biaya Pembayaran: ${invoice.biaya_pembayaran}"),
            Text("Keterangan: ${invoice.keterangan}"),
          ],
        ),
      ),
    );
  }
}
