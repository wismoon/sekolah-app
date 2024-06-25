import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/core/component/invoice_card_siswa.dart';
import 'package:sekolah_app/app/modules/home/controllers/student_home_controller.dart';

class StudentTagihanView extends GetView<StudentHomeController> {
  const StudentTagihanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan Home'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.invoiceList.isEmpty) {
          return Center(child: Text("No tagihan data available"));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.invoiceList.length,
          itemBuilder: (context, index) {
            final payment = controller.invoiceList[index];
            final transactions = controller.transactionList;
            return InvoiceCardSiswa(
              invoice: payment,
              statusTransactions: transactions,
            );
          },
        );
      }),
    );
  }
}
