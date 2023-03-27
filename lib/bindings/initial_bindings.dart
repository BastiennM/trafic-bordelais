import '../controller/home_controller.dart';
import '../core/app_export.dart';


class InitialBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(HomeController());
  }
}
