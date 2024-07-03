import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContinueWithGoogle extends StatelessWidget {
  final VoidCallback onPressed;
  const ContinueWithGoogle({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 71, 188, 167), width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color.fromARGB(255, 226, 226, 226),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/google.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 20),
              const Text(
                "Continue with Google",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 47, 119, 106)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
