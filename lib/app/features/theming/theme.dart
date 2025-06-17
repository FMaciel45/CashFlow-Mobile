import 'package:flutter/material.dart';

import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_text_theme.dart';

class CashFlowTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: CashFlowColors.primaryColor,
    scaffoldBackgroundColor: CashFlowColors.lightTheme,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: CashFlowColors.primaryColor,
    scaffoldBackgroundColor: CashFlowColors.darkTheme,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme
  );
}