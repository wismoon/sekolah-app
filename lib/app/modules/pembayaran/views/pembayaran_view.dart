import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

import '../controllers/pembayaran_controller.dart';
import '../../../core/component/menu_custom2.dart';

class PembayaranView extends GetView<PembayaranController> {
  const PembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        centerTitle: true,
      ),
      body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuCustom2(title: "Jenis Pembayaran", imageUrl: "textBox.png", routeName: Routes.Jenis_PEMBAYARAN,),
              SizedBox(
                height: 20,
              ),
              MenuCustom2(title: "Biaya Pembayaran",  imageUrl: "invoice.png", routeName: Routes.Biaya_PEMBAYARAN),
              SizedBox(
                height: 20,
              ),
              MenuCustom2(title: "Periode Pembayaran", imageUrl: "calendar.png",routeName: Routes.Periode_PEMBAYARAN),
              SizedBox(
                height: 20,
              ),
              
            ],
          ),
        ));
  }
}
