import 'package:flutter/material.dart';
import 'package:shop_market/data/local/storage_repository.dart';
import 'package:shop_market/services/api_service.dart';
import 'package:shop_market/ui/app_routes.dart';
import 'package:shop_market/utils/constants/storage_keys.dart';
import '../../utils/icons/app_icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init()async{
    await Future.delayed(const Duration(seconds: 2));
    if(context.mounted){
      StorageRepository.getString(StorageKeys.userToken).isEmpty ? Navigator.pushReplacementNamed(context, RouteNames.loginScreen) :
      Navigator.pushReplacementNamed(context, RouteNames.tabBoxScreen);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(AppIcons.splash, fit: BoxFit.cover,),
      ),
    );
  }
}