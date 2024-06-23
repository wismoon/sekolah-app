import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    if (box.read("rememberme") != null) {
      controller.emailController.text = box.read("rememberme")["email"];
      controller.passwordController.text = box.read("rememberme")["password"];
      controller.rememberme.value = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: 200, // Adjust the height as needed
                child: _buildLottie("Animation_login.json")// Replace with your Lottie file
              ),
              const SizedBox(height: 100,),
              TextField(
                autocorrect: false,
                controller: controller.emailController,
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
                    controller: controller.passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                            onPressed: () => controller.isHidden.toggle(),
                            icon: controller.isHidden.isTrue
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        labelText: "Password",
                        border: const OutlineInputBorder()),
                  )),
              Obx(() => CheckboxListTile(
                  value: controller.rememberme.value,
                  title: Text("Remember me"),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (_) => controller.rememberme.toggle())),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    child: TextButton(
                      onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                      child: Text("Lupa Password?"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.login();
                    }
                  },
                  child: Text(
                      controller.isLoading.isFalse ? "Masuk" : "Loading"))),
              TextButton(
                onPressed: () => Get.toNamed(Routes.REGISTER),
                child: Text("Daftar"),
              )
            ],
          ),
        ));
  }

  _buildLottie(String lottieName, [double width = 310]) {
    return Lottie.asset('images/lottie/$lottieName',
        width: width, fit: BoxFit.cover);
  }
}
