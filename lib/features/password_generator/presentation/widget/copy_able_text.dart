import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/core/extension.dart';

import '../../../../core/app_color.dart';
import '../../../../core/themes/theme_notifier.dart';

class CopyAbleText extends StatelessWidget {
  final String text;

  const CopyAbleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Consumer(builder: (context, ref, child) {
            final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
            return Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isDarkMode ? AppColor.white : AppColor.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(text, style: TextStyle(fontSize: 18.sp)));
          }),
        ),
        9.sbW,
        ElevatedButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$text copied to clipboard',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColor.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Copy'))
      ],
    );
  }
}
