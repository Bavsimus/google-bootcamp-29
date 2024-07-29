import 'package:flutter/material.dart';
import 'package:libhub/app/app.router.dart';
import 'package:libhub/app/app_base_view_model.dart';
import 'package:libhub/core/services/firebase_services.dart';
import 'package:libhub/widgets/custom_dialog.dart';

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
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        final result = await firebaseService.login(
            context, emailController.text, passwordController.text);

        // If the login is successful, the user is redirected to the personal library page.
        if (result == "successful") {
          navigationService.clearStackAndShow(Routes.homePage);
        } else {
          // Handle login failure (e.g., show a message to the user)
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed. Please try again.')));
        }
      } catch (e) {
        // Handle any exceptions thrown during the login process
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred. Please try again.')));
      }
    }
    notifyListeners();
  }

  void pressOnContinueWithoutRegisteration(BuildContext context) {
    firebaseService.signInAnonymously();
    navigationService.clearStackAndShow(Routes.homePage);
  }

  void continueWithGoogle(BuildContext context) async{
    String res = await firebaseService.googleSignIn();
    if (res == "successful") {
      navigationService.clearStackAndShow(Routes.homePage);
    } else {
      // Handle login failure (e.g., show a message to the user)
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')));
    }
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
