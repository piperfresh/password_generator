import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/app_color.dart';
import 'package:password_generator/core/extension.dart';
import 'package:password_generator/core/themes/theme_notifier.dart';
import 'package:password_generator/core/utils/snack_bar.dart';
import 'package:password_generator/features/password_generator/presentation/widget/copy_able_text.dart';
import 'package:password_generator/features/password_generator/presentation/widget/password_type_widget.dart';
import 'package:password_generator/features/password_generator/presentation/widget/text_field_with_title.dart';
import 'package:password_generator/features/password_generator/repository/password_generator.dart';

import '../widget/linear_tracker.dart';

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

  double progress = 0;
  String generatedPassword = '';

  @override
  void dispose() {
    super.dispose();
    passwordCharacterController.dispose();
  }

  String passwordStrength(double strength) {
    if (strength >= 80) return 'Very Strong';
    if (strength >= 60) return 'Strong';
    if (strength >= 40) return 'Moderate';
    if (strength >= 20) return 'Weak';
    return 'Very Weak';
  }

  bool isAnyCheckboxSelected() {
    return includeUppercase ||
        includeLowercase ||
        includeNumber ||
        includeSymbol;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWithTitle(
                title: 'Password length',
                controller: passwordCharacterController,
                keyboardType: TextInputType.number,
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
                title: 'Include lowercase',
                currentState: includeLowercase,
                onChanged: (value) {
                  setState(() {
                    includeLowercase = value!;
                  });
                },
              ),
              PasswordTypeWidget(
                title: 'Include number',
                currentState: includeNumber,
                onChanged: (value) {
                  setState(() {
                    includeNumber = value!;
                  });
                },
              ),
              PasswordTypeWidget(
                title: 'Include symbol',
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isAnyCheckboxSelected()
                            ? null
                            : isDarkMode
                                ? AppColor.blueShade400
                                : AppColor.blueShade200,
                      ),
                      onPressed: !isAnyCheckboxSelected()
                          ? null
                          : () {
                              if (passwordCharacterController.text.isEmpty) {
                                SnackBarUtils.snackBar(
                                    context, 'Please enter  password length');
                                return;
                              }
                        final length =
                            int.tryParse(passwordCharacterController.text) ?? 0;

                              print(length);

                              if (length <= 0) {
                                SnackBarUtils.snackBar(context, 'Please enter a valid password length');
                          return;
                        }

                              // final generatePassword =
                              // PasswordGenerator.generatePassword(
                              //     length: length,
                              //     includeUppercase: includeUppercase,
                              //     includeLowercase: includeLowercase,
                              //     includeNumber: includeNumber,
                              //     includeSymbol: includeSymbol);

                              final generatePassword =
                                  PasswordGenerator.generatePassword(
                                      length: length,
                                      includeUppercase: includeUppercase,
                                      includeLowercase: includeLowercase,
                                      includeNumbers: includeNumber,
                                      includeSpecialCharacters: includeSymbol);

                              setState(() {
                                generatedPassword = generatePassword;
                                progress =
                                    PasswordGenerator.calculatePasswordStrength(
                                        generatePassword);
                              });
                              print('this is progress $progress');
                            },
                      child: Text('Generate',
                          style: context.textTheme.bodyMedium?.copyWith(
                              color: !isAnyCheckboxSelected()
                                  ? AppColor.grey
                                  : null)))),
              12.sbH,
              Text(
                'Generated password',
                style: context.textTheme.bodySmall,
              ),
              8.sbH,
              CopyAbleText(text: generatedPassword),
              12.sbH,
              Text('Password Strength', style: context.textTheme.bodySmall),
              10.sbH,
              LinearTracker(
                progress: progress,
                height: 10.h,
              ),
              5.sbH,
              Text(
                passwordStrength(progress),
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

