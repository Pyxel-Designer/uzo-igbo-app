import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseTypography = GoogleFonts.plusJakartaSansTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.canvas,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        tertiary: AppColors.tertiary,
        onTertiary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textDark,
      ),
      textTheme: baseTypography.copyWith(
        displayLarge: baseTypography.displayLarge?.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.03,
          height: 1.25,
          color: AppColors.textDark,
        ),
        headlineLarge: baseTypography.headlineLarge?.copyWith(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.02,
          height: 1.3,
          color: AppColors.textDark,
        ),
        headlineMedium: baseTypography.headlineMedium?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.01,
          height: 1.35,
          color: AppColors.textDark,
        ),
        headlineSmall: baseTypography.headlineSmall?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 1.4,
          color: AppColors.textDark,
        ),
        bodyLarge: baseTypography.bodyLarge?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 1.55, // Extra vertical line height prevents Igbo diacritic clipping (ị, ọ, ụ, ṅ)
          color: AppColors.textDark,
        ),
        bodyMedium: baseTypography.bodyMedium?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AppColors.textDark,
        ),
        labelLarge: baseTypography.labelLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.01,
          color: AppColors.textDark,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.border, width: 1.5),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.canvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
        centerTitle: true,
      ),
    );
  }
}
