import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/size_configs.dart';
import 'package:password_generator/core/themes.dart';
import 'package:password_generator/features/password_generator/presentation/pages/password_generator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context, 375, 812);
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const PasswordGeneratorScreen(),
      ),
    );
  }
}
