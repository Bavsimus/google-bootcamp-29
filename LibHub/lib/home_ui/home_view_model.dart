import 'package:flutter/material.dart';
import 'package:libhub/home_ui/home_screen.dart';

import 'package:libhub/ui/personalLib/personal_library_view.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  init() {}

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return PersonalLibraryView();
      case 2:
        return HomeScreen();
      default:
        return HomeScreen();
    }
  }
}
