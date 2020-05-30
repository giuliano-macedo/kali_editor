import 'dart:io';

import "package:flutter/material.dart";
import 'package:yaml/yaml.dart';

import 'new_project.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false; //TODO:Change to provider
  String projectPath = "/mnt/storage/todo";
  Map appConfig;

  @override
  void initState() {
    File("../../pubspec.yaml")
        .readAsString()
        .then((String content) => appConfig = loadYaml(content));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
          body: ListView(
            children: <Widget>[
              SwitchListTile(
                value: isDarkMode,
                title: Text("Dark mode"),
                onChanged: (value) => setState(() => isDarkMode = value),
              ),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              ListTile(
                title: Text("Project path"),
                trailing: Text(projectPath),
                onTap: () => null, //TODO
              ),
              ListTile(
                title: Text("New project"),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => NewProjectPage(),
                  ),
                ),
              ),
              ListTile(
                title: Text("About"),
                onTap: () => showAboutDialog(
                  context: context,
                  applicationName: "Kali Editor",
                  applicationVersion: appConfig["version"],
                  applicationIcon: null, //TODO
                  applicationLegalese:
                      "A tool to generate online handwriting sequences in any language, based on some list of senteces",
                ),
              ),
            ],
          )),
    );
  }
}
