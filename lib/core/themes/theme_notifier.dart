import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/themes/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final themeRepository = ref.watch(themeRepositoryProvider);
  return ThemeNotifier(themeRepository);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final ThemeRepository themeRepository;

  ThemeNotifier(this.themeRepository) : super(ThemeMode.light) {
    // _initTheme();
  }

  void initTheme(bool isDarkMode) {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  /// This is making the getting of theme mode delay
  void _initTheme() async {
    final isDark = await themeRepository.getThemeMode();
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  // void toggleTheme() {
  //   state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  // }

  void toggleTheme() async {
    final isDarkMode = state == ThemeMode.light;
    /// Save the theme locally
    await themeRepository.setThemeMode(isDarkMode);
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}
