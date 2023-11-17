import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_market/utils/size/size_extension.dart';
import '../../../../cubits/tab/tab_cubit.dart';
import '../../../../data/local/storage_repository.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/constants/storage_keys.dart';
import '../../../app_routes.dart';
import '../../../widgets/global_button.dart';

class LogOutItem extends StatelessWidget {
  const LogOutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            24.ph,
            Text(
              "Are you Log Out?",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            24.ph,
            Row(
              children: [
                Expanded(
                    child: GlobalButton(
                      textColor: AppColors.white,
                      title: 'CANCEL',
                      onTap: () {
                        Navigator.pop(context);
                      },
                      radius: 100.r,
                    )),
                12.pw,
                Expanded(
                  child: GlobalButton(
                    title: "OK",
                    textColor: Colors.white,
                    onTap: () async {
                      // context.read<UserBloc>().clearUserModelState();
                      StorageRepository.deleteString(StorageKeys.userRole);
                      StorageRepository.deleteString(StorageKeys.userToken);
                      // await context.read<AuthCubit>().logOutUser();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.loginScreen);
                        context.read<TabCubit>().changeTabIndex(0);
                      }
                    },
                    radius: 100.r,
                  ),
                ),
              ],
            ),
            48.ph,
          ],
        ),
      ),
    );
  }
}