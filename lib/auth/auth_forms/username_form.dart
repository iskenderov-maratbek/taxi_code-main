import 'package:flutter/material.dart';

class UsernameTextField extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController controller;
  const UsernameTextField(
      {super.key, required this.validator, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLength: 10,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: const InputDecoration(
          isDense: true,
          counterText: '',
          hintText: 'Пример, Алмаз',
          errorMaxLines: 2),
    );
  }
}
