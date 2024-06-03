import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => controller.logout(), icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
          future: controller.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: Text("Tidak ada Data"),
              );
            } else {
              controller.emailC.text = snapshot.data!["email"];
              controller.nameC.text = snapshot.data!["nama"];
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextField(
                    autocorrect: false,
                    controller: controller.nameC,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Nama",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autocorrect: false,
                    readOnly: true,
                    controller: controller.emailC,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => ElevatedButton(
                      onPressed: () {
                        controller.updateProfile();
                      },
                      child: Text(controller.isLoading.isFalse
                          ? "Update"
                          : "Loading.."))),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => ElevatedButton(
                      onPressed: () {
                        controller.logout();
                      },
                      child: Text(controller.isLoading.isFalse
                          ? "Logout"
                          : "Loading.."))),
                ],
              );
            }
          }),
    );
  }
}
