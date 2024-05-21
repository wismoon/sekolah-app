import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/biaya_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/jenis_pembayaran_controller.dart';
import 'package:sekolah_app/app/modules/pembayaran/controllers/periode_pembayaran_controller.dart';

import '../controllers/pembayaran_controller.dart';

class PembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeriodePembayaranController>(
      () => PeriodePembayaranController(),
    );
    Get.lazyPut<BiayaPembayaranController>(
      () => BiayaPembayaranController(),
    );
    Get.lazyPut<JenisPembayaranController>(
      () => JenisPembayaranController(),
    );
    Get.lazyPut<PembayaranController>(
      () => PembayaranController(),
    );
  }
}
