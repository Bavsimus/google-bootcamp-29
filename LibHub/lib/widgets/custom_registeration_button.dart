import 'package:flutter/material.dart';

class CustomRegisterationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomRegisterationButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color.fromARGB(255, 71, 188, 167),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
