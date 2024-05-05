import 'package:flutter/material.dart';
import 'package:taxi_code/palette.dart' as palette;

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key,
      this.validator,
      required this.controller,
      this.errorText,
      this.labelText = 'Пароль'});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String labelText;
  final String? errorText;
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscurePassword = true;
  bool confirmObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: obscurePassword,
      controller: widget.controller,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        errorText: widget.errorText,
        isDense: true,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          child: IconButton(
            disabledColor: palette.white,
            padding: const EdgeInsets.only(
              right: 20,
            ),
            selectedIcon: const Icon(
              Icons.visibility_off_outlined,
            ),
            icon: const Icon(
              Icons.visibility_outlined,
            ),
            iconSize: 30,
            isSelected: obscurePassword,
            onPressed: null,
          ),
        ),
        labelText: widget.labelText,
      ),
    );
  }
}
