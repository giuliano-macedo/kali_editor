import "package:flutter/material.dart";
import "package:kali_editor/utils/lang_list.dart";

class LanguagePickerFormField extends StatelessWidget {
  final Function(String) validator;
  final Function(String) onSaved;
  final String labelText;
  final String hintText;

  const LanguagePickerFormField({
    Key key,
    this.validator,
    this.onSaved,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  Future<String> _openLanguagePickerDialog(BuildContext context) =>
      showDialog<String>(
        context: context,
        builder: (_) => Dialog(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: LANGLIST.length,
              itemBuilder: (_, int index) => ListTile(
                onTap: () => Navigator.of(context).pop(LANGLIST[index]),
                title: Text(LANGLIST[index]),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: "",
      validator: validator,
      onSaved: onSaved,
      builder: (FormFieldState<String> state) => InkWell(
        onTap: () => _openLanguagePickerDialog(context).then((String val) {
          if (val == null || val.isEmpty) return;
          state.didChange(val);
          state.save();
        }),
        child: InputDecorator(
          decoration: InputDecoration(
            icon: Icon(Icons.language),
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
