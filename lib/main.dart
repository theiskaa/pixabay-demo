import 'package:flutter/material.dart';
import 'package:pixabay_demo/app.dart';
import 'package:pixabay_demo/core/app/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Injection.initInjections();

  runApp(const App());
}
