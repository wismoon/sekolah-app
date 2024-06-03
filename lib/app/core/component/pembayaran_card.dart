import 'package:flutter/material.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';

class PembayaranCard extends StatelessWidget {
  final JenisPembayaran pembayaran;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PembayaranCard({
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
              Text("Kode  : ${pembayaran.kode ?? ''}"),
              SizedBox(height: 8),
              Text("Nama  : ${pembayaran.nama ?? ''}"),
              SizedBox(height: 8),
              Text("Jenis : ${pembayaran.pembayaran ?? ''}"),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
