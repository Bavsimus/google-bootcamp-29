import 'package:flutter/material.dart';
import 'package:libhub/ui/registeration/sign_up_view_model.dart';
import 'package:libhub/widgets/custom_registeration_button.dart';
import 'package:libhub/widgets/custom_registeration_text_button.dart';
import 'package:libhub/widgets/user_registeration_data_field.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        onViewModelReady: (viewmodel) => viewmodel
            .init(), // viewmodel hazır olduğunda modelden init fonksiyonunu çağır
        disposeViewModel: false,
        builder: (context, viewmodel, child) => Scaffold(
              appBar: AppBar(
                title: const Center(
                  child: Text('LibHub',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                backgroundColor: const Color.fromARGB(255, 71, 188, 167),
              ),
              body: SingleChildScrollView(
                child: Form(
                  child: Center(
                    child: Form(
                      key: viewmodel.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Let's create an account for you!",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          UserRegisterationDataField(
                            controller: viewmodel.userNameController,
                            hintText: "User Name",
                            labelText: "User Name",
                            iconData: Icons.person,
                            isCompulsory: true,
                          ),
                          const SizedBox(height: 10),
                          UserRegisterationDataField(
                            controller: viewmodel.emailController,
                            hintText: "Email",
                            labelText: "Email",
                            isCompulsory: true,
                            iconData: Icons.email,
                          ),
                          const SizedBox(height: 10),
                          UserRegisterationDataField(
                            controller: viewmodel.passwordController,
                            hintText: "Password",
                            labelText: "Password",
                            isCompulsory: true,
                            iconData: Icons.lock,
                            isObscureText: true,
                            isPassword: true,
                          ),
                          const SizedBox(height: 10),
                          UserRegisterationDataField(
                            controller: viewmodel.cityController,
                            hintText: "City",
                            labelText: "City",
                            isCompulsory: true,
                            iconData: Icons.location_city,
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
                          //         viewmodel.isChecked = value!; //TODO: Check this
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
                          const SizedBox(height: 10),
                          CustomRegisterationButton(
                              text: "Sign Up",
                              onPressed: () async {
                                viewmodel.pressOnSignIn(context);
                              }),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              CustomRegisterationTextButton(
                                  onPressed: viewmodel.goToLoginPage,
                                  text: "Login!"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
