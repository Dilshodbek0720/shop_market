import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/blocs/client_order_bloc/client_order_bloc.dart';
import 'package:shop_market/data/local/storage_repository.dart';
import 'package:shop_market/data/models/orders/admin_order_model.dart';
import 'package:shop_market/data/models/universal_data.dart';
import 'package:shop_market/data/repository/product_repository.dart';
import 'package:shop_market/data/repository/user_repository.dart';
import 'package:shop_market/ui/tab_box/order/widgets/admin_order_item.dart';
import 'package:shop_market/ui/tab_box/order/widgets/client_order_item.dart';
import 'package:shop_market/utils/constants/constants.dart';
import 'package:shop_market/utils/constants/storage_keys.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../data/models/orders/client_order_model.dart';
import '../../../data/models/products/product_model.dart';
import '../../../data/models/user/user_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/icons/app_icons.dart';
import '../../../utils/ui_utils/custom_toast.dart';
import '../../../utils/ui_utils/total_price.dart';
import '../../widgets/global_button.dart';
import '../home/widgets/custom_appbar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<UserModel> users = [];
  List<ProductModel> products = [];

  @override
  void initState() {
    _initProducts();
    _initUsers();
    super.initState();
  }
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
          List<ClientOrderModel> clientOrders = [];
          List<AdminOrderModel> adminOrders = [];
          if(StorageRepository.getString(StorageKeys.userRole) == AppConstants.client) {
            clientOrders = state.clientOrders;
          }else {
            adminOrders = state.adminOrders;
          }
          return StorageRepository.getString(StorageKeys.userRole) == AppConstants.client ? (clientOrders.isNotEmpty
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
                                customToast(message: "Order muvoffaqqiyatli o'chirildi!", color: Colors.green);
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
                )):(adminOrders.isNotEmpty&&users.isNotEmpty&&products.isNotEmpty ?
              Column(children: [
                    Expanded(child: ListView(
                      children: [
                        ...List.generate(adminOrders.length, (index) => AdminOrderItem(
                          onTap: (v){ },
                          userModel: users[adminOrders[index].userId],
                          adminOrderModel: adminOrders[index],
                          products: products,
                        ))
                      ],
                    ))
                  ],) :
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Lottie.asset(AppIcons.emptyLottie),
                    ),
                  )
                ],
              ));
        },
        listener: (context, state) {

        },
      ),
    );
  }

  Future<void> _initUsers()async{
    UniversalData userData = await context.read<UserRepository>().getAllUsers();
    users = userData.data;
  }

  Future<void> _initProducts() async {
    UniversalData productData = await context.read<ProductRepository>().getAllProducts();
    products = productData.data;
  }
}
