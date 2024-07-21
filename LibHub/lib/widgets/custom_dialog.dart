import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Future<dynamic> showCustomDialog(
    {required BuildContext context, required String title, required String text}) {
  return showPlatformDialog(
      context: context,
      builder: (context) {
        return PlatformAlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back"))
          ],
        );
      });
}