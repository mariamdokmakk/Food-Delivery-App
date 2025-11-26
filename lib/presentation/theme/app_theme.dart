// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // Prevent instantiation
  AppTheme._();

  // ----------------- COLORS: YOUR NEW DESIGN ----------------- //
  static const Color darkBackgroundV2 = Color(0xFF0F141E);     // Page background
  static const Color darkCard = Color(0xFF1A1F2A);
  // ----------------- COLORS ----------------- //
  static const Color _primaryGreen = Color(0xFF4CAF50);  //primary
  static const Color _lightGreen = Color(0xFF91CDA2);
  // static const Color _darkBackground = Color(0xFF1B1B1B);  //background
  static const Color _darkFieldBackground = Color(0xFF2C2C2C);  //gray

  // ----------------- LIGHT THEME ----------------- //
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryGreen,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light().copyWith(
      primary: _primaryGreen,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      // --- THE FIX: Disable scroll color change ---
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      // ------------------------------------------
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    // --- INPUT FIELDS (Translucent & Round) ---
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.withValues(alpha: 0.1),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _primaryGreen, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    ),
    // ------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryGreen,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 2,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(_primaryGreen),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? _lightGreen : null;
      }),
    ),
  );


  // ----------------- DARK THEME ----------------- //
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryGreen,
    scaffoldBackgroundColor: darkBackgroundV2,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _primaryGreen,
      onPrimary: Colors.white,
      surface: darkBackgroundV2,

    ),
    cardColor: Color(0xFF1A1F2A),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryGreen,
      elevation: 0,
      // --- THE FIX: Disable scroll color change ---
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      // ------------------------------------------
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    // --- INPUT FIELDS (Dark & Round) ---
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkFieldBackground,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _primaryGreen, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    ),
    // ------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryGreen,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 2,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(_primaryGreen),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? _primaryGreen.withValues(alpha: 0.5) : null;
      }),
    ),
  );
}