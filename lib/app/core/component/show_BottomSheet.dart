import 'package:flutter/material.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';

class JenisPembayaranBottomSheet extends StatelessWidget {
  final JenisPembayaran pembayaran;
  final JenisPembayaranController controller;

  JenisPembayaranBottomSheet({
    required this.pembayaran,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('No: ${pembayaran.id}', style: TextStyle(fontSize: 20)),
            Text('Kode: ${pembayaran.kode}', style: TextStyle(fontSize: 20)),
            Text('Nama Pembayaran: ${pembayaran.nama}', style: TextStyle(fontSize: 20)),
            Text('Jenis Pembayaran: ${pembayaran.pembayaran}', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle edit action here
                    Navigator.pop(context);
                  },
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.deleteJenisPembayaran(pembayaran.id!);
                    Navigator.pop(context);
                  },
                  child: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}