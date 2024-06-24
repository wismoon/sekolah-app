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
              _buildRow("Nama Pembayaran", pembayaran.nama ?? ''),
              _buildRow("Periode Pembayaran", pembayaran.jenis ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, dynamic value) {
    String displayValue;
    if (value is List<String>) {
      // Join the list into a single string with comma and space
      displayValue = value.join(', ');
    } else {
      // Otherwise, use value directly as string
      displayValue = value.toString();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(displayValue)),
        ],
      ),
    );
  }
}
