import 'package:ada/core/routing/routes.dart';
import 'package:ada/core/theme/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routing/app_router.dart';
import 'core/utils/notification_service.dart';
import 'firebase_options.dart';

// This Api Key: a08b245643ce47d593f266a2b3bc7c4f

bool isLogin = false;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('📩 إشعار من الخلفية: ${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await isLoggedIn();

  await NotificationService.init(); // دي اللي هنشرحها دلوقتي

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.backgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.backgroundColor,
            foregroundColor: Colors.black,
            elevation: 0.0,
          ),
          useMaterial3: true,
          fontFamily: GoogleFonts.nunitoSans().fontFamily,
        ),
        initialRoute: isLogin == true ? Routes.homeNoteScreen : Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}

isLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString("email");
  if (email != null && email.isNotEmpty) {
    isLogin = true;
  } else {
    isLogin = false;
  }
}
