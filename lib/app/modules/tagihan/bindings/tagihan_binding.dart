import 'package:get/get.dart';

import 'package:sekolah_app/app/modules/tagihan/controllers/tagihan_individu_controller.dart';
import 'package:sekolah_app/app/modules/tagihan/controllers/tagihan_kelompok_controller.dart';

import '../controllers/tagihan_controller.dart';

class TagihanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagihanKelompokController>(
      () => TagihanKelompokController(),
    );
    Get.lazyPut<TagihanIndividuController>(
      () => TagihanIndividuController(),
    );
    Get.lazyPut<TagihanController>(
      () => TagihanController(),
    );
  }
}
