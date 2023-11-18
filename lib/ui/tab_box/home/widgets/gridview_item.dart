import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/utils/size/size_extension.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/icons/app_icons.dart';
import '../../../../utils/size/screen_size.dart';

class GridviewItem extends StatelessWidget {
  const GridviewItem({super.key, required this.onTap, required this.productModel});
  final VoidCallback onTap;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: AppColors.orangeTransparent,
            borderRadius: BorderRadius.circular(20.r)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                height: 190 * MediaQuery.of(context).size.height / figmaHeight,
                width: 190 * MediaQuery.of(context).size.height / figmaHeight,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(20.r)),
                child: CachedNetworkImage(
                  imageUrl: productModel.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Lottie.asset(AppIcons.loading)
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            12.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(productModel.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 16.sp,
                    color: AppColors.c_003B40,
                    fontWeight: FontWeight.w700
                ),),
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text("\$ ${productModel.price}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 18.sp,
                          color: AppColors.c_003B40,
                          fontWeight: FontWeight.w700
                      ),),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 20.r,
                    width: 20.r,
                    child: SvgPicture.asset(AppIcons.starIcon),
                  ),
                  Text(
                    "${productModel.ratingModel.rate}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: AppColors.black),
                  ),
                  8.pw,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}