class Stroke {
  static const header="xn,yn,xn+1,yn+1,pen_up_pen_down";
  int xn;
  int yn;
  int xnPlus;
  int ynPlus;
  int penup;

  Stroke(this.xn, this.yn, this.xnPlus, this.ynPlus, this.penup);
  String toCSV(){
    return "${this.xn},${this.yn},${this.xnPlus},${this.ynPlus},${this.penup}";
  }
}
