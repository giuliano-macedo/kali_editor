import "package:flutter/material.dart";
import 'package:kali_editor/providers/global_provider.dart';
import 'package:provider/provider.dart';

import 'new_project.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    return Scaffold(
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Text(
            "Welcome",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text("Lets start by creating a new project",
              textAlign: TextAlign.center),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Next"),
                onPressed: () {
                  globalProvider.isNewcomer = false;
                  return Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => NewProjectPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}
