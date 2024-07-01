import 'package:flutter/material.dart';
import 'package:libhub/ui/registeration/login_view_model.dart';
import 'package:libhub/widgets/custom_registeration_button.dart';
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
                title: const Text('AppName',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                backgroundColor: const Color.fromARGB(255, 71, 188, 167),
              ),
              body: Center(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Checkbox(
                                value: viewmodel.isChecked,
                                onChanged: (value) {
                                  viewmodel.isChecked =
                                      value!; // TODO: Check this
                                },
                              ),
                              const Text(
                                "Remember Me",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: TextButton(
                                  onPressed: () {
                                    viewmodel.goToForgotPasswordPage();
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 119, 106),
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      CustomRegisterationButton(
                        text: "Login",
                        onPressed: () async {
                          // viewmodel.pressOnLogin(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: viewmodel.goToSignUpPage,
                            child: const Text(
                              "Sign Up!",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 47, 119, 106),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Continue without registeration!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 47, 119, 106),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
