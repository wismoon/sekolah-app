import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:sekolah_app/app/routes/app_pages.dart';

class IntroductionPageView extends GetView {
  const IntroductionPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        pages: [
          PageViewModel(
              title: "Title of introduction page",
              body:
                  "Welcome to the app! This is a description of how it works.",
              image: _buildImage("Tehe.png")),
          PageViewModel(
            title: "Title of custom button page",
            body: "This is a description on a page with a custom button below.",
            image: Center(
              child: Container(
                child: _buildLottie("Animation_login.json"),
              )
            ),
          ),
        ],
        next: const Text("Next"),
        done: const Text("Login", style: TextStyle(fontWeight: FontWeight.w700)),
        onDone: () {
          final GetStorage box = GetStorage();
          box.write("hasSeenIntroduction", true);
          Get.offAllNamed(Routes.LOGIN);
          
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ));
  }

  _buildImage(String imageName, [double width = 310]) {
    return Image.asset('images/$imageName', width: width);
  }

  _buildLottie(String lottieName, [double width = 310]) {
    return Lottie.asset('images/lottie/$lottieName', width: width, fit: BoxFit.cover);
  }
}
