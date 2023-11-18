import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_market/cubits/login/login_cubit.dart';
import 'package:shop_market/ui/login/widgets/ask_role_dialog.dart';
import 'package:shop_market/ui/login/widgets/login_text_field.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../data/models/status/form_status.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/ui_utils/show_error_message.dart';
import '../widgets/global_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return Stack(children: [
            // SizedBox(height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   child: Image.asset(AppIcons.s, fit: BoxFit.cover,),
            // ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: 48.h, left: 24.w, right: 24.w, top: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    90.ph,
                    Text(
                      "Sign in",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.c_314D45
                      ),
                    ),
                    60.ph,
                    Column(
                      children: [
                        LoginTextField(
                          hintText: "Enter username",
                          onChanged: (v) {
                            username = v;
                          },
                        ),
                        40.ph,
                        LoginTextField(
                          hintText: "Enter password",
                          onChanged: (v) {
                            password = v;
                          },
                        ),
                        40.ph,
                        GlobalButton(
                          title: "Sign In",
                          radius: 100,
                          onTap: () {
                            if (password.isNotEmpty && username.isNotEmpty) {
                              context.read<LoginCubit>().logIn(context: context, username: username, password: password);
                            }else{
                              showErrorMessage(message: "Malumotlarni to'liq kiriting!", context: context);
                            }
                          },
                        )
                      ],
                    ),
                    60.ph,
                  ],
                ),
              ),
            )
          ],);
        },
        listener: (context, state) async {
          if (state.status == FormStatus.authenticated) {
            if (context.mounted) {
              showRoleDialog(context);
            }
          } else if (state.status == FormStatus.failure) {
            showErrorMessage(message: state.statusMessage, context: context);
          }
        },
      ),
    );
  }
}