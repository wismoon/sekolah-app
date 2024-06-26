import 'package:flutter/material.dart';
import 'package:sekolah_app/app/core/component/showBottomSheet.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';

void showFullScreenInvoiceDetailSheet(BuildContext context, Invoice invoice, String transactionStatus) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return InvoiceDetailSheet(invoice: invoice, transactionStatus: transactionStatus );
    },
  );
}
