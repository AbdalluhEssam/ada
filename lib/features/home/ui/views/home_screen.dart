import 'package:ada/core/theme/app_colors.dart';
import 'package:ada/core/utils/extensions/navigation_extensions.dart';
import 'package:ada/core/widgets/custom_text_form_field.dart';
import 'package:ada/features/home/data/repos/news_api_repo.dart';
import 'package:ada/features/home/ui/cubit/home_cubit.dart';
import 'package:ada/features/home/ui/views/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.dart';
import '../../data/models/news_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeCubit(NewsApiRepo())
                ..getDate()
                ..getNews()
                ..requestPermission(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: AppColor.primaryColor),
              onPressed: () {
                context.read<HomeCubit>().signOut();
              },
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
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
          child: Column(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder:
                    (context, state) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CustomTextFormField(
                        hintText: "Search for news",
                        prefixIcon: Icon(Icons.search),
                        onChanged: (value) {
                          context.read<HomeCubit>().getNews(value.isEmpty ? null : value);
                          print(value);
                        },
                      ),
                    ),
              ),

              Expanded(
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
                      return ListView.builder(
                        itemCount: state.news.length,
                        itemBuilder:
                            (context, index) => GestureDetector(
                              onTap: () {
                                context.pushNamed(Routes.newsDetailsScreen,arguments: state.news[index]);
                              },
                              child: NewsCard(news: state.news[index]),
                            ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
