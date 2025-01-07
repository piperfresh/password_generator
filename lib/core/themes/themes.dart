import 'package:flutter/material.dart';
import 'package:password_generator/core/extension.dart';

import '../app_color.dart';

class AppTheme {
  AppTheme._();

  static final AppTheme _instance = AppTheme._();

  static AppTheme get instance => _instance;

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Lexend',
      textTheme: textTheme(AppColor.black));

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Lexend',
        textTheme: textTheme(AppColor.white),
      );

  static TextTheme textTheme(Color color) {
    return TextTheme(
      bodySmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}
