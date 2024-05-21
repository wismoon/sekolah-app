import 'package:get/get.dart';

import '../modules/authUsers/bindings/auth_users_binding.dart';
import '../modules/authUsers/views/auth_users_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/authUsers/views/login_view.dart';
import '../modules/pembayaran/bindings/pembayaran_binding.dart';
import '../modules/pembayaran/views/biaya_pembayaran_view.dart';
import '../modules/pembayaran/views/create/views/add_biaya_pembayaran_view.dart';
import '../modules/pembayaran/views/create/views/add_jenis_pembayaran_view.dart';
import '../modules/pembayaran/views/create/views/add_periode_pembayaran_view.dart';
import '../modules/pembayaran/views/jenis_pembayaran_view.dart';
import '../modules/pembayaran/views/pembayaran_view.dart';
import '../modules/pembayaran/views/periode_pembayaran_view.dart';
import '../modules/authUsers/views/profile_view.dart';
import '../modules/authUsers/views/register_view.dart';
import '../modules/authUsers/views/reset_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: AuthUsersBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: AuthUsersBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: AuthUsersBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: AuthUsersBinding(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN,
      page: () => const PembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.Jenis_PEMBAYARAN,
      page: () => JenisPembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.ADD_Jenis_PEMBAYARAN,
      page: () => const AddJenisPembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.Biaya_PEMBAYARAN,
      page: () => const BiayaPembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.ADD_Biaya_PEMBAYARAN,
      page: () => const AddBiayaPembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.Periode_PEMBAYARAN,
      page: () => const PeriodePembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.ADD_Periode_PEMBAYARAN,
      page: () => const AddPeriodePembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_USERS,
      page: () => const AuthUsersView(),
      binding: AuthUsersBinding(),
    ),
  ];
}
