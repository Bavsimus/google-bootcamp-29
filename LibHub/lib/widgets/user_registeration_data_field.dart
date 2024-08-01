// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class UserRegisterationDataField extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hintText;
  final String labelText;
  final bool isObscureText;
  final bool isPassword;
  bool isCompulsory = false;
  String message = "";

  UserRegisterationDataField({
    super.key,
    required this.controller,
    required this.iconData,
    required this.hintText,
    required this.labelText,
    this.isObscureText = false,
    this.isPassword = false,
    this.isCompulsory = false,
  });

  bool obscureText = true;
  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 30),
      child: ValueListenableBuilder(
        valueListenable: _obscureTextNotifier,
        builder: (context, obscureText, child) {
          return TextFormField(
            obscureText: isObscureText && obscureText,
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _obscureTextNotifier.value =
                            !_obscureTextNotifier.value;
                      },
                    )
                  : null,
              hintText: hintText,
              prefixIcon: Icon(iconData,
                  color: const Color.fromARGB(255, 71, 188, 167)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(color: Colors.green, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 71, 188, 167),
                  width: 1.5,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter $labelText';
              }
              if (isPassword && value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            onSaved: (value) {},
          );
        },
      ),
    );
  }
}
