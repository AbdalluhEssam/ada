import 'package:ada/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 50),
        child: Image.asset(AppAssets.logoApp),
        ),
      ),
    );
  }
}
