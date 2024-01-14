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
      displayLarge: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: const MaterialStatePropertyAll(AppColors.whiteColor),
      fillColor: const MaterialStatePropertyAll(Colors.transparent),
      // activeColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(color: AppColors.whiteColor),
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
        backgroundColor: const MaterialStatePropertyAll(AppColors.buttonColor),
      ),
    ),
  );
}

class AppColors {
  AppColors._();
  static const darkColor = Color.fromRGBO(23, 25, 26, 1);
  static const whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const lightColor = Color.fromRGBO(239, 242, 245, 1);
  static const darkGreyColor = Color.fromRGBO(151, 151, 151, 1);
  static const greyColor = Color.fromRGBO(179, 179, 179, 1);
  static const lightGreyColor = Color.fromRGBO(203, 203, 203, 1);
  static const blueColor = Color.fromRGBO(56, 152, 243, 1);
  static const greenColor = Color.fromRGBO(84, 181, 65, 1);
  static const redColor = Color.fromRGBO(214, 35, 0, 1);
  static const backgroundColor = Color.fromRGBO(23, 25, 26, 1);
  static const buttonColor = Color.fromRGBO(41, 163, 238, 1);
  static const boldBlueColor = Color.fromRGBO(56, 152, 243, 1);
  static const greenColorWO = Color.fromRGBO(67, 199, 72, 0.96);
}
