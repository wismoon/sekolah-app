import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class StudentHomeView extends GetView {
  const StudentHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHomeView'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: Icon(Icons.person_2_rounded))
        ],
      ),
      body: const Center(
        child: Text(
          'StudentHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
