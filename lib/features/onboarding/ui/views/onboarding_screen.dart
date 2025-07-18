import 'package:ada/features/onboarding/ui/cubit/onboading_cubit.dart';
import 'package:ada/features/onboarding/ui/views/widgets/custom_body_onboarding.dart';
import 'package:ada/features/onboarding/ui/views/widgets/custom_bottom_onboarding.dart';
import 'package:ada/features/onboarding/ui/views/widgets/custom_header_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/reops/onboarding_data.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                CustomHeaderOnboarding(),
                Expanded(flex: 2, child: CustomBodyOnboarding()),
                CustomBottomOnboarding(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
