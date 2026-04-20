import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Paleta principal del diseño
  static const Color green = Color(0xFF5C8C3E);
  static const Color greenLight = Color(0xFF8BBF5A);
  static const Color greenSurface = Color(0xFFD6E8C0);
  static const Color greenCard = Color(0xFFEAF3DE);

  static const Color orange = Color(0xFFE8834A);
  static const Color orangeLight = Color(0xFFF5A87A);
  static const Color orangeSurface = Color(0xFFFDE8D8);

  static const Color cream = Color(0xFFFAF6EE);
  static const Color creamDark = Color(0xFFF0E8D8);

  static const Color red = Color(0xFFD85A3A);
  static const Color redSurface = Color(0xFFFAECE7);

  static const Color textDark = Color(0xFF2C2C2A);
  static const Color textMedium = Color(0xFF5F5E5A);
  static const Color textLight = Color(0xFF888780);

  static const Color white = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFD3D1C7);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.green,
        primary: AppColors.green,
        secondary: AppColors.orange,
        surface: AppColors.cream,
        background: AppColors.cream,
      ),
      scaffoldBackgroundColor: AppColors.cream,
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        headlineLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textMedium,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textMedium,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.textLight,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.textLight,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
