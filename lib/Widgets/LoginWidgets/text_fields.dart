import 'package:flutter/material.dart';
Widget myTextField(double heightSize, double widthSize, TextEditingController controller, bool isPassword, Widget icon, String hintText, TextInputType textInputType){
  return Container(
    height: heightSize,
    width: widthSize,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(.3),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white.withOpacity(.9),
      ),
      obscureText: isPassword,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: icon,
        border: InputBorder.none,
        hintMaxLines: 1,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(.9),
        ),
      ),
    ),
  );
}