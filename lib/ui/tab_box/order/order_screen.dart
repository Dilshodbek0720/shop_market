import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/blocs/client_order_bloc/client_order_bloc.dart';
import 'package:shop_market/data/local/storage_repository.dart';
import 'package:shop_market/data/models/orders/admin_order_model.dart';
import 'package:shop_market/ui/tab_box/order/widgets/client_order_item.dart';
import 'package:shop_market/utils/constants/constants.dart';
import 'package:shop_market/utils/constants/storage_keys.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../data/models/orders/client_order_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/icons/app_icons.dart';
import '../../../utils/ui_utils/total_price.dart';
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
        builder: (context, state) {
          List<ClientOrderModel> clientOrders = state.clientOrders;
          List<AdminOrderModel> adminOrders = state.adminOrders;

          return StorageRepository.getString(StorageKeys.userRole) == AppConstants.client ? clientOrders.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ...List.generate(
                            clientOrders.length,
                            (index) => ClientOrderItem(
                              imageUrl: clientOrders[index].image,
                              name: clientOrders[index].title,
                              description: clientOrders[index].description,
                              price: double.parse(clientOrders[index].price) *
                                  clientOrders[index].count,
                              count: clientOrders[index].count,
                              onTap: (v) {
                                BlocProvider.of<ClientOrderBloc>(context).add(
                                  DeleteClientOrderEvent(
                                      clientOrderId: clientOrders[index].id!),
                                );
                                context.read<ClientOrderBloc>().add(GetClientOrderEvent());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                            decoration:
                                const BoxDecoration(color: AppColors.c_EDF0EF),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.w, vertical: 12.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Grand Total",
                                        style: TextStyle(
                                            fontFamily: "Raleway",
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "\$ ${totalPrice(clientOrders)}",
                                        style: TextStyle(
                                            fontFamily: "Raleway",
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  child: GlobalButton(
                                      title: "PAY NOW", onTap: () {}),
                                ),
                                8.ph
                              ],
                            ),
                          )
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Lottie.asset(AppIcons.emptyLottie),
                      ),
                    )
                  ],
                ):
              adminOrders.isNotEmpty ?
                  Column(children: [
                    ...List.generate(adminOrders.length, (index) => Text(adminOrders[index].date))
                  ],) :
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Lottie.asset(AppIcons.emptyLottie),
                    ),
                  )
                ],
              )
          ;
        },
        listener: (context, state) {},
      ),
    );
  }
}
