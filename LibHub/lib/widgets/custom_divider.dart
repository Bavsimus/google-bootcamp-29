// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  String text;
  CustomDivider({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Divider(
              thickness: 1,
              color: Color.fromARGB(255, 47, 119, 106),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 47, 119, 106)),
            ),
          ),
          const Expanded(
            child: Divider(
              thickness: 1,
              color: Color.fromARGB(255, 47, 119, 106),
            ),
          ),
        ],
      ),
    );
  }
}
