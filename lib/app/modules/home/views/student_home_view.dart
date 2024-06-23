import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/core/component/menu_custom.dart';
import 'package:sekolah_app/app/modules/home/controllers/student_home_controller.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class StudentHomeView extends GetView<StudentHomeController> {
  const StudentHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
        double heightDevice = Get.height;

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
      body: Column(
        children: [
          SizedBox(
            height: heightDevice * 0.1,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuCustom(
                title: "Tagihan",
                imageUrl: "bill2.png",
                routeName: Routes.STUDEN_TAGIHAN,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
