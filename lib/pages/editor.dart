import 'dart:collection';

import 'package:auto_orientation/auto_orientation.dart';
import "package:flutter/material.dart";
import 'package:kali_editor/core/stroke.dart';
import 'package:kali_editor/pages/settings.dart';
import 'package:kali_editor/providers/project.dart';
import "package:kali_editor/widgets/drawable_canvas.dart";
import 'package:provider/provider.dart';

class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  List<bool> selectedMode = List.generate(6, (index) => index == 0);
  List<Stroke> strokes = [];
  Queue<Stroke> undoCache = Queue<Stroke>();
  bool isLandscape = false;
  void undo() {
    setState(() {
      if (strokes.isNotEmpty) undoCache.add(strokes.removeLast());
    });
  }

  void redo() {
    setState(() {
      if (undoCache.isNotEmpty) strokes.add(undoCache.removeLast());
    });
  }

  void undoPlus() {
    //TODO
  }
  void redoPlus() {
    //TODO
  }
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<Project>(context);
    print("${[p.name, p.sentences, p.language]}");
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
                          selectedMode[0] = index == 0;
                          selectedMode[1] = index == 1;
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
        title: InkWell(
          child: Text("<current strokes>"),
          onTap: () => null, //todo maybe
        ),
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
      body: DrawableCanvas(
          scrollable: !selectedMode[0],
          size: Size(bodyWidth * 2, bodyHeight),
          strokes: strokes,
          onPenDown: (Offset offset) => undoCache.clear(),
          penDownColor: Theme.of(context).textTheme.bodyText1.color,
          penUpColor: Colors.grey),
    );
  }
}
