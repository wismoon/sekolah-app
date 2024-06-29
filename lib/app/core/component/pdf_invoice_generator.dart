import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:sekolah_app/app/models/transaction_model.dart';

class PdfInvoiceGenerator {
  final Invoice invoice;
  final String transactionStatus;
  List<SiswaTransaction> transactions = [];
  PdfInvoiceGenerator({required this.invoice, required this.transactionStatus});

  Future<String> generateInvoice() async {
    final pdf = pw.Document();

    // Add page to the PDF
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          _buildHeader(context),
          pw.SizedBox(height: 20),
          _buildInvoiceDetails(context),
          pw.SizedBox(height: 20),
          // _buildTransactionDetails(context),
          // pw.SizedBox(height: 20),
          _buildFooter(context),
          pw.SizedBox(height: 20),
          // _buildTermsAndConditions(context),
        ],
      ),
    );
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  Future<Uint8List> generateInvoiceAsBytes() async {
    final pdf = pw.Document();

    // Add page to the PDF
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          _buildHeader(context),
          pw.SizedBox(height: 20),
          _buildInvoiceDetails(context),
          pw.SizedBox(height: 20),
          _buildFooter(context),
          pw.SizedBox(height: 20),
        ],
      ),
    );

    return pdf.save();
  }

  Future<void> _fetchTransactionDetails() async {
    final firestore = FirebaseFirestore.instance;
    var querySnapshot = await firestore
        .collection('siswa')
        .doc()
        .collection('transactions')
        .where('order_id', isEqualTo: invoice.nomor_pembayaran)
        .get();

    transactions = querySnapshot.docs
        .map((doc) => SiswaTransaction.fromDocumentSnapshot(doc))
        .toList();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
      padding: pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.grey,
            width: 1,
          ),
        ),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'INVOICE',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.teal,
            ),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Invoice # ${invoice.nomor_pembayaran}',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                DateFormat('dd MMM yyyy, HH:mm:ss').format(DateTime.now()),
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildInvoiceDetails(pw.Context context) {
    return pw.Container(
      padding: pw.EdgeInsets.all(10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Invoice Details',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          _buildDetailRow("Nama", invoice.nama ?? ''),
          _buildDetailRow("Nim", invoice.nim ?? ''),
          _buildDetailRow("Email", invoice.email ?? ''),
          _buildDetailRow("Jurusan", invoice.program_studi ?? ''),
          _buildDetailRow("Jenis Pembayaran", invoice.jenis_pembayaran ?? ''),
          _buildDetailRow("Status Transaksi", transactionStatus),
          _buildDetailRow("Total Pembayaran",
              '${_formatCurrency(invoice.biaya_pembayaran ?? '')}'),
        ],
      ),
    );
  }

  pw.Widget _buildTransactionDetails(pw.Context context) {
    return pw.Container(
      padding: pw.EdgeInsets.all(10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Transaction Details',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          for (var transaction in transactions) ...[
            _buildDetailRow('Transaction ID:', transaction.transactionId ?? ''),
            _buildDetailRow('Status:', transaction.transactionStatus ?? ''),
            _buildDetailRow('Payment Type:', transaction.paymentType ?? ''),
            _buildDetailRow('Gross Amount:',
                '${_formatCurrency(transaction.grossAmount ?? '0')}'),
            _buildDetailRow(
                'Transaction Time:', transaction.transactionTime ?? ''),
            _buildDetailRow(
                'Settlement Time:', transaction.settlementTime ?? ''),
            _buildDetailRow('Expiry Time:', transaction.expiryTime ?? ''),
            _buildDetailRow('Status Message:', transaction.statusMessage ?? ''),
            pw.SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  pw.Widget _buildDetailRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      padding: pw.EdgeInsets.all(10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Thank you for your business!',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          // pw.Text(
          //   'Payment Info:',
          //   style: pw.TextStyle(
          //     fontSize: 12,
          //     fontWeight: pw.FontWeight.bold,
          //     color: PdfColors.teal,
          //   ),
          // ),
          // pw.Text(
          //   'Bank Account: }',
          //   style: pw.TextStyle(
          //     fontSize: 10,
          //   ),
          // ),
        ],
      ),
    );
  }

  pw.Widget _buildTermsAndConditions(pw.Context context) {
    return pw.Container(
      padding: pw.EdgeInsets.all(10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Terms & Conditions',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam varius enim at consectetur suscipit. Phasellus porttitor nulla vitae mauris.',
            style: pw.TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(String amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatter.format(double.parse(amount));
  }
}
