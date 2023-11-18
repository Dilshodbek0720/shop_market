import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/blocs/product_bloc/product_bloc.dart';
import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/data/models/universal_data.dart';
import 'package:shop_market/data/repository/product_repository.dart';
import 'package:shop_market/ui/tab_box/home/widgets/category_selector.dart';
import 'package:shop_market/ui/tab_box/home/widgets/custom_text_field.dart';
import 'package:shop_market/ui/tab_box/home/widgets/gridview_item.dart';
import 'package:shop_market/ui/tab_box/home/widgets/home_appbar.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../data/local/storage_repository.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/storage_keys.dart';
import '../../../utils/icons/app_icons.dart';
import '../../../utils/ui_utils/search_by_name.dart';
import '../../app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  List<String> categories = [];
  String activeCategoryName = "";
  bool isLoading = false;
  int selectedIndex = 0;

  @override
  void initState() {
    _updateCategories();
    _updateProducts();
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
                  return ListView(
                    children: [
                      CustomTextField(
                          hintText: "Search anything",
                          isSearch: true,
                          onChanged: (v) {
                            setState(() {
                              products = searchByName(state.products, v);
                            });
                          }),
                      CategorySelector(categories: categories, onCategorySelected: (selectedCategory) {
                        if (selectedCategory == 0) {
                          activeCategoryName = "";
                        } else {
                          activeCategoryName = categories[selectedCategory-1];
                        }
                        selectedIndex = selectedCategory;
                        _updateProducts();
                      }, selectedIndex: selectedIndex,),
                      products.isNotEmpty ?
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 12.h),
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 160 / 265.sp,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 10.h),
                          children: List.generate(
                              products.length,
                                  (index) => GridviewItem(
                                  onTap: () {
                                    StorageRepository.getString(
                                        StorageKeys.userRole) ==
                                        AppConstants.client
                                        ? Navigator.pushNamed(context,
                                        RouteNames.detailScreen,
                                        arguments: products[index])
                                        : Navigator.pushNamed(context,
                                        RouteNames.detailScreen,
                                        arguments: products[index]);
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

  _updateCategories() async {
    isLoading = true;
    UniversalData data = await context.read<ProductRepository>().getAllCategoriesProducts();
    isLoading = false;
    categories = data.data;
    if(mounted){
      setState(() {

      });
    }
  }

  _updateProducts() async {
    UniversalData data = await context.read<ProductRepository>().getCategoryProducts(categoryName: activeCategoryName);
    products = data.data;
    if(mounted){
      setState(() {

      });
    }
  }
}