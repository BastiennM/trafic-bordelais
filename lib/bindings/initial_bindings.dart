import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';

import '../controller/home_controller.dart';
import '../core/utils/pref_utils.dart';
import '../core/utils/network.dart';
import '../core/app_export.dart';


class InitialBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(PrefUtils());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    Get.put(HomeController());
  }
}
