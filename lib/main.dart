import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kali_editor/pages/editor.dart';
import 'package:kali_editor/pages/welcome.dart';
import 'package:kali_editor/providers/global_provider.dart';
import "package:provider/provider.dart";

void main() => runApp(MyApp());

ThemeData _lightTheme = ThemeData.light().copyWith(
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
);

ThemeData _darkTheme = ThemeData.dark().copyWith(
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white,
    textTheme: ButtonTextTheme.primary,
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => GlobalProvider("globalProvider.json"),
        ),
      ],
      child: MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context);
    return MaterialApp(
      theme: globalProvider.isDarkMode ? _darkTheme : _lightTheme,
      title: 'Kali Editor',
      home: globalProvider.isNewcomer ? WelcomePage() : EditorPage(),
    );
  }
}
