import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/color_palette.dart';

enum TypeMessage {error, success, warning, informational}

class CustomSnackbar{

  SnackbarController buildSnackbar(String title, String message, TypeMessage type) {
    return Get.snackbar(
        title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: getBackgroundColor(type),
        borderColor: getTextColor(type),
        borderWidth: 2,
        colorText: getTextColor(type),
        icon: Icon(getIcon(type), color: getTextColor(type)),
        shouldIconPulse: false
    );
  }

  Color getBackgroundColor(TypeMessage typeGiven){
    Color finalColor;
    switch (typeGiven) {
      case TypeMessage.informational:
        finalColor =  ColorPalette.informationalColorBackground;
        break;
      case TypeMessage.error:
        finalColor = ColorPalette.errorColorBackground;
        break;
      case TypeMessage.success:
        finalColor = ColorPalette.successColorBackground;
        break;
      case TypeMessage.warning:
        finalColor = ColorPalette.warningColorBackground;
        break;
    }
    return finalColor;
  }

  Color getTextColor(TypeMessage typeGiven){
    Color finalColor;
    switch (typeGiven) {
      case TypeMessage.informational:
        finalColor = ColorPalette.informationalColorText;
        break;
      case TypeMessage.error:
        finalColor = ColorPalette.errorColorText;
        break;
      case TypeMessage.success:
        finalColor = ColorPalette.successColorText;
        break;
      case TypeMessage.warning:
        finalColor = ColorPalette.warningColorText;
        break;
    }
    return finalColor;
  }

  IconData getIcon(TypeMessage typeGiven){
    IconData finalIcon;
    switch (typeGiven) {
      case TypeMessage.informational:
        finalIcon = Icons.info_outline;
        break;
      case TypeMessage.error:
        finalIcon = Icons.error_outline;
        break;
      case TypeMessage.success:
        finalIcon = Icons.check;
        break;
      case TypeMessage.warning:
        finalIcon = Icons.warning_amber_outlined;
        break;
    }
    return finalIcon;
  }

}

