import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString homeText = "Home text".obs;

  updateHomeName(String name) {
    homeText(name);
  }
}
