import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const double globalPadding = 16.0;

  static const Color primaryPurple = Color(0xFF7F4991);
  static const Color textPrimary = Color(0xFF3C3C3C);
  static const Color accentPurple = Color(0xFFFCF4FF);
  static const Color backgroundLight = Color(0xFFF3F3F3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF676767);
  static const Color textLabel = Color(0xFF929292);
  static const Color borderColor = Color(0xFFEEEEEE);
  static const Color successGreen = Color(0xFF10B981);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color backGroundAppBar = Color(0xE4E4E4E4);
  static const Color dividerColor = Color(0xFFE3E3E3);
  static const Color skeletonBackground = Color(0xFFE0E0E0);
  static const Color skeletonBorder = Color(0xFFC6C6C6);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorderColor = Color(0xFFF9F9F9);
  static const Color errorColor = Color(0xFFEF4444);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        primary: primaryPurple,
        secondary: accentPurple,
        surface: white,
        error: errorRed,
      ),
      scaffoldBackgroundColor: backgroundLight,
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.poppins(fontSize: 16, color: textPrimary),
        bodyMedium: GoogleFonts.poppins(fontSize: 16, color: textSecondary),
        bodySmall: GoogleFonts.poppins(fontSize: 14, color: textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryPurple,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          side: const BorderSide(color: primaryPurple, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed),
        ),
        labelStyle: GoogleFonts.inter(color: textSecondary),
        hintStyle: GoogleFonts.inter(color: textSecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backGroundAppBar,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ),
    );
  }
}
