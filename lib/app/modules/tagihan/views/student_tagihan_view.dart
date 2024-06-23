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
        return PageView(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          children: [
            _buildTagihanList(),
            // _buildHistoryList(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onBottomNavTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'New Invoice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTagihanList() {
    return Obx(() {
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
    });
  }

  // Widget _buildHistoryList() {
  //   return Obx(() {
  //     if (controller.isLoading.value) {
  //       return Center(child: CircularProgressIndicator());
  //     }
  //     if (controller.historyList.isEmpty) {
  //       return Center(child: Text("No history data available"));
  //     }
  //     return ListView.builder(
  //       padding: EdgeInsets.all(16),
  //       itemCount: controller.historyList.length,
  //       itemBuilder: (context, index) {
  //         final history = controller.historyList[index];
  //         return InvoiceCardSiswa(invoice: history, statusTransactions: [],);
  //       },
  //     );
  //   });
  // }
}
