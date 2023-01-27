import 'package:flutter/material.dart';

class CustomProgressIndicator extends SizedBox {
  CustomProgressIndicator({super.key,
    double width = 20.0,
    double height = 20.0,
    double strokeWidth = 2.0,
    Color backgroundColor = Colors.transparent,
    Color valueColor = Colors.deepPurple,
  }) : super(
    child: CircularProgressIndicator(
      backgroundColor: backgroundColor,
      valueColor: AlwaysStoppedAnimation<Color>(valueColor),
      strokeWidth: strokeWidth,
    ),
    width: width,
    height: height,
  );
}