import 'package:flutter/material.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';

class InvoiceDetailSheet extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailSheet({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Student: ${invoice.nama}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Jenis Pembayaran: ${invoice.jenis_pembayaran}", style: TextStyle(fontSize: 16)),
          Text("Periode Pembayaran: ${invoice.nama_pembayaran}", style: TextStyle(fontSize: 16)),
          Text("Biaya Pembayaran: ${invoice.biaya_pembayaran}", style: TextStyle(fontSize: 16)),
          Text("Keterangan: ${invoice.keterangan}", style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement payment logic here
                  },
                  icon: Icon(Icons.payment),
                  label: Text("Pay"),
                ),
              ),
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
