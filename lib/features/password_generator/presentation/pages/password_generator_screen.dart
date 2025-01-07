import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/app_color.dart';
import 'package:password_generator/core/extension.dart';
import 'package:password_generator/core/themes/theme_notifier.dart';
import 'package:password_generator/features/password_generator/presentation/widget/copy_able_text.dart';
import 'package:password_generator/features/password_generator/presentation/widget/password_type_widget.dart';
import 'package:password_generator/features/password_generator/presentation/widget/text_field_with_title.dart';

class PasswordGeneratorScreen extends ConsumerStatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  ConsumerState<PasswordGeneratorScreen> createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState
    extends ConsumerState<PasswordGeneratorScreen> {
  final passwordCharacterController = TextEditingController();
  bool includeUppercase = false;
  bool includeLowercase = false;
  bool includeNumber = false;
  bool includeSymbol = false;

  @override
  void dispose() {
    super.dispose();
    passwordCharacterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Password Generator',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 20.sp,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithTitle(
              title: 'Password length',
              controller: passwordCharacterController,
            ),
            12.sbH,
            PasswordTypeWidget(
              title: 'Include uppercase',
              currentState: includeUppercase,
              onChanged: (value) {
                setState(() {
                  includeUppercase = value!;
                });
              },
            ),
            PasswordTypeWidget(
              title: 'include lowercase',
              currentState: includeLowercase,
              onChanged: (value) {
                setState(() {
                  includeLowercase = value!;
                });
              },
            ),
            PasswordTypeWidget(
              title: 'include number',
              currentState: includeNumber,
              onChanged: (value) {
                setState(() {
                  includeNumber = value!;
                });
              },
            ),
            PasswordTypeWidget(
              title: 'include symbol',
              currentState: includeSymbol,
              onChanged: (value) {
                setState(() {
                  includeSymbol = value!;
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {},
                  child: Text(
                    'Generate',
                    style: context.textTheme.bodyMedium,
                  )),
            ),
            12.sbH,
            Text(
              'Generated password',
              style: context.textTheme.bodySmall,
            ),
            8.sbH,
            CopyAbleText(text: 'Abass'),
            12.sbH,
            Text('Password Strength', style: context.textTheme.bodySmall),
            5.sbH,
          ],
        ),
      ),
    );
  }
}

