import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_code/page_builder.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool light1 = true;
  final ButtonStyle style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(
      20,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      content: [
        Text(
          'Настройки',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        const Gap(50),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text(
            'Уведомления',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const Gap(10),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text(
            'Правила конфиденциальности',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(10),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text(
            'Сообщить об ошибке',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
