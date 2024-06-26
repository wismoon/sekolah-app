import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sekolah_app/app/core/component/showFullScreenSheets2.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/models/transaction_model.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final List<SiswaTransaction> statusTransactions;


  const InvoiceCard({
    Key? key,
    required this.invoice,
    required this.statusTransactions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //find the transaction from orderId
    String expectedOrderId = '${invoice.nomor_pembayaran}-1';
    SiswaTransaction? matchingTransaction = statusTransactions.firstWhere(
        (transaction) => transaction.orderId == expectedOrderId,
        orElse: () => SiswaTransaction());

    String transactionStatus = matchingTransaction.transactionStatus ?? 'Pending';

    // print('Invoice: ${invoice.nomor_pembayaran}, Expected Order ID: $expectedOrderId, Status: $transactionStatus');

    return GestureDetector(
      onTap: () {
        showFullScreenInvoiceDetailSheet(context, invoice, transactionStatus);
      },
      child: Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow("Student", invoice.nama!),
            _buildRow("Jenis Pembayaran", invoice.jenis_pembayaran!),
            _buildRow("Nama Pembayaran", invoice.nama_pembayaran!),
            _buildRow("Biaya Pembayaran", _formatCurrency(invoice.biaya_pembayaran!)),
            _buildRow("Keterangan", _truncateKeterangan(invoice.keterangan!)),
            _buildStatusRow("Status Transaksi", transactionStatus, transactionStatus)
          ],
        ),
      ),
    ));
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

  Widget _buildStatusRow (String label, String value, String status) {
    Color statusColor;
    String statusText;

    switch (status) {
      case "settlement":
        statusColor = Colors.green;
        statusText = "Sudah Bayar";
        break;
      case "cancel":
        statusColor = Colors.red;
        statusText = "Dibatalkan";
        break;
      case "capture":
        statusColor = Colors.blue;
        statusText = "Diterima";
        break;
      case "expired":
        statusColor = Colors.grey;
        statusText = "Kadaluarsa";
        break;
      default:
        statusColor = Colors.amber;
        statusText = "Belum Bayar";
    }

    return Padding
    (padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),);
  }

  String _formatCurrency(String amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatter.format(int.parse(amount));
  }

  String _truncateKeterangan (String keterangan) {
    List<String> words =  keterangan.split(' ');
    if (words.length > 3) {
      return words.take(3).join(' ') + '...';
    }
    return keterangan;
  }
}
