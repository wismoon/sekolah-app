import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }
}
