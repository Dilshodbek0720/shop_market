import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/blocs/client_order_bloc/client_order_bloc.dart';
import 'package:shop_market/ui/tab_box/order/widgets/order_item.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../data/local/storage_repository.dart';
import '../../../data/models/orders/client_order_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/storage_keys.dart';
import '../../../utils/icons/app_icons.dart';
import '../../widgets/global_button.dart';
import '../home/widgets/custom_appbar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Orders",
        isLeading: false,
        isAction: false,
      ),
      body: BlocConsumer<ClientOrderBloc, ClientOrderStates>(
        builder: (context, state){
          List<ClientOrderModel> orders = state.clientOrders;
          return orders.isNotEmpty
              ? Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ...List.generate(
                      orders.length,
                          (index) => OrderItem(
                        imageUrl: orders[index].image,
                        name: orders[index].title,
                        description: orders[index].description,
                        price: double.parse(orders[index].price) *
                            orders[index].count,
                        count: orders[index].count,
                        onTap: (v) {
                          BlocProvider.of<ClientOrderBloc>(context).add(
                              DeleteClientOrderEvent(
                                  clientOrderId: orders[index].id!),
                          );
                          context.read<ClientOrderBloc>().add(GetClientOrderEvent());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              StorageRepository.getString(StorageKeys.userRole) == AppConstants.client ? Container(
                decoration: const BoxDecoration(
                    color: AppColors.c_EDF0EF
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                      child: Row(children: [
                        Text("Grand Total", style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600
                        ),),
                        const Spacer(),
                        Text("\$ totalPrice(orders)", style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600
                        ),),
                      ],),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: GlobalButton(title: "PAY NOW", onTap: (){

                      }),
                    ),
                    8.ph
                  ],
                ),
              ) : const SizedBox()
            ],
          ) : Column(
          children: [
          Expanded(
          child: Center(
          child: Lottie.asset(AppIcons.emptyLottie),
          ),
          )
          ],
          );
        },
        listener: (context, state){

        },
      ),
    );
  }
}