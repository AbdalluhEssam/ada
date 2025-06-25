import 'package:ada/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      initialRoute: Routes.splashScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
