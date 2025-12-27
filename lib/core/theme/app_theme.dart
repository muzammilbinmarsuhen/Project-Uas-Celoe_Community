import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Maroon Palette
  static const Color primaryMaroon = Color(0xFFA82E2E);
  static const Color darkMaroon = Color(0xFF8F1E1E);
  static const Color lightMaroon = Color(0xFFB74A4A);
  
  static const Color background = Color(0xFFF9FAFB);
  static const Color white = Colors.white;
  static const Color blackText = Color(0xFF1F2937);
  static const Color greyText = Color(0xFF6B7280);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryMaroon,
        primary: primaryMaroon,
        surface: white,
      ),
      scaffoldBackgroundColor: background,
      
      // Typography
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: blackText),
        titleLarge: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: blackText),
        bodyLarge: GoogleFonts.poppins(fontSize: 16, color: blackText),
        bodyMedium: GoogleFonts.poppins(fontSize: 14, color: blackText),
        labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: white),
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18, 
          fontWeight: FontWeight.bold, 
          color: blackText
        ),
        iconTheme: const IconThemeData(color: blackText),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryMaroon,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryMaroon, width: 2),
        ),
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
      ),
    );
  }
}
