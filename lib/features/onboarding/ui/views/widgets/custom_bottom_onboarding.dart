import 'package:ada/core/routing/routes.dart';
import 'package:ada/core/utils/extensions/navigation_extensions.dart';
import 'package:ada/features/onboarding/data/reops/onboarding_data.dart';
import 'package:ada/features/onboarding/ui/cubit/onboading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import 'custom_text_button.dart';

class CustomBottomOnboarding extends StatelessWidget {
  const CustomBottomOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, state) {
        final controller = context.read<OnboardingCubit>();
        final isLastPage = state == (onboardingPages.length - 1);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              replacement: SizedBox(
                width: 60, // Adjust width as needed
              ),
              visible: state != 0,
              child: CustomTextButton(
                text: 'Prev',
                color: AppColor.textGray,
                onPressed: () {
                  controller.previousPage();
                },
              ),
            ),

            Row(
              children: [
                ...List.generate(
                  onboardingPages.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: index == state ? 40 : 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color:
                          index == state ? AppColor.black : AppColor.textGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            CustomTextButton(
              text:
                  state == (onboardingPages.length - 1)
                      ? 'Get Started'
                      : 'Next',
              color: AppColor.primaryColor,
              onPressed: () {
                if (isLastPage) {
                  context.pushNamedAndRemoveUntil(Routes.loginScreen);
                } else {
                  controller.nextPage();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
