import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_code/auth/auth_forms/username_form.dart';
import 'package:taxi_code/page_builder.dart';
import 'package:taxi_code/services/auth_service.dart';

class UsernameRegister extends StatefulWidget {
  const UsernameRegister({super.key});

  @override
  State<UsernameRegister> createState() => _UsernameRegisterState();
}

class _UsernameRegisterState extends State<UsernameRegister> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  String? validator(value) {
    if (value != null && value.isNotEmpty) {
      if (value.replaceAll(RegExp(r'[a-zA-Zа-яёА-ЯЁ]'), '').isEmpty) {
        return null;
      } else {
        return 'Ввод может содержать только латиницу и кириллицу';
      }
    } else {
      return 'Слишком короткое имя';
    }
  }

  void sendCode({name}) {}

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      formKey: formKey,
      content: [
        const Text(
          'Как к Вам обращаться?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        const Gap(10),
        UsernameTextField(
          validator: validator,
          controller: usernameController,
        ),
        const Gap(15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(
              20,
            ),
          ),
          onPressed: () {
            AuthService().signin(context);
          },
          child: const Text(
            'Завершить регистрацию',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
