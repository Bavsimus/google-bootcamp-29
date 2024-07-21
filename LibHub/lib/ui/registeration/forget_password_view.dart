import 'package:flutter/material.dart';
import 'package:libhub/ui/registeration/forget_password_view_model.dart';
import 'package:libhub/widgets/custom_registeration_button.dart';
import 'package:libhub/widgets/user_registeration_data_field.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
        viewModelBuilder: () => ForgotPasswordViewModel(),
        onViewModelReady: (viewmodel) => viewmodel
            .init(), // viewmodel hazır olduğunda modelden init fonksiyonunu çağır
        disposeViewModel: false,
        builder: (context, viewmodel, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Forgot Password'),
                backgroundColor: const Color.fromARGB(255, 71, 188, 167),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Enter your email and we will send you a link to reset your password.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 20),
                  UserRegisterationDataField(
                    controller: viewmodel.emailController,
                    hintText: "Email",
                    labelText: "Email",
                    iconData: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  CustomRegisterationButton(
                    text: "Reset Password",
                    onPressed: () async {
                      viewmodel.pressOnResetPassword(context: context);
                    },
                  ),
                ],
              ),
            ));
  }
}
