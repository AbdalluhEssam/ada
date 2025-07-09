import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;

  void signOut() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    auth.signOut();
    prefs.clear();
    emit(HomeSignOut());
  }
  sendEmailVerification() async {
    final user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user?.updateProfile(displayName: "Abdalluh Essam" , photoURL: "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg");
      print("Verification email sent to ${user.email}");
    } else {
      print("User is null or email already verified");
    }
  }
  Future<void> requestPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      getToken();
    }
  }

  getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      print("FCM Token: $fcmToken");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("fcmToken", fcmToken);
      print("Saved FCM Token: ${prefs.getString("fcmToken")}");
    } else {
      print("Failed to get FCM token");
    }
  }

  void getDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(HomeLoading());
    final user = auth.currentUser;
    print("user :${user?.email}");
    if (user != null) {
      await prefs.setString("email", user.email.toString());
      print("prefs : ${prefs.getString("email")}");
      emit(HomeSuccess(user));
    } else {
      emit(HomeError('User not found'));
    }
  }
}
