import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_code/page_builder.dart';
import 'package:taxi_code/auth/auth_forms/password_form.dart';
import 'package:taxi_code/auth/auth_forms/password_rules.dart';
import 'package:taxi_code/auth/auth_forms/phone_number_form.dart';
import 'package:taxi_code/auth/models/provider_codes.dart';
import 'package:taxi_code/auth/pin_code_dialog.dart';
import 'package:taxi_code/custom_transition.dart';
import 'package:taxi_code/home.dart';
import 'package:taxi_code/palette.dart' as palette;

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final formKey = GlobalKey<FormState>();
  final checkCodePhoneNumber = ProviderCodes().checkCode;
  final TextEditingController userPhoneNumberController =
      TextEditingController(text: '0553998299');
  final TextEditingController userPasswordController =
      TextEditingController(text: 'asdasd343434');
  bool obscurePassword = true;
  String? errorPhoneNumber;
  String? errorPassword;

  @override
  void dispose() {
    userPhoneNumberController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    } else if (value.length == 10 &&
        value.substring(0, 1) == '0' &&
        checkCodePhoneNumber(value.substring(1, 3))) {
      if (value == '0553998299') {
        setState(() {
          errorPassword = null;
        });
        return null;
      } else {
        setState(() {
          errorPassword = 'Неправильный номер или пароль';
        });
        return '';
      }
    } else {
      return '';
    }
  }

  String? passwordValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      for (var check in rules.values) {
        if (!check(value)) {
          setState(() {
            errorPhoneNumber = '';
          });
          return 'Неправильный номер или пароль';
        }
      }
      return null;
    } else {
      errorPhoneNumber = '';
      return 'Неправильный номер или пароль';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      formKey: formKey,
      canPop: false,
      content: [
        const Text(
          'Вход',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        const Gap(50),
        PhoneNumberTextField(
          validator: phoneNumberValidator,
          controller: userPhoneNumberController,
          errorText: errorPhoneNumber,
        ),
        const Gap(10),
        PasswordTextField(
          validator: passwordValidator,
          controller: userPasswordController,
          errorText: errorPassword,
        ),
        const Gap(10),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/restore');
            },
            child: const Text(
              'Забыли пароль?',
              style: TextStyle(fontSize: 16, color: palette.blue),
            ),
          ),
        ),
        const Gap(10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(
              20,
            ),
          ),
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            if (formKey.currentState!.validate()) {
              if (await showPinCodeDialog(context) && mounted) {
                Navigator.of(context).push(
                  CustomRoute(
                    maintainState: false,
                    builder: (context) => const Home(),
                  ),
                );
              }
            }
          },
          child: const Text(
            'Войти',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Нет аккаунта? ',
            ),
            TextButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                'Создать аккаунт',
                style: TextStyle(fontSize: 16, color: palette.yellow),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
