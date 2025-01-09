import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/extension.dart';
import 'package:password_generator/core/themes/theme_notifier.dart';

import '../../../../core/app_color.dart';

class TextFieldWithTitle extends ConsumerWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isBigSize;
  final int? maxLines;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const TextFieldWithTitle({
    super.key,
    required this.title,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.contentPadding,
    this.isBigSize = false,
    this.maxLines,
    this.onTap,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 18.sp)),
        6.sbH,
        TextField(
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontSize: 16.sp, color: AppColor.black),
          controller: controller,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            onTap: onTap,
            maxLines: maxLines,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: isDarkMode ? AppColor.white : AppColor.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: isDarkMode ? AppColor.white : AppColor.black)),
            contentPadding: contentPadding ?? const EdgeInsets.all(10),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
                hintStyle: hintStyle ??
                    Theme.of(context)
                        .textTheme
                        .bodySmall
                    ?.copyWith(fontSize: 16.sp, color: AppColor.grey),
          ),
        ),
      ],
    );
  }
}
