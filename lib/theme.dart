import 'dart:ui';

import 'package:flutter/material.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 46)),
      ),
    )
  );
}

class AppColors{
  AppColors._();

  static const backgroundColor = Color.fromRGBO(23, 25, 26, 1,);
  static const buttonColor = Color.fromRGBO(41, 163, 238, 1);
  static const boldBlueColor = Color.fromRGBO(56, 152, 243, 1);
  static const whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const greenColor = Color.fromRGBO(84, 181, 65, 1);
  static const greenColorWO = Color.fromRGBO(67, 199, 72, 0.96);
  static const darkColor = Color.fromRGBO(41, 45, 50, 1);
  static const greyColor = Color.fromRGBO(179, 179, 179, 1);
}
