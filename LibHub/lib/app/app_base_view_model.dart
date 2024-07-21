import 'package:flutter/material.dart';
import 'package:libhub/core/di/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class AppBaseViewModel extends BaseViewModel {
  // BaseViewModel is a class from the stacked package
  NavigationService navigationService =
      getIt<NavigationService>(); // single instance kullanmak için -> DI


  //Repository repository = getIt<Repository>(); // -> lazım mı bilmemek commentli kalsın

  ThemeMode themeMode = ThemeMode.system;

  init() {
  }
}
