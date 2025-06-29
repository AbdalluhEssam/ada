import 'package:ada/core/routing/routes.dart';
import 'package:ada/features/home/ui/views/home_screen.dart';
import 'package:ada/features/onboarding/ui/views/onboarding_screen.dart';
import 'package:ada/features/splash_screen/ui/views/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../features/test/ui/screen/test_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        return _createRoute(SplashScreen());
      case Routes.onboardingScreen:
        return _createRoute(OnboardingScreen());

      case Routes.homeScreen:
        return _createRoute(HomeScreen());
      case Routes.testScreen:
        return _createRoute(TestScreen());

      default:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }

  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
