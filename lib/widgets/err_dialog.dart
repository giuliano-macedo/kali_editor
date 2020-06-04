import "package:flutter/material.dart";

class ErrDialog extends StatelessWidget {
  final String errMessage;
  const ErrDialog(this.errMessage, {Key key}) : super(key: key);
  static dialog(BuildContext context, String errMessage) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrDialog(errMessage);
        },
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Error"),
        content: Text(errMessage),
        actions: [
          FlatButton(
            child: Text("Ok"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]);
  }
}
