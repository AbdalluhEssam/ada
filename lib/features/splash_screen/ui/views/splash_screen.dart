import 'dart:async';

import 'package:ada/core/constants/app_assets.dart';
import 'package:ada/core/routing/routes.dart';
import 'package:ada/core/utils/extensions/navigation_extensions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double opacity = 0.0;

  @override
  void initState() {
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
    Timer(Duration(seconds: 3), () {
      context.pushNamedAndRemoveUntil(Routes.onboardingScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: opacity,
          duration: Duration(seconds: 3),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset(AppAssets.logoApp),
          ),
        ),
      ),
    );
  }
}
