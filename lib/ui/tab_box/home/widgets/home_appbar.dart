import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/icons/app_icons.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'Welcome back, ',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.sp),
                ),
                TextSpan(
                  text: 'Alibek',
                  style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.c_FFB067, fontSize: 22.sp),
                ),
              ],
            ),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: SizedBox(
              height: 44.w,
              width: 44 .w,
              child: Image.asset(AppIcons.dialogImage, fit: BoxFit.cover,),
            ),
          )
        ],
      ),
    );
  }
}