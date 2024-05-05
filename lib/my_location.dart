import 'package:flutter/material.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue; // Синий цвет при нажатии
                }
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey; // Серый цвет при отключенном состоянии
                }
                return Colors.black;
              },
            ),
          ),
          onPressed: () {},
          icon: const IconTheme(
            data: IconThemeData(
              color: Colors.white,
            ),
            child: Icon(
              Icons.my_location,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
