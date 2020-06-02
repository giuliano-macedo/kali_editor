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
  final _formKey = GlobalKey<FormState>();
  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MediaQuery.of(context).orientation == Orientation.portrait
              ? SizedBox(height: 130)
              : Container(),
          Text(
            "New Project",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            validator: (txt) =>
                txt.isEmpty ? "Please set the project name." : null,
            decoration: InputDecoration(
              icon: Icon(Icons.edit),
              labelText: "Project name",
              hintText: "Name of the project",
            ),
          ),
          const SizedBox(height: 15),
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
            labelText: "Written Language",
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  void _submit() {
    //TODO save project state
    if (!_formKey.currentState.validate()) return;

    print("VALID:${[nameController.text, sentencesPath, language]}");

    return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditorPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: _buildForm(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                  onPressed: _submit,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
