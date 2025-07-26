import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Black & White Theme
  static const Color primaryBlack = Color(0xFF1A1A1A);
  static const Color primaryGray = Color(0xFF2D2D2D);
  static const Color lightGray = Color(0xFF8E8E93);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  
  // Accent Colors - Subtle grays
  static const Color accentDark = Color(0xFF3A3A3C);
  static const Color accentLight = Color(0xFFF2F2F7);
  static const Color accentMedium = Color(0xFF48484A);
  
  // Background Colors
  static const Color backgroundPrimary = Color(0xFFF8F8F8);
  static const Color backgroundSecondary = Color(0xFFFFFFFF);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1C1C1E);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF6D6D70);
  static const Color textLight = Color(0xFF8E8E93);
  static const Color textWhite = Color(0xFFFFFFFF);
  
  // Status Colors - Monochrome versions
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF007AFF);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlack, primaryGray],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [backgroundCard, accentLight],
  );
  
  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryWhite, accentLight],
  );
}