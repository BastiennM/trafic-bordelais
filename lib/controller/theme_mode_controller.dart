import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController extends GetxController {
  RxBool isDark = ThemeMode.system == ThemeMode.dark ? true.obs : false.obs;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await prefs;
    pref.setBool('theme', isDark.value);
  }

  Future<void> setTheme() async {
    SharedPreferences pref = await prefs;
    if (pref.getBool('theme') != null) getThemeStatus();
  }

  getThemeStatus() async {
    var isLight = prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    }).obs;
    isDark.value = (await isLight.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.light : ThemeMode.dark);
  }

  void changeMode() {
    isDark.value = !isDark.value;
    if (isDark.value) {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
    }
  }
}
