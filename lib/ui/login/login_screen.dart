import 'package:flutter/material.dart';
import 'package:shop_market/data/repository/login_repository.dart';
import 'package:shop_market/services/api_service.dart';
import 'package:shop_market/ui/tab_box/tab_box.dart';
import 'package:shop_market/utils/colors/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.apiService});
  final ApiService apiService;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  late LoginRepository loginRepository;
  @override
  void initState() {
    loginRepository = LoginRepository(apiService: widget.apiService);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text(
          "Ulmo",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32,
              color: AppColors.black),
        ),
      ),
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.next,
              controller: _controller1,
              decoration: InputDecoration(
                  hintText: "Enter username",
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                  ),
                  enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            SizedBox(height: 40,),
            TextField(
              textInputAction: TextInputAction.done,
              controller: _controller2,
              decoration: InputDecoration(
                  hintText: "Enter password",
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                  ),
                  enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: () async{
              if(await loginRepository.loginUser(username: _controller1.text, password: _controller2.text)){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return TabBox();
                }));
              }else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Parol yoki username xato")));
              }
            }, child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login", style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}