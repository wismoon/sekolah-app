import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/tagihan/controllers/tagihan_individu_controller.dart';

class AddTagihanIndividuView extends GetView<TagihanIndividuController> {
  const AddTagihanIndividuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTagihanIndividuView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddTagihanIndividuView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
