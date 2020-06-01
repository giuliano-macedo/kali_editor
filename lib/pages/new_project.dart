import "package:kali_editor/widgets/file_picker_form_field.dart";
import "package:flutter/material.dart";
import 'package:kali_editor/pages/editor.dart';
import 'package:kali_editor/widgets/language_picker_form_field.dart';

class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final nameController = TextEditingController();
  String sentencesPath;
  String language;
  _buildForm() {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            validator: (txt) => txt.isEmpty ? "Please fill this field." : null,
            decoration: InputDecoration(
              icon: Icon(Icons.edit),
              labelText: "Project name",
              hintText: "Name of the project",
            ),
          ),
          SizedBox(height: 15),
          FilePickerFormField(
            validator: (txt) => txt.isEmpty ? "Please pick a file." : null,
            onSaved: (txt) => sentencesPath = txt,
            hintText: "Project sentences.txt file",
            labelText: "Sentences file",
            allowedExtensions: ["txt", "csv"],
          ),
          SizedBox(height: 15),
          LanguagePickerFormField(
              validator: (txt) =>
                  txt.isEmpty ? "Please select a language." : null,
              onSaved: (txt) => language = txt,
              hintText: "Project written language",
              labelText: "Written Language"),
          // FormField(
          //   validator: (txt) =>
          //       txt.isEmpty ? "Please select a language." : null,
          //   builder: (FormFieldState<String> state) => InputDecorator(
          //     decoration: InputDecoration(
          //         icon: Icon(Icons.language), labelText: "Project language"),
          //     isEmpty: language == "",
          //     child: DropdownButtonHideUnderline(
          //         child: DropdownButton<String>(
          //       value: language,
          //       hint: Text("Selecte a language"),
          //       icon: Icon(Icons.arrow_downward),
          //       onChanged: (String newValue) =>
          //           setState(() => language = newValue),
          //       items:
          //           LANGLIST.map<DropdownMenuItem<String>>((String langOption) {
          //         return DropdownMenuItem<String>(
          //           value: langOption.toLowerCase(),
          //           child: Text(langOption),
          //         );
          //       }).toList(),
          //     )),
          //   ),
          // ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 100),
          Text(
            "New Project",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: _buildForm(),
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                    onPressed: () {
                      //TODO save project state
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditorPage(),
                        ),
                      );
                    },
                  )
                ]),
          )
        ],
      ),
    );
  }
}
