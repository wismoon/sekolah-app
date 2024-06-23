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
              _buildRow("Nama Pembayaran", pembayaran.nama ?? ''),
              _buildRow("Jenis Pembayaran", pembayaran.jenis ?? ''),
              _buildRow("Biaya Pembayaran", pembayaran.biaya ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow (String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value))
        ],
      ),
    );
  }
}
