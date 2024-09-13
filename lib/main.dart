import 'package:flutter/material.dart';
import 'package:pixabay_demo/app.dart';
import 'package:pixabay_demo/core/app/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Injection.initInjections();

  runApp(const App());
}
