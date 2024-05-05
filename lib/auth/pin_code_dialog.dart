import 'dart:ui';
import 'package:taxi_code/palette.dart' as palette;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_code/auth/auth_forms/pin_code_form.dart';

showPinCodeDialog(context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const SmsCodePage();
    },
  );
}

class SmsCodePage extends StatefulWidget {
  const SmsCodePage({super.key});

  @override
  State<SmsCodePage> createState() => _SmsCodePageState();
}

class _SmsCodePageState extends State<SmsCodePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController pinCodeCoontroller = TextEditingController();

  @override
  void dispose() {
    pinCodeCoontroller.dispose();
    super.dispose();
  }

  String? validator(String? value) {
    if (value != null && value.isNotEmpty && value.length == 4) {
      if (value == '0012') {
        return null;
      } else {
        return 'Неверный код!';
      }
    }
    return 'Неверный код!';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: palette.yellow), // Установите цвет границы здесь
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Введите код из SMS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            titlePadding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(15),
                    PinCodeForm(
                      validator: validator,
                      controller: pinCodeCoontroller,
                    ),
                    const Gap(15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(
                          20,
                        ),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text(
                        'Подтвердить код',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Gap(20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: palette.yellow,
                          padding: const EdgeInsets.all(
                            10,
                          ),
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          'Отмена',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
