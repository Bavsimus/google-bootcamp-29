import 'package:flutter/material.dart';
import 'package:libhub/app/libhub.dart';
import 'package:libhub/di/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI(); // call it after the binding so that they can be ready

  runApp(const LibHub());
}
