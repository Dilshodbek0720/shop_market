import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_market/data/models/products/rating_model.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/icons/app_icons.dart';

class RatingItem extends StatelessWidget {
  const RatingItem({super.key, required this.name, required this.ratingModel});
  final String name;
  final RatingModel ratingModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black),
            ),
          ),
          SizedBox(
            height: 20.r,
            width: 20.r,
            child: SvgPicture.asset(AppIcons.starIcon),
          ),
          Text(
            "${ratingModel.rate}",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: AppColors.black),
          )
        ],
      ),
    );
  }
}