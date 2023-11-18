import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_market/blocs/client_order_bloc/client_order_bloc.dart';
import 'package:shop_market/data/local/storage_repository.dart';
import 'package:shop_market/data/models/orders/client_order_model.dart';
import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/ui/app_routes.dart';
import 'package:shop_market/utils/constants/constants.dart';
import 'package:shop_market/utils/constants/storage_keys.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import 'package:shop_market/utils/ui_utils/custom_toast.dart';
import '../../../../cubits/tab/tab_cubit.dart';
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
                20.ph
              ],
            ),
          ),
          12.ph,
          CounterItem(
            count: count,
            onTap: (){
              if(StorageRepository.getString(StorageKeys.userRole) == AppConstants.client){
                context.read<TabCubit>().changeTabIndex(1);
                BlocProvider.of<ClientOrderBloc>(context).add(AddClientOrderEvent(clientOrderModel: ClientOrderModel(
                  productId: widget.productModel.id,
                  description: widget.productModel.description,
                  price: widget.productModel.price.toString(),
                  title: widget.productModel.title,
                  image: widget.productModel.image,
                  count: count,
                )));
                context.read<ClientOrderBloc>().add(GetClientOrderEvent());
                customToast(message: "Product muvoffaqqiyatli qo'shildi!", color: Colors.green);
                Navigator.pushReplacementNamed(context, RouteNames.tabBoxScreen);
              } else {
                customToast(message: "Admin order qo'sha olmaydi!", color: Colors.red);
              }
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