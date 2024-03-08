import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff216C2E);
  static const Color secondaryColor = Color(0xff006782);
  static Color cardColor = const Color(0xffFBFCFE);
}

class AppTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 22,
    color: AppColors.primaryColor,
  );

  static const TextStyle headingStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    color: AppColors.secondaryColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.secondaryColor,
  );
}
