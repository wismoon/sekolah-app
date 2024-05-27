import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void register() async {
    final email = emailController.text;
    final name = nameController.text;
    final nim = nimController.text;
    final years = tahunController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print(credential);
        isLoading.value = false;

        await credential.user!.sendEmailVerification();

        await firestore.collection("siswa").doc(credential.user!.uid).set({
            "nim": nim,
            "nama": name,
            "jurusan": '',
            "fakultas": '',
            "instansi": '',
            "tahun-angkatan": years,
            "tanggal_lahir": '',
            "tempat_lahir": '',
            "jenis_kelamin": '',
            "agama": '',
            "nomor_telepon": '',
            "alamat": '',
            "email": email,
            "role": "student",
            "createdAt": DateTime.now().toIso8601String(),
            
        });

        Get.offAllNamed(Routes.LOGIN);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void errMsg(String msg) {
    Get.snackbar("Terjadi Kesalahan", msg);
  }

  void succMsg(String msg) {
    Get.snackbar("Terjadi Kesalahan", msg);
  }
}
