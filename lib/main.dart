// TODO ad read/write permissions in android/ios

import 'package:flutter/material.dart';
import 'package:kali_editor/pages/editor.dart';
import 'package:kali_editor/pages/welcome.dart';
import 'package:kali_editor/providers/global_provider.dart';
import 'package:kali_editor/providers/project.dart';
import "package:provider/provider.dart";

void main() => runApp(MyApp());

const myCyan = Color.fromRGBO(0, 178, 255, 1);
const myCyanDarkened = Color.fromRGBO(55, 67, 73, 1);

ThemeData _lightTheme = ThemeData.light().copyWith(
  primaryColor: myCyan,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
);

ThemeData _darkTheme = ThemeData.dark().copyWith(
  primaryColor: myCyanDarkened,
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
          create: (ctx) => GlobalProvider(),
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
      home: globalProvider.isNewcomer
          ? WelcomePage()
          : ChangeNotifierProvider(
              create: (ctx) => Project(globalProvider.currProject),
              child: EditorPage(),
            ),
    );
  }
}
