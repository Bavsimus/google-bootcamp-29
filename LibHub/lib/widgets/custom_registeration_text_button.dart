// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomRegisterationTextButton extends StatelessWidget {
  VoidCallback onPressed;
  String text ;
   CustomRegisterationTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child:  Text(
        text,
        style: const TextStyle(
            color: Color.fromARGB(255, 47, 119, 106),
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}