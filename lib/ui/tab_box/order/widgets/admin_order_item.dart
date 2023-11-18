import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/data/models/orders/admin_order_model.dart';
import 'package:shop_market/data/models/user/user_model.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../../data/models/products/product_model.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/icons/app_icons.dart';

class AdminOrderItem extends StatelessWidget {
  const AdminOrderItem({super.key,required this.onTap, required this.userModel, required this.adminOrderModel, required this.products});
  final ValueChanged onTap;
  final UserModel userModel;
  final AdminOrderModel adminOrderModel;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
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
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.c_EDF0EF
            ),
            child: ExpansionTile(
              title: Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${userModel.nameModel.firstname.substring(0,1).toUpperCase()}${userModel.nameModel.firstname.substring(1)} ${userModel.nameModel.lastname.substring(0,1).toUpperCase()}${userModel.nameModel.lastname.substring(1)}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w600,
                        color: AppColors.c_003B40,
                      ),
                    ),
                    4.ph,
                    Text(userModel.phone,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w600,
                        color: AppColors.c_003B40,
                      ),
                    ),
                  ],
                ),
              ],),
              children: [
                ...List.generate(adminOrderModel.products.length, (index) => SizedBox(
                  child: Row(
                    children: [
                    Stack(
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.w,
                          margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: CachedNetworkImage(
                              imageUrl: products[adminOrderModel.products[index].productId].image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Padding(
                                  padding: EdgeInsets.all(10.r),
                                  child: Lottie.asset(AppIcons.loading)
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle
                          ),
                            child: Text(adminOrderModel.products[index].quantity.toString()))
                      ],
                    ),
                      12.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[adminOrderModel.products[index].productId].title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600,
                                color: AppColors.c_003B40,
                              ),),
                            4.ph,
                            Text("\$ ${products[adminOrderModel.products[index].productId].price}",
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
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}