import 'package:get/get.dart';
import 'package:trafic_bordeaux/bindings/auth_bindings.dart';
import 'package:trafic_bordeaux/bindings/profil_bindings.dart';
import 'package:trafic_bordeaux/ui/views/home.dart';
import 'package:trafic_bordeaux/ui/views/login.dart';
import 'package:trafic_bordeaux/ui/views/profil.dart';
import 'package:trafic_bordeaux/ui/views/register.dart';

import '../bindings/home_bindings.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const Login(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const Register(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const Profil(),
      binding: ProfileBinding(),
    ),
  ];
}