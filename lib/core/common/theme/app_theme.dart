import 'package:cc_enpal/core/common/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final AppColors chosenColor;

  AppTheme(
    this.chosenColor,
  );

  ThemeData getTheme() {
    final sizes = AppValues();

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        surface: chosenColor.backgroundColor,
        seedColor: chosenColor.backgroundColor,
        primary: chosenColor.primaryColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: chosenColor.primaryColor,
        foregroundColor: chosenColor.backgroundColor,
        titleTextStyle: TextStyle(
          fontSize: sizes.appBarText,
          color: chosenColor.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: chosenColor.textColor,
          fontSize: sizes.normalText,
        ),
        headlineLarge: TextStyle(
          color: chosenColor.textColor,
          fontSize: sizes.largeText,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(chosenColor.primaryColor),
          foregroundColor:
              WidgetStateProperty.all<Color>(chosenColor.whiteColor),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all<Color>(chosenColor.primaryColor),
        overlayColor:
            WidgetStateProperty.all<Color>(chosenColor.backgroundColor),
        trackColor:
            WidgetStateProperty.all<Color>(chosenColor.backgroundColor),
        trackOutlineColor:
            WidgetStateProperty.all<Color>(chosenColor.backgroundColor),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: chosenColor.whiteColor,
        unselectedLabelColor: chosenColor.textColor,
      ),
      scaffoldBackgroundColor: chosenColor.backgroundColor,
      hoverColor: chosenColor.chartColor1,
      shadowColor: chosenColor.chartColor2
    );
  }
}

class AppValues {
  // ========================================================
  // Font Size
  final double smallText = 14.0;
  final double normalText = 16.0;
  final double largeText = 20.0;
  final double appBarText = 22.0;
}
