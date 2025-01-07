import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/constants.dart';
import 'package:password_generator/core/size_configs.dart';
import 'package:password_generator/core/themes/theme_repository.dart';
import 'package:password_generator/core/themes/theme_storage.dart';
import 'package:password_generator/core/themes/themes.dart';
import 'package:password_generator/features/password_generator/presentation/pages/password_generator_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/themes/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Initialized SharedPreferences
  final pref = await SharedPreferences.getInstance();

  /// Get the saved theme locally
  final savedTheme = pref.getBool(AppConstants.themeModeKey) ?? false;
  runApp(ProviderScope(
    overrides: [
      /// Override the initial state theme with the saved theme
      /// so it will load the saved theme immediately
      themeProvider.overrideWith(
        (ref) => ThemeNotifier(
          ThemeRepository(
            ThemeStorageImpl(pref),
          ),
        )..initTheme(savedTheme),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    SizeConfig().init(context, 375, 812);
    return MaterialApp(
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const PasswordGeneratorScreen(),
    );
  }
}
