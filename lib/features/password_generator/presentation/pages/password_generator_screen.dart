import 'package:flutter/material.dart';
import 'package:password_generator/core/extension.dart';
import 'package:password_generator/features/password_generator/presentation/widget/copy_able_text.dart';
import 'package:password_generator/features/password_generator/presentation/widget/text_field_with_title.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  State<PasswordGeneratorScreen> createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Password Generator',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 20.sp,
          ),
        ),
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
            Text('Stre')
          ],
        ),
      ),
    );
  }
}

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
    return Row(
      children: [
        Checkbox(
          value: currentState,
          onChanged: onChanged,
        ),
        5.sbW,
        Text(title,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}
