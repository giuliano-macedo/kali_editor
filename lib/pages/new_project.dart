import "package:flutter/material.dart";
import 'package:kali_editor/pages/editor.dart';

class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final nameController = TextEditingController();
  String language;

  @override
  Widget build(BuildContext context) {
    Widget form = Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                icon: Icon(Icons.edit),
                labelText: "Project name",
                hintText: "Name of the project"),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => print("file picker"),
            child: FormField(
              builder: (FormFieldState<String> state) => InputDecorator(
                  decoration: InputDecoration(icon: Icon(Icons.folder)),
                  child: Text(
                    "Select a sentences.txt file",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 15),
                  )),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          FormField(
            builder: (FormFieldState<String> state) => InputDecorator(
              decoration: InputDecoration(
                  icon: Icon(Icons.language), labelText: "Project language"),
              isEmpty: language == "",
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: language,
                hint: Text("Selecte a language"),
                icon: Icon(Icons.arrow_downward),
                onChanged: (String newValue) =>
                    setState(() => language = newValue),
                items: ["Portuguese", "English"]
                    .map<DropdownMenuItem<String>>((String langOption) {
                  return DropdownMenuItem<String>(
                      value: langOption.toLowerCase(), child: Text(langOption));
                }).toList(),
              )),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          //   InkWell(
          //     child: ListTile(
          //       leading: Icon(Icons.folder),
          //       title: Text("Select a sentences.txt file"),
          //     ),
          //   )
        ],
      ),
    );
    return Scaffold(
        body: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Text(
          "New Project",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 25, left: 50, right: 25),
          child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: form,
              ))),
      Expanded(
        child: Container(),
      ),
      Padding(
        padding: EdgeInsets.all(30),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          RaisedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text("Save"),
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => EditorPage())),
          )
        ]),
      )
    ]));
  }
}
