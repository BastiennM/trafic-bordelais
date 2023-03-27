import 'package:get/get.dart';
import 'package:trafic_bordeaux/controller/home_controller.dart';

class TimerController extends GetxController {
  HomeController homeController = Get.put(HomeController());

  var timeLeft = 300.obs; // 5 minutes = 300 seconds
  var resetCount = 0; // nombre de fois que resetTimer a été appelé
  var lastResetTime = DateTime.now(); // temps de la dernière exécution de resetTimer
  var canReset = true.obs; // indication si la fonction resetTimer est disponible pour l'utilisateur

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
    // Vérifiez si la limite de temps est respectée et si la fonction est disponible pour l'utilisateur
    if (canReset.value && DateTime.now().difference(lastResetTime).inSeconds >= 1) {
      homeController.fetchAllData();
      homeController.updatePolylines();
      timeLeft.value = 300;
      resetCount++;
      lastResetTime = DateTime.now();
      // Verrouillez la fonction resetTimer si elle a été appelée deux fois dans les 3 dernières secondes
      if (resetCount >= 1) {
        canReset.value = false;
        Future.delayed(const Duration(seconds: 1), () {
          canReset.value = true;
          resetCount = 0;
          lastResetTime = DateTime.now();
        });
      }
    }
  }

  String getFormattedTime() {
    int minutes = (timeLeft.value / 60).floor();
    int seconds = timeLeft.value % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}s';
  }
}