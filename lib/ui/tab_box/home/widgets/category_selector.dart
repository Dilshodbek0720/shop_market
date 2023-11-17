import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../utils/colors/app_colors.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(categories.length+1, (index) {
            return ZoomTapAnimation(
              onTap: (){
                if(index==0){
                  onCategorySelected.call("");
                }else{
                  onCategorySelected.call(categories[index-1]);
                }
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.black.withOpacity(0.1),
                  ),
                  margin: EdgeInsets.only(left: index==0 ? 20.w : 8.w, right: categories.length==index ? 20.w : 8.w),
                  child: Center(child: Text(index==0 ? "All" : categories[index-1], style: TextStyle(color: Colors.black, fontSize: 20.sp),))),
            );
          })
        ],
      ),
    );
  }
}