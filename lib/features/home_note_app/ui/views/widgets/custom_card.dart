import 'package:ada/features/home_note_app/data/model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class CustomCard extends StatelessWidget {
  final CardModel ? cardModel;

  const CustomCard({super.key, this.cardModel});

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: cardModel?.color ?? AppColor.primaryColor,
              child: Icon(
                cardModel?.icon,
                color: AppColor.white,
                size: 18.sp,

              ),
            ),
            10.horizontalSpace,
            Text(
              cardModel!.title!,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
