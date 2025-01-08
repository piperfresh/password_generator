import 'package:flutter/material.dart';
import 'package:password_generator/core/extension.dart';

class SnackBarUtils {
  static void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        message,
        style: context.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
      )),
    );
  }
}
