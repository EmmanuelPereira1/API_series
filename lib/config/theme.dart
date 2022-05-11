import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
ThemeData theme() {
  return ThemeData(
    iconTheme: IconThemeData(color: Colors.amber),
    // fontFamily: GoogleFonts.openSans().fontFamily,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 32,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 24,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 20,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 18,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
    ),
  );
}