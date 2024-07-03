import 'package:flutter/material.dart';
import 'package:libhub/app/app.router.dart';
import 'package:libhub/app/app_base_view_model.dart';

class SignUpViewModel extends AppBaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isChecked = false;

  @override
  init() {
   
  }

    void goToLoginPage() {
    navigationService.clearStackAndShow(Routes.loginView);
  }
}