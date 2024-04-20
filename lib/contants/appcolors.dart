 import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {

  static const primary_color = Color(0xff1E8F66);
  static const background_color = Color(0xffFFFFFF);
  static const text_white = Color(0xffFFFFFF);
  static const text_black = Color(0xff000000);


  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary_color,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary_color,
    brightness: Brightness.dark,
  );

}
