import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/constants/color_palette.dart';

enum TypeIconButton {filled, outlined, icon}

class CustomIconButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final TypeIconButton type;

  const CustomIconButton(
      {super.key, required this.onPressed, required this.icon, this.iconColor, this.backgroundColor, this.type = TypeIconButton.filled});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: finalBackgroundColor,
        shape: CircleBorder(side: type == TypeIconButton.outlined ? BorderSide.lerp(BorderSide(color: Theme.of(context).primaryColor), BorderSide(color: Theme.of(context).primaryColor), 3) : BorderSide.none),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: finalIconColor,
      ),
    );
  }

  Color get finalIconColor{
    Color finalColor;
    switch (type) {
      case TypeIconButton.filled:
        finalColor = iconColor ?? ColorPalette.white;
        break;
      case TypeIconButton.outlined:
        finalColor = iconColor ?? Theme.of(Get.key.currentContext!).primaryColor;
        break;
      case TypeIconButton.icon:
        finalColor = iconColor ?? Theme.of(Get.key.currentContext!).primaryColor;
        break;
    }

    return finalColor;
  }

  Color get finalBackgroundColor{
    Color finalColor;
    switch (type) {
      case TypeIconButton.filled:
        finalColor = backgroundColor ?? Theme.of(Get.key.currentContext!).primaryColor;
        break;
      case TypeIconButton.outlined:
        finalColor = backgroundColor ?? Colors.transparent;
        break;
      case TypeIconButton.icon:
        finalColor = backgroundColor ?? Colors.transparent;
        break;
    }

    return finalColor;
  }
}
