import 'package:get/get.dart';
import '../controller/design_system_controller.dart';

class DesignSystemBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DesignSystemController());
  }
}