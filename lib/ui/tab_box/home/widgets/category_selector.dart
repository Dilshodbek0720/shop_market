import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_market/utils/ui_utils/to_upper_word.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../utils/colors/app_colors.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    required this.selectedIndex,
  });

  final List<String> categories;
  final ValueChanged<int> onCategorySelected;
  final int selectedIndex;

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {

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
                widget.onCategorySelected.call(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: widget.selectedIndex == index ? Colors.green : AppColors.black.withOpacity(0.1),
                  border: Border.all(width: 0.5, color: AppColors.c_003B40)
                ),
                margin: EdgeInsets.only(
                    left: index == 0 ? 20.w : 8.w,
                    right: widget.categories.length == index ? 20.w : 8.w),
                child: Center(
                  child: Text(
                    index == 0 ? "All" : toUpperWord(word: widget.categories[index - 1]),
                    style: TextStyle(color: widget.selectedIndex == index ? Colors.white : Colors.black, fontSize: 16.sp),
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
