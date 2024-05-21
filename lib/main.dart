import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sekolah_app/app/modules/Splash/splash.dart';

import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth auth = FirebaseAuth.instance;

  await GetStorage.init();

  runApp( 
    StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        return GetMaterialApp(
          title: "Application",
          initialRoute: snapshot.data != null && snapshot.data!.emailVerified == true ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
        );
      }
    ),
  );
}
