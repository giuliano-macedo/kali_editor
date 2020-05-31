import 'dart:io';

import "package:flutter/material.dart";
import 'package:kali_editor/providers/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:yaml/yaml.dart';

import 'new_project.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
          body: ListView(
            children: <Widget>[
              SwitchListTile(
                value: globalProvider.isDarkMode,
                title: Text("Dark mode"),
                onChanged: (value) =>
                    setState(() => globalProvider.isDarkMode = value),
              ),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              // REMOVED TO WASTE LESS TIME IN DEV
              // ListTile(
              //   title: Text("Project path"),
              //   trailing: Text("/mnt/storage/todo"),
              //   onTap: () => null,
              // ),
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
