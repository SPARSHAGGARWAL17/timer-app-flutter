import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff216C2E);
  static const Color secondaryColor = Color(0xff006782);
  static Color cardColor = const Color(0xffFBFCFE);
  static const Color buttonBackgroundColor = Color(0xffE1DFFF);
}

class AppTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w500,
    fontSize: 22,
    color: AppColors.primaryColor,
  );

  static const TextStyle headingStyle = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w500,
    fontSize: 32,
    color: AppColors.secondaryColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: AppColors.secondaryColor,
  );
}
