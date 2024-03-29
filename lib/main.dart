import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_market/blocs/product_bloc/product_bloc.dart';
import 'package:shop_market/cubits/login/login_cubit.dart';
import 'package:shop_market/data/local/storage_repository.dart';
import 'package:shop_market/data/repository/client_order_repository.dart';
import 'package:shop_market/data/repository/login_repository.dart';
import 'package:shop_market/data/repository/product_repository.dart';
import 'package:shop_market/data/repository/user_repository.dart';
import 'package:shop_market/services/api_service.dart';
import 'package:shop_market/ui/app_routes.dart';
import 'package:shop_market/utils/size/screen_size.dart';
import 'blocs/client_order_bloc/client_order_bloc.dart';
import 'cubits/tab/tab_cubit.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(MainApp(apiService: ApiService(),));
}
class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.apiService});
  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => ProductRepository(apiService: apiService)),
      RepositoryProvider(create: (context) => LoginRepository(apiService: apiService)),
      RepositoryProvider(create: (context) => OrderRepository(apiService: apiService)),
      RepositoryProvider(create: (context) => UserRepository(apiService: apiService)),
    ], child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TabCubit()),
          BlocProvider(create: (context) => LoginCubit(context.read<LoginRepository>())),
          BlocProvider(create: (context) => ProductBloc(productRepository: context.read<ProductRepository>())),
          BlocProvider(create: (context) => ClientOrderBloc(orderRepository: context.read<OrderRepository>())),
        ],
        child: const MyApp()
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(figmaWidth, figmaHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}

