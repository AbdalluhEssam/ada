import 'package:flutter/material.dart';

import 'custom_text_button.dart';

class CustomHeaderOnboarding extends StatelessWidget {
  const CustomHeaderOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
            text: "1",
            children: [
              TextSpan(
                text: "/3",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        CustomTextButton(text: "Skip"),
      ],
    );
  }
}
