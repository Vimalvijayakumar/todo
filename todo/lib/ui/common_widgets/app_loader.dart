import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/utils/colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      width: 100.w,
      height: 100.h,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.appLoaderColor,
        ),
      ),
    );
  }
}
