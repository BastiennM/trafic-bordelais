import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {

  Future<void> changeLanguage() async {
    final currentLocal = await getLocal();
    final newLocal = currentLocal == const Locale("fr", "FR") ? const Locale("en", "US") : const Locale("fr", "FR");
    await Get.updateLocale(newLocal);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", Get.locale.toString());
  }

  Future<Locale> getLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString("language");
    switch (languageCode) {
      case "en_US":
        return const Locale("en", "US");
      default:
        return const Locale("fr", "FR");
    }
  }

  Future<void> setLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString("language");
    switch (languageCode) {
      case "en_US":
        Get.updateLocale(const Locale("en", "US"));
        break;
      default:
        Get.updateLocale(const Locale("fr", "FR"));
        break;
    }
  }
}
