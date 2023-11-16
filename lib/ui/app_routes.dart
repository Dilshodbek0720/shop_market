
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_market/services/api_service.dart';
import 'package:shop_market/ui/login/login_screen.dart';
import 'package:shop_market/ui/splash/splash_screen.dart';
import 'package:shop_market/ui/tab_box/tab_box.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String loginScreen = "/login_screen";
  static const String tabBoxScreen = "/tab_box";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RouteNames.tabBoxScreen:
        return MaterialPageRoute(
          builder: (context) => const TabBox(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Route not found!")),
          ),
        );
    }
  }
}