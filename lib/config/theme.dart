import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData them() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColorDark: Colors.black,
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 28,
        weight: 5,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayMedium: GoogleFonts.exo2(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          // fontFamily:
        ),
        displayLarge: GoogleFonts.exo2(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.exo2(
          color: Colors.grey[300],
          fontSize: 16,
        ),
        titleSmall: GoogleFonts.exo2(
          color: Colors.grey[300],
          fontSize: 13,
        ),
      ),
      primaryColor: Colors.black
      // const Color.fromARGB(255, 35, 110, 241),
      );
}
