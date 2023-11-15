import 'package:flutter/material.dart';
import 'package:shop_market/data/local/storage_repository.dart';
import 'package:shop_market/services/api_service.dart';
import 'package:shop_market/ui/login/login_screen.dart';
import 'package:shop_market/ui/tab_box/tab_box.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StorageRepository.getString("token").isNotEmpty ? const TabBox() : LoginScreen(apiService: ApiService(),)
    );
  }
}
