import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomBodyOnboarding extends StatelessWidget {
  const CustomBodyOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppAssets.onboarding1, width: 300, height: 300),
        SizedBox(height: 16),
        Text(
          "Choose Products",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.textGray,
            height: 2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
