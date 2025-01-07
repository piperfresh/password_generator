import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/themes/theme_storage.dart';

final themeRepositoryProvider = Provider<ThemeRepository>(
  (ref) {
    final themeStorage = ref.watch(themeStorageProvider);
    return ThemeRepository(themeStorage);
  },
);

class ThemeRepository {
  final ThemeStorage _themeStorage;

  ThemeRepository(this._themeStorage);

  Future<bool> getThemeMode() async {
    return await _themeStorage.getThemeMode();
  }

  Future<bool> setThemeMode(bool currentThemeMode) async {
    return await _themeStorage.setThemeMode(currentThemeMode);
  }
}
