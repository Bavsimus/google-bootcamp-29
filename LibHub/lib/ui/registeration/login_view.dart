// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:libhub/ui/registeration/login_view_model.dart';
import 'package:libhub/widgets/continue_with_google_button.dart';
import 'package:libhub/widgets/custom_divider.dart';
import 'package:libhub/widgets/custom_registeration_button.dart';
import 'package:libhub/widgets/custom_registeration_text_button.dart';
import 'package:libhub/widgets/user_registeration_data_field.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onViewModelReady: (viewmodel) => viewmodel
            .init(), // viewmodel hazır olduğunda modelden init fonksiyonunu çağır
        disposeViewModel: false,
        builder: (context, viewmodel, child) => Scaffold(
              appBar: AppBar(
                title: const Center(
                  child:  Text('LibHub',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                backgroundColor: const Color.fromARGB(255, 71, 188, 167),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: viewmodel.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 100),
                        UserRegisterationDataField(
                          controller: viewmodel.emailController,
                          hintText: "Email",
                          labelText: "Email",
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 10),
                        UserRegisterationDataField(
                          controller: viewmodel.passwordController,
                          hintText: "Password",
                          labelText: "Password",
                          isObscureText: true,
                          iconData: Icons.lock,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Checkbox(
                        //       value: viewmodel.isChecked,
                        //       onChanged: (value) {
                        //         viewmodel.isChecked =
                        //             value!; // TODO: Check this
                        //       },
                        //     ),
                        //     const Text(
                        //       "Remember Me",
                        //       style: TextStyle(
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: CustomRegisterationTextButton(
                              onPressed: () {
                                viewmodel.goToForgotPasswordPage();
                              },
                              text: "Forgot Password?",
                            ),
                          ),
                        ),
                        CustomRegisterationButton(
                          text: "Login",
                          onPressed: () async {
                            viewmodel.pressOnLogin(context);
                          },
                        ),
                        CustomDivider(text: "or"),
                        ContinueWithGoogle(onPressed: () {
                          viewmodel.continueWithGoogle(context);
                        }),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            CustomRegisterationTextButton(
                              onPressed: viewmodel.goToSignUpPage,
                              text: "Sign Up!",
                            ),
                          ],
                        ),
                        CustomRegisterationTextButton(
                            onPressed: () {
                              viewmodel
                                  .pressOnContinueWithoutRegisteration(context);
                            },
                            text: "Continue without registeration!"),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
