import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sekolah_app/app/modules/authUsers/controllers/student_profile_controller.dart';
import '../../../core/component/ProfileTextField.dart';

class StudentProfileView extends GetView<StudentProfileController> {
  const StudentProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null) {
            return Center(child: Text("Tidak ada Data"));
          }

          Map<String, dynamic> profileData = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ProfileTextField(
                labelText: 'Nama',
                controller: controller.emailC,
                initialValue: profileData['email'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'Nama',
                controller: controller.nameC,
                initialValue: profileData['nama'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'NIM',
                controller: controller.nimC,
                initialValue: profileData['nim'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'Tahun Angkatan',
                controller: controller.yearC,
                initialValue: profileData['tahun-angkatan'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'Instansi',
                controller: controller.instansi,
                initialValue: snapshot.data!['instansi'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'Fakultas',
                controller: controller.fakultas,
                initialValue: snapshot.data!['fakultas'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'Jurusan',
                controller: controller.jurusan,
                initialValue: snapshot.data!['jurusan'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'Negara',
                controller: controller.negara,
                initialValue: snapshot.data!['negara'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'Kota',
                controller: controller.kota,
                initialValue: snapshot.data!['kota'] ?? '',
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                labelText: 'Kode Pos',
                controller: controller.kodePos,
                initialValue: snapshot.data!['kodePos'] ?? '',
              ),
              const SizedBox(height: 20),
              Obx(() => TextField(
                    autocorrect: false,
                    obscureText: controller.isHidden.value,
                    controller: controller.passwordC,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                            onPressed: () => controller.isHidden.toggle(),
                            icon: controller.isHidden.isFalse
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        labelText: "Password",
                        border: const OutlineInputBorder()),
                  )),
              const SizedBox(height: 20),
              Obx(() => ElevatedButton(
                  onPressed: () {
                    controller.updateProfile();
                  },
                  child: Text(
                      controller.isLoading.isFalse ? "Update" : "Loading.."))),
              const SizedBox(
                height: 20,
              ),
              Obx(() => ElevatedButton(
                  onPressed: () {
                    controller.logout();
                  },
                  child: Text(
                      controller.isLoading.isFalse ? "Logout" : "Loading.."))),
            ],
          );
        },
      ),
    );
  }
}
