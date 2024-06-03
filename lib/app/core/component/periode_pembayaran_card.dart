import 'package:flutter/material.dart';
import 'package:sekolah_app/app/models/periode_pembayaran_model.dart';

class PeriodePembayaranCard extends StatelessWidget {
  final PeriodePembayaran pembayaran;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PeriodePembayaranCard({
    Key? key,
    required this.pembayaran,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama Pembayaran: ${pembayaran.nama ?? ''}"),
              SizedBox(height: 8),
              Text("Jenis Pembayaran: ${pembayaran.jenis ?? ''}"),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
