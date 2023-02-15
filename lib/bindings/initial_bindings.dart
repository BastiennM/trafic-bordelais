import 'package:trafic_bordeaux/controller/theme_mode_controller.dart';

import '../core/utils/pref_utils.dart';
import '../core/utils/network.dart';
import '../core/app_export.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
  }
}
