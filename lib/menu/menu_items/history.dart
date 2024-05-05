import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_code/page_builder.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
          'История поездок',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        const Gap(50),
        const ListTile()
      ],
    );
  }
}
