import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'custom_text_button.dart';

class CustomBottomOnboarding extends StatelessWidget {
  const CustomBottomOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextButton(text: 'Prev', color: AppColor.textGray),

        Row(
          children: [
            ...List.generate(
              3,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: index == 0 ? 40 : 10,
                height: 10,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == 0 ? AppColor.black : AppColor.textGray,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        CustomTextButton(text: 'Next', color: AppColor.primaryColor),
      ],
    );
  }
}
