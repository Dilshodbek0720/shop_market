import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.go,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: AppColors.black),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 18.sp, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: AppColors.black),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.c_50)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.c_50)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.primary)),
          fillColor: AppColors.orangeTransparent,
          filled: true),
    );
  }
}