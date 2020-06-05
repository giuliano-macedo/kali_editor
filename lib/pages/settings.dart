import "package:flutter/material.dart";
import 'package:kali_editor/providers/global_provider.dart';
import 'package:provider/provider.dart';
import "package:package_info/package_info.dart";

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
              // TODO_LATER
              // ListTile(
              //   title: Text("Project path"),
              //   trailing: Text("/mnt/storage/todo"),
              //   onTap: () => null,
              // ),
              //push multiple editors on top of each other problem
              // ListTile(
              //   title: Text("New project"),
              //   onTap: () => Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (BuildContext context) => NewProjectPage(),
              //     ),
              //   ),
              // ),
              FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (_, AsyncSnapshot<PackageInfo> snapshot) =>
                    snapshot.connectionState != ConnectionState.done
                        ? Container()
                        : ListTile(
                            title: Text("About"),
                            onTap: () => showAboutDialog(
                              context: context,
                              applicationName: "Kali Editor",
                              applicationVersion: snapshot.data.version,
                              applicationIcon: Image(
                                image: AssetImage(
                                  "assets/launcher/icon_adaptive.png",
                                ),
                                width: 200,
                              ),
                              applicationLegalese:
                                  "A tool to generate online handwriting sequences in any language, based on some list of senteces",
                            ),
                          ),
              ),
            ],
          )),
    );
  }
}
