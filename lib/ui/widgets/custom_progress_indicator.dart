import 'package:flutter/material.dart';
import 'package:getx_templates/core/utils/navigation_service.dart';

class CustomProgressIndicator {
  final double width;
  final double height;
  final double strokeWidth;
  final Color backgroundColor;
  final Color valueColor;

  const CustomProgressIndicator(
      {this.width = 20.0,
      this.height = 20.0,
      this.strokeWidth = 2,
      this.backgroundColor = Colors.transparent,
      this.valueColor = Colors.deepPurple});

  Widget show() {
    return SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor),
          strokeWidth: strokeWidth,
        )
    );
  }

  void close() {
    Navigator.pop(NavigationService.navigatorKey.currentContext!);
  }
}
