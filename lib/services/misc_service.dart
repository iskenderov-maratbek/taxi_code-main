import 'package:flutter/material.dart';

class MenuService extends ChangeNotifier {
  bool _menuHidden = true;
  get menuHidden => _menuHidden;

  void toggleHideMenu() {
    _menuHidden = !_menuHidden;
    notifyListeners();
  }

  hideMenu() {
    if (!_menuHidden) {
      _menuHidden = true;
      notifyListeners();
    }
  }
}
