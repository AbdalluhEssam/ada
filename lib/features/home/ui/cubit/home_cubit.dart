import 'package:ada/core/constants/endpoint_constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/models/news_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;

  final dio = DioClient();
  List<NewsModel> news = [];

  String apiKey = "a08b245643ce47d593f266a2b3bc7c4f";

  // "https://newsapi.org/v2/everything?q=tesla&from=2025-06-13&sortBy=publishedAt&apiKey=$apiKey",
  getNews() async {
    emit(HomeLoading());
    try {
      var response = await dio.get(
        EndpointConstants.everything,
        queryParameters: {
          "q": "tesla",
          "from": "2025-06-13",
          "sortBy": "publishedAt",
          "apiKey": apiKey,
        },
      );
      news = (response.data['articles'] as List)
              .map((e) => NewsModel.fromJson(e))
              .toList();
      emit(HomeSuccess(news));
    } catch (e) {
      emit(HomeError(e.toString()));
      print("Error : $e");
    }
  }

  void signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    auth.signOut();
    prefs.clear();
    emit(HomeSignOut());
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
      // emit(HomeSuccess(user));
    } else {
      emit(HomeError('User not found'));
    }
  }
}
