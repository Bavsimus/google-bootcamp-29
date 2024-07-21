import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libhub/app/app_base_view_model.dart';
import 'package:libhub/widgets/custom_dialog.dart';

class ForgotPasswordViewModel extends AppBaseViewModel {
  TextEditingController emailController = TextEditingController();

  @override
  init() {}

  Future pressOnResetPassword({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showCustomDialog(
          context: context,
          title: "Success!",
          text: "Password reset link has been sent to your email.");
    } catch (e) {
      log(e.toString());
      showCustomDialog(context: context, title: "Error!", text: e.toString());
    }
  }

  
}
