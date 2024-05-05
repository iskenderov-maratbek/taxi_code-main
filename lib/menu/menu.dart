import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taxi_code/menu/animate_menu.dart';
import 'package:taxi_code/services/misc_service.dart';

class Menu extends StatefulWidget {
  const Menu({super.key, required this.menuService});

  @override
  State<Menu> createState() => _MenuState();
  final MenuService menuService;
}

class _MenuState extends State<Menu> {
  late final List<Container> menuItemsList = [
    itemBuilder(Icons.person_rounded, () {
      Navigator.pushNamed(context, '/account');
    }),
    itemBuilder(Icons.history_rounded, () {
      Navigator.pushNamed(context, '/history');
    }),
    itemBuilder(Icons.settings_rounded, () {
      Navigator.pushNamed(context, '/settings');
    }),
    itemBuilder(Icons.power_settings_new_rounded, () {
      exit(0);
    }),
  ];

  Container itemBuilder(IconData icon, function) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 0,
            blurRadius: 3,
          ),
        ],
      ),
      child: IconButton(
        onPressed: function,
        padding: const EdgeInsets.all(10),
        icon: Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimateMenu(
        menuItemsList: menuItemsList, menuService: widget.menuService);
  }
}
