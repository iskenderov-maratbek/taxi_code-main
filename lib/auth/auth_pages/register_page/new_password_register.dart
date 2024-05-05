import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_code/auth/auth_forms/password_rules.dart';
import 'package:taxi_code/auth/auth_forms/password_form.dart';
import 'package:taxi_code/page_builder.dart';
import 'package:taxi_code/auth/models/provider_codes.dart';
import 'package:taxi_code/palette.dart' as palette;

class NewPasswordRegister extends StatefulWidget {
  const NewPasswordRegister({super.key});

  @override
  State<NewPasswordRegister> createState() => _NewPasswordRegisterState();
}

class _NewPasswordRegisterState extends State<NewPasswordRegister> {
  final formKey = GlobalKey<FormState>();
  final checkCodePhoneNumber = ProviderCodes().checkCode;
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController confirmUserPasswordController = TextEditingController();

  String? errorconfirmText;

  @override
  void dispose() {
    userPasswordController.clear();
    confirmUserPasswordController.clear();
    userPasswordController.dispose();
    confirmUserPasswordController.dispose();
    super.dispose();
  }

  String? validator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (userPasswordController.text == confirmUserPasswordController.text) {
        for (var values in rules.values) {
          if (!values(value)) {
            setState(() {
              errorconfirmText = 'Условия не соблюдены!';
            });
            return '';
          }
        }
        setState(() {
          errorconfirmText = null;
        });
        return null;
      } else {
        setState(() {
          errorconfirmText = 'Пароли не совпадают';
        });
        return '';
      }
    } else {
      setState(() {
        errorconfirmText = 'Условия не соблюдены!';
      });
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      formKey: formKey,
      content: [
        const Gap(100),
        const Text(
          'Придумайте новый пароль',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        const Gap(20),
        PasswordTextField(
          validator: validator,
          controller: userPasswordController,
        ),
        const Gap(15),
        PasswordTextField(
          controller: confirmUserPasswordController,
          labelText: 'Повторите пароль',
          errorText: errorconfirmText,
        ),
        const Gap(20),
        ...rules
            .map(
              (key, value) => MapEntry(
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outlined,
                          color: value(
                            userPasswordController.text,
                          )
                              ? palette.green
                              : Colors.white,
                        ),
                        const Gap(10),
                        Expanded(
                          child: Text(
                            key,
                            maxLines: 2,
                            style: TextStyle(
                                color: value(
                              userPasswordController.text,
                            )
                                    ? palette.green
                                    : Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                  ],
                ),
                false,
              ),
            )
            .keys
            .toList(),
        const Gap(20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(
              20,
            ),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pushNamed(context, '/username_register');
            }
          },
          child: const Text(
            'Далее',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
