import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {

  RxBool isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void reset() async {
    var email = emailController.text;
    if (email.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: email);

        isLoading.value = false;
        Get.back();
        succMsg("Berhasil Reset Password");
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errMsg("${e.code}");
      } catch (e) {
        isLoading.value = false;
        errMsg("Tidak dapat mereset email anda");
      }
    } else {
      errMsg("Email belum diisi");
    }
  }

  void errMsg(String msg) {
    Get.snackbar("TERJADI KESALAHAN", msg);
  }

  void succMsg(String msg) {
    Get.snackbar("BERHASIL", msg);
  }
}
