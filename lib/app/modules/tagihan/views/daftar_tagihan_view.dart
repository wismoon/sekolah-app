import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DaftarTagihanView extends GetView {
  const DaftarTagihanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DaftarTagihanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DaftarTagihanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
