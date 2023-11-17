import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/blocs/product_bloc/product_bloc.dart';
import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/data/models/universal_data.dart';
import 'package:shop_market/data/repository/product_repository.dart';
import 'package:shop_market/ui/tab_box/home/widgets/custom_text_field.dart';
import 'package:shop_market/ui/tab_box/home/widgets/gridview_item.dart';
import 'package:shop_market/ui/tab_box/home/widgets/home_appbar.dart';
import 'package:shop_market/utils/size/screen_size.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../data/local/storage_repository.dart';
import '../../../utils/icons/app_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // context.read<ProductBloc>()..add(GetCategoryProductsEvent(categoryName: ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 60.h),
            child: const HomeAppbar()),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ProductBloc, ProductStates>(
                builder: (context, state){
                  List<ProductModel> products = state.products;
                  return ListView(
                    children: [
                      CustomTextField(
                          hintText: "Search anything",
                          isSearch: true,
                          onChanged: (v) {
                            // setState(() {
                            //   // coffees = searchByName(snapshot.data!, v);
                            // });
                          }),
                      products.isNotEmpty ?
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 12.h),
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 160 / 277.sp,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 10.h),
                          children: List.generate(
                              products.length,
                                  (index) => GridviewItem(
                                  onTap: () {
                                    // StorageRepository.getString(
                                    //     StorageKeys.userRole) ==
                                    //     AppConstants.client
                                    //     ? Navigator.pushNamed(context,
                                    //     RouteNames.detailScreen,
                                    //     arguments: coffees[index])
                                    //     : Navigator.push(context, MaterialPageRoute(builder: (context){
                                    //   return AddScreen(coffeeModel: coffees[index],);
                                    // }));
                                  },
                                  productModel: products[index])),
                        ),
                      ) :
                      Column(
                        children: [
                          35.ph,
                          Lottie.asset(AppIcons.emptyLottie),
                        ],
                      )
                    ],
                  );
                },
                listener: (context, state){

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}