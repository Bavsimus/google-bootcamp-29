import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:libhub/app/app.router.dart';
import 'package:libhub/app/app_base_view_model.dart';
import 'package:libhub/core/services/firebase_services.dart';
import 'package:libhub/widgets/custom_dialog.dart';

class SignUpViewModel extends AppBaseViewModel {
  final formKey = GlobalKey<FormState>();
  final firebaseService = FirebaseService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isChecked = false;

  @override
  init() {}

  void goToLoginPage() {
    navigationService.clearStackAndShow(Routes.loginView);
  }

  Future<void> pressOnSignIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final result = await firebaseService.signIn(
          context: context,
          userName: userNameController.text,
          email: emailController.text,
          password: passwordController.text);
      log("sign in viewmodel() ->" + result.toString());
      // if (result) {
      navigationService.clearStackAndShow(Routes.homePage);
      // } else {
      //   showCustomDialog(context: context, title: "Error!", text: result!);
      // }
    }
    notifyListeners();
  }

    
}
