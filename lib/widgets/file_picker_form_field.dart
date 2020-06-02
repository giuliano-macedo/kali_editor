// to add focus node, it's hard
// https://blog.bam.tech/developer-news/build-a-flutter-form-with-custom-input-types

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerFormField extends StatelessWidget {
  final Function(String) validator;
  final Function(String) onSaved;
  final String labelText;
  final String hintText;
  final List<String> allowedExtensions;
  const FilePickerFormField(
      {Key key,
      this.validator,
      this.onSaved,
      this.labelText,
      this.hintText,
      this.allowedExtensions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: "",
      validator: validator,
      onSaved: onSaved,
      builder: (FormFieldState<String> state) => InkWell(
        onTap: () => FilePicker.getFile(
          allowedExtensions: allowedExtensions,
          type: FileType.custom,
        ).then((File f) {
          if (f == null) return;
          state.didChange(f.path);
          state.save();
        }),
        child: InputDecorator(
          decoration: InputDecoration(
            icon: Icon(Icons.folder),
            labelText: state.value.isNotEmpty ? labelText : hintText,
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: state.value.isEmpty,
          child: state.value.isEmpty ? Container() : Text(state.value),
        ),
      ),
    );
  }
}
