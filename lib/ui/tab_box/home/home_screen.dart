import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_market/blocs/product_bloc/product_bloc.dart';
import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/data/models/universal_data.dart';
import 'package:shop_market/data/repository/product_repository.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../data/local/storage_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    context.read<ProductBloc>().add(GetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // 16.ph,
            // const HomeAppbar(),
            10.ph,
            Expanded(
              child: BlocConsumer<ProductBloc, ProductStates>(
                builder: (context, state){
                  List<ProductModel> products = state.products;
                  return ListView(
                    children: [
                      ...List.generate(products.length, (index) => Text(products[index].title))
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