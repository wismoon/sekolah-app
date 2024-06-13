import 'package:get/get.dart';

class PaymentController extends GetxController {
  final String url = Get.parameters['url'] ?? '';

  @override
  void onInit() {
    super.onInit();
    if (url.isEmpty) {
      Get.snackbar('Error', 'Invalid payment URL');
      Get.back();
    }
  }
}
