import 'package:get/get.dart';
import 'package:trafic_bordeaux/design_system/bottom_modal_view.dart';
import 'package:trafic_bordeaux/design_system/buttons_view.dart';
import 'package:trafic_bordeaux/design_system/dialog_popup_view.dart';
import 'package:trafic_bordeaux/ui/views/home.dart';
import 'package:trafic_bordeaux/ui/views/login.dart';
import 'package:trafic_bordeaux/ui/views/profil.dart';
import 'package:trafic_bordeaux/ui/views/register.dart';

import '../bindings/home_bindings.dart';
import '../design_system/inputs_view.dart';
import '../ui/views/widget_kit.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.WIDGET_KIT,
      page: () => WidgetsKit(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BUTTONS,
      page: () => const ButtonsView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INPUTS,
      page: () => const InputsView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DIALOG_POPUP,
      page: () => const DialogPopupView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MODAL,
      page: () => const BottomModalView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const Login(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const Register(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const Profil(),
      binding: HomeBinding(),
    ),
  ];
}