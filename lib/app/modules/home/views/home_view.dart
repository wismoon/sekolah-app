import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import '../../../core/component/menu_custom.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // double widthDevice = Get.width;
    double heightDevice = Get.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: Icon(Icons.person_2_rounded))
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
                routeName: Routes.TAGIHAN,
              ),
              MenuCustom(
                title: "Pembayaran",
                imageUrl: "bill.png",
                routeName: Routes.PEMBAYARAN,
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
