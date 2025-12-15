import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static const String _themeKey = "isDarkMode";
  // This notifies listeners whenever the theme changes
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.light);

  static Future<void> toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool(_themeKey) ?? false;
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}