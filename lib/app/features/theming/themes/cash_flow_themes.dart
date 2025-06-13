import 'package:flutter/material.dart';

class CashFlowColors {
  static const Color primaryColor = Color.fromARGB(255, 75, 104, 255);
  static const Color primaryColorWithLessOpacity = Color.fromARGB(41, 75, 105, 255);
  static const Color secondaryColor = Color.fromARGB(255, 209, 56, 18);

  static const Color textPrimaryColor = Color.fromARGB(255, 51, 51, 51);
  static const Color textSecondaryColor = Color.fromARGB(255, 108, 117, 125);
  static const Color textWhiteColor = Colors.white;
  static const Color textWhiteColorWithLessOpacity = Color.fromARGB(204, 255, 255, 255);


  static const Color lightTheme = Color.fromARGB(255, 246, 246, 246);
  static const Color darkTheme = Color.fromARGB(255, 39, 39, 39);
  static const Color primaryBackgroundColor = Color.fromARGB(255, 243, 245, 255);
  static const Color secondaryBackgroundColor = Color.fromARGB(255, 234, 237, 245);

  static const Color primaryButtonColor = Color.fromARGB(255, 245, 124, 0);
  static const Color secondaryButtonColor = Color.fromARGB(255, 196, 196, 196);

  static const Color dividerColor = Color.fromRGBO(170, 170, 170, 0.4);

  static const Color primaryBorderColor = Color.fromARGB(255, 217, 217, 217);
  static const Color secondaryBorderColor = Color.fromARGB(255, 230, 230, 230);

  static const Color errorColor = Color.fromARGB(255, 211, 47, 47);
  static const Color successColor = Color.fromARGB(255, 56, 142, 60);
  static const Color warningColor = Color.fromARGB(255, 245, 124, 0);
} 

class TAppBarTheme {
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Colors.black, 
      size: 24
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 24
    ),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black
    )
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Colors.black, 
      size: 24
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 24
    ),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white
    )
  );
}

class TElevatedButtonTheme {
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16, 
        color: Colors.white, 
        fontWeight: FontWeight.w600
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    )
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16, 
        color: Colors.white, 
        fontWeight: FontWeight.w600
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    )
  );
}