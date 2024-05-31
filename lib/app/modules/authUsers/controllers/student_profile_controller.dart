import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class StudentProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  var nameC = TextEditingController();
  var nimC = TextEditingController();
  var fakultas = TextEditingController();
  var instansi = TextEditingController();
  var jurusan = TextEditingController();
  var yearC = TextEditingController();
  var emailC = TextEditingController();
  var passwordC = TextEditingController();
  var phoneNumber = TextEditingController();
  var dateBirth = TextEditingController();
  var placeBirth = TextEditingController();
  var religion = TextEditingController();
  var alamat = TextEditingController();
  var negara = TextEditingController();
  var kota = TextEditingController();
  var kodePos = TextEditingController();

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
          await firestore.collection("siswa").doc(uid).get();

      return docUser.data();
    } catch (e) {
      errMsg("Tidak dapat meload profile anda");
      return null;
    }
  }

  void updateProfile() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        fakultas.text.isNotEmpty &&
        jurusan.text.isNotEmpty &&
        instansi.text.isNotEmpty &&
        yearC.text.isNotEmpty &&
        nimC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        String uid = auth.currentUser!.uid;
        await firestore.collection("siswa").doc(uid).update({
          "email": emailC.text,
          "instansi": instansi.text,
          "fakultas": fakultas.text,
          "jurusan": jurusan.text,
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
