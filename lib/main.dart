import 'package:flutter/material.dart';
import 'package:kali_editor/pages/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue, textTheme: ButtonTextTheme.primary)),
      title: 'Material App',
      home: WelcomePage(),
    );
  }
}
