import 'package:get/get.dart';

import '../controllers/auth_users_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/register_controller.dart';
import '../controllers/reset_password_controller.dart';

class AuthUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthUsersController>(
      () => AuthUsersController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
    );
  }
}
