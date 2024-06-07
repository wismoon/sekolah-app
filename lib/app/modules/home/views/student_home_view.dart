import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/core/component/invoice_card_siswa.dart';
import 'package:sekolah_app/app/modules/home/controllers/student_home_controller.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class StudentHomeView extends GetView<StudentHomeController> {
  const StudentHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.STUDENT_PROFILE),
              icon: Icon(Icons.person_4_rounded))
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.invoiceList.isEmpty) {
          return Center(child: Text("No payment data available"));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.invoiceList.length,
          itemBuilder: (context, index) {
            final payment = controller.invoiceList[index];
            return InvoiceCardSiswa(invoice: payment);
          },
        );
      }),
    );
  }
}
