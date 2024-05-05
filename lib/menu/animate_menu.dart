import 'package:flutter/material.dart';
import 'package:taxi_code/services/misc_service.dart';

class AnimateMenu extends StatefulWidget {
  const AnimateMenu(
      {super.key, required this.menuItemsList, required this.menuService});

  @override
  State<AnimateMenu> createState() => _AnimateStateMenu();
  final List<Container> menuItemsList;
  final MenuService menuService;
}

class _AnimateStateMenu extends State<AnimateMenu> {
  GlobalKey<AnimatedListState> listkey = GlobalKey();
  late final IconButton menuItem;
  late List<Container> animateList = [
    Container(
      color: Colors.white,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.abc),
      ),
    ),
  ];

  @override
  initState() {
    widget.menuService.addListener(() {
      print('object changed');
      toggleMenu();
      setState(() {});
    });
    super.initState();
  }

  toggleMenu() {
    if (!widget.menuService.menuHidden) {
      //Close menu
      for (int i = 0; i < widget.menuItemsList.length; i++) {
        animateList.add(widget.menuItemsList[i]);
        listkey.currentState
            ?.insertItem(i + 1, duration: const Duration(milliseconds: 200));
      }
    } else {
      //Open menu
      for (int i = 1; i < widget.menuItemsList.length + 1; i++) {
        var removedItem = animateList.removeAt(1);
        listkey.currentState?.removeItem(1, (context, animation) {
          return buildItem(removedItem, 1, animation);
        }, duration: const Duration(milliseconds: 100));
      }
    }
  }

  buildItem(Widget item, int index, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(Tween<Offset>(
        begin: const Offset(0, -1),
        end: Offset.zero,
      )),
      child: FadeTransition(
          opacity: animation,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: item,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    animateList[0] = Container(
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
        padding: const EdgeInsets.all(10),
        onPressed: widget.menuService.toggleHideMenu,
        icon: const Icon(
          Icons.menu,
          size: 35,
        ),
        selectedIcon: const Icon(
          Icons.close,
          size: 35,
        ),
        isSelected: !widget.menuService.menuHidden,
      ),
    );
    print(widget.menuService.menuHidden);
    return SizedBox(
      width: 55,
      child: AnimatedList(
        shrinkWrap: true,
        key: listkey,
        initialItemCount: animateList.length,
        itemBuilder: (context, index, animation) {
          return buildItem(animateList[index], index, animation);
        },
      ),
    );
  }
}
