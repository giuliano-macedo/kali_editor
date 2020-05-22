import "package:flutter/material.dart";

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false; //TODO:Change to provider
  String projectPath = "/mnt/storage/todo";

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
                onTap: () => null, //TODO
              ),
              ListTile(
                title: Text("About"),
                onTap: () => null, //TODO
              ),
            ],
          )),
    );
  }
}
