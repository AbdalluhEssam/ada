import 'package:ada/core/constants/app_assets.dart';
import 'package:ada/core/theme/app_colors.dart';
import 'package:ada/core/utils/extensions/navigation_extensions.dart';
import 'package:ada/core/widgets/custom_text_form_field.dart';
import 'package:ada/features/home/data/repos/news_api_repo.dart';
import 'package:ada/features/home/ui/cubit/home_cubit.dart';
import 'package:ada/features/home/ui/views/widgets/custom_row_title.dart';
import 'package:ada/features/home/ui/views/widgets/news_card.dart';
import 'package:ada/features/home/ui/views/widgets/news_clock_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/routing/routes.dart';
import '../../data/models/news_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String isArabic(String ar, String en) {
      if (context.locale.languageCode == 'ar') {
        return ar;
      } else {
        return en;
      }
    }

    void changeLanguage(BuildContext context) async {
      if (context.locale.languageCode == 'en') {
        await context.setLocale(Locale('ar'));
      } else {
        await context.setLocale(Locale('en'));
      }
    }

    return BlocProvider(
      create:
          (context) =>
              HomeCubit(NewsApiRepo())
                ..getDate()
                ..getNews()
                ..requestPermission(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocListener<HomeCubit, HomeState>(
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  children: [
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        print(context.supportedLocales);
                        print(tr('hello'));
                        print(tr('welcome'));
                        print(tr('goodbye'));

                        final controller = context.read<HomeCubit>();
                        return Column(
                          children: [
                            Text(
                              isArabic("اهلا بيك", "Hello"),
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            8.verticalSpace,
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.logoInApp,
                                  height: 30.h,
                                  // width: 99.w,
                                  // fit: BoxFit.cover,
                                ),
                                Spacer(),
                                Container(
                                  width: 35.w,
                                  height: 35.h,

                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(6.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(
                                          0,
                                          3,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.notifications,
                                      color: AppColor.black,
                                    ),
                                    onTap: () async {
                                      changeLanguage(context);
                                      // context.read<HomeCubit>().signOut();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            40.verticalSpace,
                            CustomTextFormField(
                              hintText: "Search",
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                color: AppColor.black,
                              ),
                              suffixIcon: Icon(
                                Icons.tune,
                                color: AppColor.black,
                              ),
                              onChanged: (value) {
                                controller.getNews(
                                  value.isEmpty ? null : value,
                                );
                                print(value);
                              },
                            ),
                            16.verticalSpace,
                            CustomRowTitle(title: "Trending"),
                            16.verticalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  width: 365.w,
                                  height: 185.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(
                                          0,
                                          3.h,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),

                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://www.navalnews.com/wp-content/uploads/2020/04/Russian_cruiser_Moskva.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                12.verticalSpace,
                                Text(
                                  "Europe",
                                  style: TextStyle(
                                    color: AppColor.seeColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  "Russian warship: Moskva sinks in Black Sea",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                4.verticalSpace,
                                NewsClockWidget(),
                                24.verticalSpace,
                                CustomRowTitle(title: "Latest"),
                                16.verticalSpace,
                                SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (context, index) => GestureDetector(
                                          onTap: () {
                                            controller.getNewsByCategory(
                                              controller.categories[index],
                                              index,
                                            );
                                          },
                                          child: IntrinsicWidth(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  controller
                                                          .categories[index][0]
                                                          .toUpperCase() +
                                                      controller
                                                          .categories[index]
                                                          .substring(1),
                                                  style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                4.verticalSpace,
                                                Container(
                                                  height: 2.5.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        controller.currentIndex ==
                                                                index
                                                            ? AppColor
                                                                .primaryColor
                                                            : Colors
                                                                .transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12.r,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    separatorBuilder:
                                        (context, index) =>
                                            SizedBox(width: 12.w),
                                    itemCount: controller.categories.length,
                                  ),
                                ),
                              ],
                            ),
                            //
                          ],
                        );
                      },
                    ),

                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        final controller = context.read<HomeCubit>();
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
                          return Column(
                            children: [
                              ListView.separated(
                                itemCount: state.news.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (context, index) => GestureDetector(
                                      onTap: () {
                                        context.pushNamed(
                                          Routes.newsDetailsScreen,
                                          arguments: state.news[index],
                                        );
                                      },
                                      child: NewsCard(news: state.news[index]),
                                    ),
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 16.h),
                              ),
                            ],
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
