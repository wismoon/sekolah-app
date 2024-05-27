import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/tagihan/controllers/tagihan_kelompok_controller.dart';

class AddTagihanKelompokView extends GetView<TagihanKelompokController> {
  const AddTagihanKelompokView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTagihanKelompokView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddTagihanKelompokView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
