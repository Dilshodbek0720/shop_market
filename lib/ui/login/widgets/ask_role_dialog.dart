import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/local/storage_repository.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/storage_keys.dart';
import '../../../utils/icons/app_icons.dart';
import '../../app_routes.dart';

void showRoleDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: Text(
          "Admin or Client?",
          style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold
          ),
        ),
        title: Image.asset(AppIcons.dialogImage, fit: BoxFit.cover,),
        actions: [
          TextButton(
            onPressed: () {
              StorageRepository.putString(
                  StorageKeys.userRole, AppConstants.admin);
              Navigator.pushReplacementNamed(context, RouteNames.tabBoxScreen);
            },
            child: Text(
              "Admin",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18.sp
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              StorageRepository.putString(
                  StorageKeys.userRole, AppConstants.client);
              Navigator.pushReplacementNamed(context, RouteNames.tabBoxScreen);
            },
            child: Text(
              "Client",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18.sp
              ),
            ),
          ),
        ],
      );
    },
  );
}