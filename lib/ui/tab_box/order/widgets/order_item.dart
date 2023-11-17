import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/icons/app_icons.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.imageUrl, required this.name, required this.description, required this.price, required this.onTap, required this.count});
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final int count;
  final ValueChanged onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.23,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(20.r),
              onPressed: onTap,
              flex: 1,
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: InkWell(
          onTap: (){ },
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.all(18.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.c_EDF0EF
            ),
            child: Row(children: [
              Container(
                width: 90.w,
                height: 90.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.r)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17.r),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Lottie.asset(AppIcons.loading)
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              25.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name ${count!=1?count:""}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w600,
                        color: AppColors.c_003B40,
                      ),),
                    8.ph,
                    Text(description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w500,
                        color: AppColors.c_003B40,
                      ),
                    ),
                    8.ph,
                    Text("\$ $price",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w600,
                        color: AppColors.c_003B40,
                      ),)
                  ],
                ),
              )
            ],),
          ),
        ),
      ),
    );
  }
}