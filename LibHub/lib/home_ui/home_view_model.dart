import 'package:flutter/material.dart';
import 'package:libhub/home_ui/home_page_filtered.dart';
import 'package:libhub/home_ui/home_screen.dart';
import 'package:libhub/home_ui/add_book.dart';
import 'package:libhub/ui/personalLib/profile_tab.dart';
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
        return BookListScreen();
      case 1:
        return AddBook();
      case 2:
        return PersonalLibraryView();
      case 3:
        return ProfileTab();
      default:
        return BookListScreen();
    }
  }
}
