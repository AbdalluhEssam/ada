import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? color;

  const CustomTextButton({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
