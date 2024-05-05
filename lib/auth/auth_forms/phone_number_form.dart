import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberTextField extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String? errorText;
  const PhoneNumberTextField(
      {super.key,
      required this.validator,
      required this.controller,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: TextInputType.number,
      controller: controller,
      maxLength: 10,
      style: const TextStyle(
        fontSize: 20,
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        errorText: errorText,
        isDense: true,
        counterText: '',
        hintText: '0556777358',
        labelText: 'Номер телефона',
      ),
    );
  }
}
