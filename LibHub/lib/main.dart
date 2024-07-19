import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:libhub/app/libhub.dart';
import 'package:libhub/core/di/get_it.dart';
import 'package:libhub/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI(); // call it after the binding so that they can be ready
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LibHub());
}
