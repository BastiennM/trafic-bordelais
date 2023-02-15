import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/constants/color_palette.dart';
import 'custom_progress_indicator.dart';

enum TypeButton { error, warning, success, informational, initial}

class CustomButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback onPressed;
  final bool disabled;
  final bool isKeyboardVisible;
  final bool fill;
  final bool needIcon;
  final double width;
  final double height;
  final Widget? icon;
  final Color? color;
  final TypeButton type;

  const CustomButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.color,
      this.loading = false,
      this.disabled = false,
      this.needIcon = false,
      this.isKeyboardVisible = false,
      this.height = 20,
      this.width = 50,
      this.fill = true,
      this.type = TypeButton.initial});

  @override
  Widget build(BuildContext context) {
    CustomProgressIndicator customProgressIndicator = CustomProgressIndicator(context,valueColor: fill ? Colors.white : getColor);

    return Container(
      decoration: BoxDecoration(
        border: !fill ? Border.all(color: getColor) : null,
        borderRadius: BorderRadius.circular(9),
      ),
      child: CupertinoButton(
          onPressed: !disabled && !loading ? onPressed : null,
          color: fill ? getColor : Colors.transparent,
          disabledColor: loading && fill
              ? getColor
              : !fill
                  ? Colors.transparent
                  : ColorPalette.grey50,
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: loading
                ? customProgressIndicator.show()
                : !needIcon
                    ? getText(context)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Row contents horizontally,
                        children: [
                            getIcon,
                            const SizedBox(width: 6),
                            getText(context),
                          ]),
          )),
    );
  }

  Widget getText(context) {
    return Text(label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: disabled || onPressed == null
                  ? ColorPalette.grey200
                  : fill
                      ? Colors.white
                      : color ?? Theme.of(Get.key.currentContext!).primaryColor,
            ));
  }

  Color get getColor{
    Color finalColor;
    switch (type) {
      case TypeButton.informational:
        finalColor = color ?? ColorPalette.informationalColorText;
        break;
      case TypeButton.error:
        finalColor = color ?? ColorPalette.errorColorText;
        break;
      case TypeButton.success:
        finalColor = color ?? ColorPalette.green50;
        break;
      case TypeButton.warning:
        finalColor = color ?? Colors.orangeAccent;
        break;
      case TypeButton.initial:
        finalColor = color ?? Theme.of(Get.key.currentContext!).primaryColor;
        break;
    }
    return finalColor;
  }

  Widget get getIcon{
    Widget finalIcon;
    switch (type) {
      case TypeButton.informational:
        finalIcon = icon ?? const Icon(Icons.info_outline, color:Colors.white);
        break;
      case TypeButton.error:
        finalIcon = icon ?? const Icon(Icons.error_outline_outlined, color:Colors.white);
        break;
      case TypeButton.success:
        finalIcon = icon ?? const Icon(Icons.check, color:Colors.white);
        break;
      case TypeButton.warning:
        finalIcon = icon ?? const Icon(Icons.warning_amber_outlined, color:Colors.white);
        break;
      case TypeButton.initial:
        finalIcon = icon ?? Container();
        break;
    }
    return finalIcon;
  }
}
