import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "22 December, 2021",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Notes",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        IconButton.outlined(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.all(1)),
            side: MaterialStateProperty.all(
              BorderSide(color: AppColor.primaryColor, width: 1.5.w),
            ),
          ),
          onPressed: () {},
          icon: Icon(
            Icons.more_horiz_outlined,
            color: AppColor.primaryColor,
            size: 25.sp,
          ),
        ),
      ],
    );
  }
}
