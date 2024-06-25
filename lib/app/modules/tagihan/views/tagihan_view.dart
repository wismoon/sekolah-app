import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

import '../controllers/tagihan_controller.dart';
import '../../../core/component/invoice_card.dart';

class TagihanView extends GetView<TagihanController> {
  const TagihanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan'),
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.tagihanList.isEmpty) {
          return Center(child: Text("No tagihan data available"));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.tagihanList.length,
          itemBuilder: (context, index) {
            final tagihan = controller.tagihanList[index];
            final transactions = controller.transactionList;
            return InvoiceCard(
              invoice: tagihan,
              statusTransactions: transactions,
            );
          },
        );
      }),
      floatingActionButton: Obx(() => _buildFloatActionButton()),
    );
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

  Widget _buildFloatActionButton() {
    return Stack(
      children: [
        if (controller.showAdditionalButtons.value)
          Positioned(
            bottom: 150.0,
            right: 16.0,
            child: FloatingActionButton.extended(
              heroTag: "btn_individu",
              onPressed: () {
                controller.hideButtons();
                Get.toNamed(Routes.ADD_TAGIHAN_INDIVIDU);
              },
              label: const Text("Tagihan Individu"),
              icon: const Icon(Icons.person),
            ),
          ),
        if (controller.showAdditionalButtons.value)
          Positioned(
            bottom: 84.0,
            right: 16.0,
            child: FloatingActionButton.extended(
              heroTag: "btn_kelompok",
              onPressed: () {
                controller.hideButtons();
                Get.toNamed(Routes.ADD_TAGIHAN_KELOMPOK);
              },
              label: const Text("Tagihan Kelompok"),
              icon: const Icon(Icons.group),
            ),
          ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton.extended(
            onPressed: controller.toggleButtons,
            label: const Text("add"),
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class InvoiceSearchDelegate extends SearchDelegate<String> {
  final TagihanController controller;

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
          return InvoiceCard(
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
