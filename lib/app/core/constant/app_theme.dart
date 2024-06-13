// app_theme.dart
import 'package:flutter/material.dart';
import 'color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      background: AppColors.backgroundColor,
      onPrimary: AppColors.onPrimaryColor,
      onSecondary: AppColors.onSecondaryColor,
      error: AppColors.errorColor,
    ),
  );
}
