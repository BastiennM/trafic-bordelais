import 'package:get/get.dart';
import 'package:trafic_bordeaux/controller/auth_controller.dart';
import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';

class ProfileBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ThemeModeController());
  }
}