import 'package:flutter/material.dart';
import 'package:sekolah_app/app/core/component/showBottomSheet.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';

class InvoiceCardSiswa extends StatelessWidget {
  final Invoice invoice;

  const InvoiceCardSiswa({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: InvoiceDetailSheet(invoice: invoice),
              );
            },
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Student: ${invoice.nama}", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Jenis Pembayaran: ${invoice.jenis_pembayaran}"),
              Text("Periode Pembayaran: ${invoice.nama_pembayaran}"),
              Text("Biaya Pembayaran: ${invoice.biaya_pembayaran}"),
              Text("Keterangan: ${invoice.keterangan}"),
            ],
          ),
        ),
      ),
    );
  }
}
