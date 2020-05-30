import 'dart:ui';

class Stroke {
  static const header = "xn,yn,xn+1,yn+1,pen_up_pen_down";
  int penup;

  Offset origin;
  Offset destination;

  Stroke(xn, yn, xnPlus, ynPlus, this.penup) {
    origin = Offset(xn, yn);
    destination = Offset(xnPlus, ynPlus);
  }
  Stroke.fromOffset(this.origin, this.destination, this.penup);

  get xn => origin.dx;
  get yn => origin.dy;
  get xnPlus => destination.dx;
  get ynPlus => destination.dy;

  String toCSV() {
    return "${this.xn},${this.yn},${this.xnPlus},${this.ynPlus},${this.penup}";
  }
}
