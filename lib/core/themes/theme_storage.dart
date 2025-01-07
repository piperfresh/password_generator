import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/constants.dart';
import 'package:password_generator/core/themes/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeStorageProvider = Provider<ThemeStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeStorageImpl(prefs);
});

abstract class ThemeStorage {
  // factory ThemeStorage() => ThemeStorageImpl();

  Future<bool> getThemeMode();

  Future<bool> setThemeMode(bool currentThemeMode);
}

class ThemeStorageImpl implements ThemeStorage {
  ThemeStorageImpl(this._preferences);
  final SharedPreferences _preferences;

  @override
  Future<bool> getThemeMode() async {
    return _preferences.getBool(AppConstants.themeModeKey) ?? false;
  }

  @override
  Future<bool> setThemeMode(bool currentThemeMode) async {
    return await _preferences.setBool(
        AppConstants.themeModeKey, currentThemeMode);
  }
}
