import 'package:flutter/material.dart';
import 'package:libhub/app/app.router.dart';
import 'package:libhub/app/app_base_view_model.dart';

class LoginViewModel extends AppBaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool isChecked = false;

  @override
  init() {}

  void goToSignUpPage() {
    navigationService.clearStackAndShow(Routes.signUpView);
  }

  void goToForgotPasswordPage() {
    navigationService.navigateTo(Routes.forgotPasswordView);
  }

  void goToHomePage() {
    navigationService.navigateTo(Routes.homePage);
  }
}
