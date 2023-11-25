
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF748CF1);
const Color backgroundColor = Color(0xFFEAEEF3);
const Color navBarColor = Color(0xFF353A56);

const Color darkPrimaryColor = Color(0xFF8E9AFF);
const Color darkBackgroundColor = Color(0xFF1E1E1E);
const Color darkNavBarColor = Color(0xFF2B2B2B);


final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: navBarColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.blueGrey,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
);