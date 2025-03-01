import 'package:flutter/material.dart';
import 'package:password_generator/core/extension.dart';

class PasswordTypeWidget extends StatelessWidget {
  final bool currentState;
  final void Function(bool?)? onChanged;
  final String title;

  const PasswordTypeWidget({
    super.key,
    required this.currentState,
    this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!currentState);
        }
      },
      child: Row(
        children: [
          Checkbox(
            value: currentState,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(title,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}
