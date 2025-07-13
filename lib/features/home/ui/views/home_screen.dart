import 'package:ada/core/theme/app_colors.dart';
import 'package:ada/core/utils/extensions/navigation_extensions.dart';
import 'package:ada/features/home/ui/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeCubit()
                ..getDate()
                ..getNews()
                ..requestPermission(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeSignOut) {
              context.pushNamedAndRemoveUntil(Routes.splashScreen);
            }
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.yellow,
                        color: AppColor.primaryColor,
                        strokeWidth: 5,
                        semanticsLabel: 'Loading',
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is HomeError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is HomeSuccess) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text("Data : ${state.news.first.content}")],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
