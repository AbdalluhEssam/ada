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
                ..requestPermission(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
           if (state is HomeSignOut) {
             context.pushNamedAndRemoveUntil(Routes.splashScreen);
           }
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.primaryColor,
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
                    children: [
                      Image.network("${state.user!.photoURL}"),
                      Text('Welcome, ${state.user!.displayName ?? 'User'}!'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Logout'),
                        onPressed: () {
                          context.read<HomeCubit>().signOut();
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Send Verification Email'),
                        onPressed: () {
                          context.read<HomeCubit>().sendEmailVerification();
                        },
                      ),
                    ],
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
