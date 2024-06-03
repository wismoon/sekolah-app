import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sekolah_app/app/core/constant/app_theme.dart';
import 'package:sekolah_app/app/modules/Splash/splash.dart';

import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GetStorage box = GetStorage();
    
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        if (snapshot.data != null && snapshot.data!.emailVerified == true) {
          String? role = box.read("role");
          String initialRoute;

          if (role == "admin") {
            initialRoute = Routes.HOME;
          } else if (role == "student") {
            initialRoute = Routes.STUDENT_HOME;
          } else {
            initialRoute = Routes.LOGIN; // Fallback to login if role is unknown
          }

          return GetMaterialApp(
            title: "Application",
            theme: AppTheme.lightTheme,
            initialRoute: initialRoute,
            getPages: AppPages.routes,
          );
        } else {
          return GetMaterialApp(
            title: "Application",
            theme: AppTheme.lightTheme,
            initialRoute: Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }
      },
    );
  }
}
