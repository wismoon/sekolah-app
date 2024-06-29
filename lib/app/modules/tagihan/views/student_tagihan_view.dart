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
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: InvoiceSearchDelegate(controller));
            },
          ),
        ],
      ),
      body: PageView(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          children: [
            _buildTagihanList()
          ],
        ),
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
          final payment = controller.invoiceList.toList()[index];
          final transactions = controller.transactionList.toList();
          return InvoiceCardSiswa(
            invoice: payment,
            statusTransactions: transactions,
          );
        },
      );
    });
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: controller.searchInvoice,
        decoration: InputDecoration(
          hintText: 'Search Invoices',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}

class InvoiceSearchDelegate extends SearchDelegate<String> {
  final StudentHomeController controller;

  InvoiceSearchDelegate(this.controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.searchInvoice(query);
    return Obx(() {
      if (controller.filteredTagihanList.isEmpty) {
        return Center(child: Text("No results found"));
      }
      return ListView.builder(
        itemCount: controller.filteredTagihanList.length,
        itemBuilder: (context, index) {
          final tagihan = controller.filteredTagihanList[index];
          final transactions = controller.transactionList;
          return InvoiceCardSiswa(
            invoice: tagihan,
            statusTransactions: transactions,
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // Suggestions not implemented in this example
  }
}
