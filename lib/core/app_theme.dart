import 'package:bella_banga/core/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData lightAppTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: const Color.fromARGB(255, 175, 118, 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xffFA9833),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFA6A3A0)),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(fontSize: 15, color: Colors.grey),
        titleLarge: TextStyle(fontSize: 12)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
  );
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide(color: AppColor.darkGrey),
  gapPadding: 2,
);