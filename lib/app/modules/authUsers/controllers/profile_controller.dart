import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController nimC = TextEditingController();
  TextEditingController yearC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection("users").doc(uid).get();

      return docUser.data();
    } catch (e) {
      errMsg("Tidak dapat meload profile anda");
      return null;
    }
  }

  void updateProfile() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        String uid = auth.currentUser!.uid;
        await firestore.collection("users").doc(uid).update({
          "nama": nameC.text,
        });

        if (passwordC.text.isNotEmpty) {
          await auth.currentUser!.updatePassword(passwordC.text);
          await auth.signOut();

          isLoading.value = false;
          Get.offAllNamed(Routes.LOGIN);
        } else {
          isLoading.value = false;
        }

        isLoading.value = false;
        succMsg("Berhasil update data");
      } catch (e) {
        isLoading.value = false;
        errMsg("Tidak dapat mengubah data");
      }
    } else {
      errMsg("Harap isi semua kolom");
    }
  }

  void errMsg(String msg) {
    Get.snackbar("Terjadi Kesalahan", msg);
  }

  void succMsg(String msg) {
    Get.snackbar("Berhasil", msg);
  }
}
