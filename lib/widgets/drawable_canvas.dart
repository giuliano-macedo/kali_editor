import "package:flutter/material.dart";
import 'package:kali_editor/core/stroke.dart';

Offset _addOffset(Offset offset, double x2, double y2) {
  return Offset(offset.dx + x2, offset.dy + y2);
}

class DrawableCanvas extends StatefulWidget {
  final Size size;
  final bool scrollable;
  @override
  DrawableCanvas({@required this.scrollable, @required this.size});
  _DrawableCanvasState createState() => _DrawableCanvasState();
}

class _DrawableCanvasState extends State<DrawableCanvas> {
  List<Stroke> strokes = [];
  Offset cachedPos;
  ScrollController _scrollController = ScrollController();

  onStart(Offset offset) {
    final pos = _addOffset(offset, _scrollController.offset, 0);
    cachedPos = pos;
    print("start: $pos");
  }

  onUpdate(Offset offset) {
    setState(() {
      final pos = _addOffset(offset, _scrollController.offset, 0);
      strokes.add(Stroke.fromOffset(cachedPos, pos, 1)); //TODO penup
      cachedPos = pos;
      print("update: $pos");
    });
  }

  onEnd() {
    print("end $cachedPos");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onPanStart: (DragStartDetails details) =>
              onStart(details.localPosition),
          onPanUpdate: (DragUpdateDetails details) =>
              onUpdate(details.localPosition),
          onPanEnd: (DragEndDetails details) => onEnd(),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: widget.scrollable
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Container(
              width: widget.size.width,
              height: widget.size.height,
              child: CustomPaint(
                painter: _MyPainter(strokes),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _MyPainter extends CustomPainter {
  final List<Stroke> strokes;
  _MyPainter(this.strokes);
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.black
      ..isAntiAlias = true
      ..strokeWidth = 1.0;
    final paint2 = Paint()
      ..color = Colors.grey
      ..isAntiAlias = true
      ..strokeWidth = 1.0;

    for (var stroke in strokes) {
      if (stroke.penup == 1)
        canvas.drawLine(stroke.origin, stroke.destination, paint1);
      else
        canvas.drawLine(
            stroke.origin, stroke.destination, paint2); //TODO, dashed
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true; //TODO
}
