import 'package:flutter/material.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32, 
      fontWeight: FontWeight.bold, 
      color: Colors.black
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24, 
      fontWeight: FontWeight.w600, 
      color: Colors.black
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18, 
      fontWeight: FontWeight.w600, 
      color: Colors.black
    ),

    titleLarge: const TextStyle().copyWith(
      fontSize: 16, 
      fontWeight: FontWeight.w600, 
      color: Colors.black
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16, 
      fontWeight: FontWeight.w500, 
      color: Colors.black
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16, 
      fontWeight: FontWeight.w400, 
      color: Colors.black
    ),

    bodyLarge: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black
    ),
    bodyMedium: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black
    ),
    bodySmall: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0x80000000) // preto com opacidade de 50%
    ),

    labelLarge: TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.black
    ),
    labelMedium: TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color(0x80000000) // preto com opacidade de 50%
    )
  );


  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32, 
      fontWeight: FontWeight.bold, 
      color: Colors.white
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24, 
      fontWeight: FontWeight.w600, 
      color: Colors.white
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18, 
      fontWeight: FontWeight.w600, 
      color: Colors.white
    ),

    titleLarge: const TextStyle().copyWith(
      fontSize: 16, 
      fontWeight: FontWeight.w600, 
      color: Colors.white
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16, 
      fontWeight: FontWeight.w500, 
      color: Colors.white
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16, 
      fontWeight: FontWeight.w400, 
      color: Colors.white
    ),

    bodyLarge: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white
    ),
    bodyMedium: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white
    ),
    bodySmall: TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0x80FFFFFF), // branco com opacidade de 50%
    ),

    labelLarge: TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.white
    ),
    labelMedium: TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color(0x80FFFFFF), // branco com opacidade de 50%
    )
  );
} 

class TTextFormFieldTheme {
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: Colors.black
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: Colors.black
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal
    ),
    floatingLabelStyle: const TextStyle().copyWith(color:  Color(0x80000000)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1, 
        color: Colors.grey
      )
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1, 
        color: Colors.grey
      )
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1, 
        color: Colors.black
      )
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1, 
        color: Colors.red
      )
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 2, 
        color: Colors.orange
      )
    )
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: Colors.white
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: Colors.white
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal
    ),
    floatingLabelStyle: const TextStyle().copyWith(color:  Color(0x80FFFFFF)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1, 
        color: Colors.grey
      )
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1, 
        color: Colors.grey
      )
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1, 
        color: Colors.white
      )
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1, 
        color: Colors.red
      )
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 2, 
        color: Colors.orange
      )
    )
  );
}