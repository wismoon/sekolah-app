import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool rememberme = false.obs;
  RxBool isHidden = true.obs;
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  final box = GetStorage();

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        print(credential);

        isLoading.value = false;

        if (credential.user!.emailVerified == true) {
          if (box.read("rememberme") != null) {
            await box.remove("rememberme");
          }

          if (rememberme.isTrue) {
            await box.write("rememberme", {
              "email": email,
              "password": password
            });
          }
          Get.offAllNamed(Routes.HOME);
        } else {
          print("email belum teregristrasi");
          Get.defaultDialog(
              title: "Belum terverifikasi",
              middleText:
                  "Apakah anda ingin mengirimkan email verifikasi kembali?",
              actions: [
                OutlinedButton(
                    onPressed: () => Get.back(), child: Text("Tidak")),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await credential.user!.sendEmailVerification();
                        Get.back();
                        Get.snackbar(
                            "Terkirim", "Email Verifikasi Berhasil Terkirim");
                      } catch (e) {
                        print(e);
                        Get.back();
                        Get.snackbar("Email Sudah Terkirim",
                            "Silahkan Verifikasi Email Anda");
                      }
                    },
                    child: Text("Kirim"))
              ]);
        }

      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        print(e.code);
        if (e.code == 'user-not-found') {
          Get.snackbar("Email Belum Terdaftar", "Email Anda Belum Terdaftar");
        } else if (e.code == 'wrong-password') {
          errMsg("Password Anda Salah");
        }
      }
    } else {
      errMsg("Email & Password harus diisi");
    }
  }

  void errMsg (String msg) {
    Get.snackbar("Terjadi Kesalahan", msg);
  }

  void succMsg (String msg) {
    Get.snackbar("Terjadi Kesalahan", msg);
  }
}
