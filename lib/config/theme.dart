import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
ThemeData theme() {
  return ThemeData(
    fontFamily: GoogleFonts.openSans().fontFamily,
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 32,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 24,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    ),
  );
}