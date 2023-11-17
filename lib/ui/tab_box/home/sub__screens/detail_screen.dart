import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/utils/size/size_extension.dart';

import '../../../../utils/colors/app_colors.dart';
import '../widgets/counter_item.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/image_item.dart';
import '../widgets/rating_item.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedIndex = 0;
  int selectSize = 0;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Detail", isLeading: true,isAction: false),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ImageItem(imageUrl: widget.productModel.image, imageSize: 1.2),
                12.ph,
                RatingItem(name: widget.productModel.title, ratingModel: widget.productModel.ratingModel),
                4.ph,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: Text(
                    "(\$${widget.productModel.price*count})",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                ),
                8.ph,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    widget.productModel.description,
                    style: TextStyle(
                        color: AppColors.c_9D9D9D,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                25.ph,
                // SelectTypeItem(valueChanged: (v) {}),
                // 25.ph,
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 30.w),
                //   child: Text(
                //     "Choose size",
                //     style: TextStyle(
                //         fontSize: 18.sp,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                // 20.ph,
                // SizeItem(valueChanged: (v) {
                //   setState(() {
                //     selectSize = v;
                //   });
                // }),
                20.ph
              ],
            ),
          ),
          12.ph,
          CounterItem(
            count: count,
            onTap: (){

            }, minusOnTap: () {
            if(count>1){
              setState(() {
                count--;
              });
            }
          }, plusOnTap: () {
            if(widget.productModel.ratingModel.count>count){
              setState(() {
                count++;
              });
            }
          },),
          12.ph
        ],
      ),);
  }
}