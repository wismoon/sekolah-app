import 'package:flutter/material.dart';
import 'package:sekolah_app/app/models/biayapembayaran_model.dart';

class BiayaPembayaranCard extends StatelessWidget {
  final Biayapembayaran pembayaran;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const BiayaPembayaranCard({
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
              Text("Nama Biaya Pembayaran: ${pembayaran.nama ?? ''}"),
              SizedBox(height: 8),
              Text("Jenis Pembayaran: ${pembayaran.jenis ?? ''}"),
              SizedBox(height: 8),
              Text("Biaya Pembayaran: ${pembayaran.biaya ?? ''}"),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
