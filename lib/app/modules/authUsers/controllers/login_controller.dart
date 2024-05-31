import 'package:cloud_firestore/cloud_firestore.dart';
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
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final box = GetStorage();

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection("users").doc(credential.user!.uid).get();

        if (docUser.exists) {
          // User found in the users collection
          String role = docUser["role"];
          handleUserLogin(role, email, password, credential);
        } else {
          // User not found in the users collection, check the siswa collection
          DocumentSnapshot<Map<String, dynamic>> docSiswa = 
              await firestore.collection("siswa").doc(credential.user!.uid).get();

          if (docSiswa.exists) {
            // User found in the siswa collection
            handleUserLogin("student", email, password, credential);
          } else {
            // User not found in both collections
            isLoading.value = false;
            Get.snackbar("User Not Found", "User not found in any collection");
          }
        }

      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        print(e.code);
        if (e.code == 'user-not-found') {
          Get.snackbar("Email Belum Terdaftar", "Email Anda Belum Terdaftar");
        } else if (e.code == 'invalid-credential') {
          errMsg("Password Anda Salah");
        }
      }
    } else {
      errMsg("Email & Password harus diisi");
    }
  }

  void handleUserLogin(String role, String email, String password, UserCredential credential) async {
    isLoading.value = false;

    if (credential.user!.emailVerified == true) {
      if (box.read("rememberme") != null) {
        await box.remove("rememberme");
      }

      if (rememberme.isTrue) {
        await box.write("rememberme", {
          "email": email,
          "password": password,
        });
      }

      await box.write("role", role);

    // Navigate based on role
    if (role == "admin") {
      Get.offAllNamed(Routes.HOME);
    } else if (role == "student") {
      Get.offAllNamed(Routes.STUDENT_HOME);
    } 


    } else {
      print("email belum terverifikasi");
      Get.defaultDialog(
          title: "Belum terverifikasi",
          middleText: "Apakah anda ingin mengirimkan email verifikasi kembali?",
          actions: [
            OutlinedButton(
                onPressed: () => Get.back(), child: Text("Tidak")),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await credential.user!.sendEmailVerification();
                    Get.back();
                    Get.snackbar("Terkirim", "Email Verifikasi Berhasil Terkirim");
                  } catch (e) {
                    print(e);
                    Get.back();
                    Get.snackbar("Email Sudah Terkirim", "Silahkan Verifikasi Email Anda");
                  }
                },
                child: Text("Kirim")),
          ]);
    }
  }

  void errMsg (String msg) {
    Get.snackbar("Terjadi Kesalahan", msg);
  }

  void succMsg (String msg) {
    Get.snackbar("Terjadi Kesalahan", msg);
  }
}


 // isLoading.value = false;

        // if (credential.user!.emailVerified == true ) {
        //   if (box.read("rememberme") != null) {
        //     await box.remove("rememberme");
        //   }

        //   if (rememberme.isTrue) {
        //     await box.write("rememberme", {
        //       "email": email,
        //       "password": password
        //     });
        //   }

        // }else {
        //   print("email belum teregristrasi");
        //   Get.defaultDialog(
        //       title: "Belum terverifikasi",
        //       middleText:
        //           "Apakah anda ingin mengirimkan email verifikasi kembali?",
        //       actions: [
        //         OutlinedButton(
        //             onPressed: () => Get.back(), child: Text("Tidak")),
        //         ElevatedButton(
        //             onPressed: () async {
        //               try {
        //                 await credential.user!.sendEmailVerification();
        //                 Get.back();
        //                 Get.snackbar(
        //                     "Terkirim", "Email Verifikasi Berhasil Terkirim");
        //               } catch (e) {
        //                 print(e);
        //                 Get.back();
        //                 Get.snackbar("Email Sudah Terkirim",
        //                     "Silahkan Verifikasi Email Anda");
        //               }
        //             },
        //             child: Text("Kirim"))
        //       ]);
        // }