import 'package:flutter/material.dart';
import 'package:libhub/app/app.router.dart';
import 'package:libhub/app/app_base_view_model.dart';
import 'package:libhub/core/services/firebase_services.dart';

class LoginViewModel extends AppBaseViewModel {
  final formKey = GlobalKey<FormState>();
  final firebaseService = FirebaseService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool isChecked = false;

  @override
  init() {}

  Future<void> pressOnLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final result = await firebaseService.login(
          context, emailController.text, passwordController.text);

      // if (result == "PaidClient") {
        navigationService.navigateTo(Routes.homePage);
      // } else if (result == "FreeClient") {
      //   navigationService.navigateTo(Routes.freeClientHomePageView);
      // } else if (result == "Dietician") {
      //   navigationService.navigateTo(Routes.viewMyClients);
      // } else {
      //   showCustomDialog(context: context, title: "Error!", text: result!);
      // }
    }
    notifyListeners();
  }



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
