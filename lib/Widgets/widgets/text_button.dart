import 'package:flutter/material.dart';
class TextButton extends StatelessWidget {
  final Text text;
  final VoidCallback onTap;
  const TextButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: text,
    );
  }
}
