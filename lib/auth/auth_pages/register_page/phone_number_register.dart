import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_code/auth/auth_forms/phone_number_form.dart';
import 'package:taxi_code/page_builder.dart';
import 'package:taxi_code/auth/pin_code_dialog.dart';
import 'package:taxi_code/palette.dart' as palette;
import 'package:taxi_code/auth/models/provider_codes.dart';

class PhoneNumberRegister extends StatefulWidget {
  const PhoneNumberRegister({super.key});

  @override
  State<PhoneNumberRegister> createState() => _PhoneNumberRegisterState();
}

class _PhoneNumberRegisterState extends State<PhoneNumberRegister> {
  final formKey = GlobalKey<FormState>();
  final checkCodePhoneNumber = ProviderCodes().checkCode;

  TextEditingController userPhoneNumberController = TextEditingController();

  @override
  void dispose() {
    userPhoneNumberController.dispose();
    super.dispose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите номер телефона';
    } else if (value.length == 10 &&
        value.substring(0, 1) == '0' &&
        checkCodePhoneNumber(value.substring(1, 3))) {
      return null;
    } else {
      return 'Некорректный номер телефона';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      formKey: formKey,
      content: [
        const Text(
          'Регистрация',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        const Gap(50),
        PhoneNumberTextField(
            validator: validator, controller: userPhoneNumberController),
        const Gap(15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(
              20,
            ),
          ),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              if (await showPinCodeDialog(context) && mounted) {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pushNamed(context, '/new_password_register');
              }
            }
          },
          child: const Text(
            'Получить код',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Уже есть аккаунт? '),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Авторизация',
                style: TextStyle(fontSize: 16, color: palette.yellow),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
