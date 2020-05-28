import 'package:flutter/material.dart';
import 'package:kali_editor/pages/editor.dart';
import 'package:kali_editor/pages/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final isNewcomer = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue, textTheme: ButtonTextTheme.primary)),
      title: 'Material App',
      home: isNewcomer ? WelcomePage() : EditorPage(),
    );
  }
}
