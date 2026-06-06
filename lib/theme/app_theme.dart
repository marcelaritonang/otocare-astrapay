import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // AstraPay Brand Colors
  static const Color primaryBlue = Color(0xFF1A6FE8);
  static const Color darkBlue = Color(0xFF0D47A1);
  static const Color lightBlue = Color(0xFF4FC3F7);
  static const Color accentPink = Color(0xFFFF4081);
  static const Color backgroundWhite = Color(0xFFF5F7FA);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color gradientStart = Color(0xFF1A6FE8);
  static const Color gradientEnd = Color(0xFF0D47A1);

  static ThemeData get theme => ThemeData(
        primaryColor: primaryBlue,
        scaffoldBackgroundColor: backgroundWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
          secondary: accentPink,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryBlue,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      );

  static LinearGradient get primaryGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [gradientStart, gradientEnd],
      );

  static BoxShadow get cardShadow => BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 16,
        offset: const Offset(0, 4),
      );
}
