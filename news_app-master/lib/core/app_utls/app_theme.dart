import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme:const AppBarTheme(
    iconTheme: IconThemeData(color: AppColors.black),
    color: AppColors.white,
  titleTextStyle: AppStyle.black20w500,
  centerTitle: true,),
  textTheme:const
  TextTheme(
  labelLarge: AppStyle.black20w500,),
    indicatorColor: AppColors.black,
    primaryColor: AppColors.white,
  );


  static final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.black,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: AppColors.white),

    color: AppColors.black,
    titleTextStyle: AppStyle.white20medium,
    centerTitle: true,),
  textTheme: const TextTheme(
  labelLarge: AppStyle.white20medium
  ),
    indicatorColor: AppColors.white,
    primaryColor: AppColors.black,

  );
}
