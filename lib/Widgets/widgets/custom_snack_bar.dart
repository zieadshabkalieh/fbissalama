import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    BuildContext context,
    String text,
    int duration,
    Color backgroundColor,
    Color textColor,
    int fontSize) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20),
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
