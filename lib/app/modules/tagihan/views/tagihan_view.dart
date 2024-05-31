import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

import '../controllers/tagihan_controller.dart';

class TagihanView extends GetView<TagihanController> {
  const TagihanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TagihanView'),
        centerTitle: true,
      ),
      body: const Center(),
      floatingActionButton: Obx(() => Stack(
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
          )),
    );
  }
}
