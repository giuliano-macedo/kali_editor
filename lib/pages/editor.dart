import 'package:auto_orientation/auto_orientation.dart';
import "package:flutter/material.dart";
import 'package:kali_editor/pages/settings.dart';

class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  List<bool> selectedMode = List.generate(6, (index) => index == 0);
  bool isLandscape = false;
  void undo() {
    //TODO
  }
  void redo() {
    //TODO
  }
  void undoPlus() {
    //TODO
  }
  void redoPlus() {
    //TODO
  }
  @override
  Widget build(BuildContext context) {
    if (!isLandscape) {
      //not sure if needed
      AutoOrientation.landscapeAutoMode();
      isLandscape = true;
    }
    final mediaQuery = MediaQuery.of(context);
    Size screenSize = mediaQuery.size;
    final bodyHeight =
        screenSize.height - mediaQuery.padding.top - kToolbarHeight;
    final bodyWidth = screenSize.width;

    print("dim=($bodyWidth,$bodyHeight)");

    return Scaffold(
        drawer: FractionallySizedBox(
          widthFactor: .1,
          heightFactor: 1,
          child: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SettingsPage()))),
                const Divider(
                  height: 20,
                  thickness: 2,
                ),
                //maybe slow
                RotatedBox(
                  quarterTurns: 1,
                  child: ToggleButtons(
                    onPressed: (index) {
                      switch (index) {
                        case 0:
                        case 1:
                          setState(() {
                            for (int i = 0; i < 2; i++)
                              selectedMode[i] = i == index;
                          });
                          break;
                        case 2:
                          return undo();
                        case 3:
                          return redo();
                        case 4:
                          return undoPlus();
                        case 5:
                          return redoPlus();
                      }
                    },
                    borderWidth: 0,
                    children: <Widget>[
                      RotatedBox(quarterTurns: 3, child: Icon(Icons.edit)),
                      RotatedBox(quarterTurns: 3, child: Icon(Icons.open_with)),
                      RotatedBox(quarterTurns: 3, child: Icon(Icons.undo)),
                      RotatedBox(quarterTurns: 3, child: Icon(Icons.redo)),
                      RotatedBox(quarterTurns: 3, child: Icon(Icons.undo)),
                      RotatedBox(quarterTurns: 3, child: Icon(Icons.redo)),
                    ],
                    isSelected: selectedMode,
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("<current strokes>"),
          leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {}, //TODO: add functionality
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {}, //TODO: add functionality
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: bodyWidth * 2,
                height: bodyHeight,
                child: Placeholder(
                  fallbackHeight: double.infinity,
                ),
              ),
            )
          ],
        ));
  }
}
