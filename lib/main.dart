import 'package:flutter/material.dart';
import 'package:getting_started/widgets/ghflutter.dart';
import './constants/strings.dart' as strings;

void main() {
  runApp(const GHFlutterApp());
}

class GHFlutterApp extends StatelessWidget {
  const GHFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.appTitle,
      home: const GHFullter(),
    );
  }
}
