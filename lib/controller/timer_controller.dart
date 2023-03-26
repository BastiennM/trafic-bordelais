import 'package:get/get.dart';
import 'package:trafic_bordeaux/controller/home_controller.dart';

class TimerController extends GetxController {
  HomeController homeController = Get.put(HomeController());

  var timeLeft = 10.obs; // 5 minutes = 300 seconds

  TimerController(){
    startTimer();
  }

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 1));
    if (timeLeft.value > 0) {
      timeLeft.value--;
      startTimer();
    } else {
      resetTimer();
      startTimer();
    }
  }

  void resetTimer() {
    homeController.fetchAllData();
    homeController.updatePolylines();
    timeLeft.value = 300;
  }

  String getFormattedTime() {
    int minutes = (timeLeft.value / 60).floor();
    int seconds = timeLeft.value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}s';
  }
}