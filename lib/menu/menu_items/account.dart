import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_code/page_builder.dart';
import 'package:taxi_code/services/auth_service.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
          'Аккаунт',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        const Gap(50),
        Stack(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 200,
                ),
              ),
            ),
            Positioned(
              right: 80,
              bottom: 1,
              child: IconButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_rounded,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        const Gap(50),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text(
            'Изменить имя',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const Gap(10),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text(
            'Сбросить пароль',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(10),
        ElevatedButton(
          style: style,
          onPressed: () {
            AuthService().logout(context);
          },
          child: const Text(
            'Выйти из аккаунта',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
