import 'package:get/get.dart';

class DesignSystemController extends GetxController {
  final RxString homeText = "Home text".obs;

  updateHomeName(String name) {
    homeText(name);
  }
}
