import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../utils/colors/app_colors.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(widget.categories.length + 1, (index) {
            return ZoomTapAnimation(
              onTap: () {
                if (index == 0) {
                  widget.onCategorySelected.call("");
                } else {
                  widget.onCategorySelected.call(widget.categories[index - 1]);
                }
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: selectedIndex == index ? Colors.green : AppColors.black.withOpacity(0.1),
                ),
                margin: EdgeInsets.only(
                    left: index == 0 ? 20.w : 8.w,
                    right: widget.categories.length == index ? 20.w : 8.w),
                child: Center(
                  child: Text(
                    index == 0 ? "All" : widget.categories[index - 1],
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
