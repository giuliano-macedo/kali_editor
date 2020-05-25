import "package:flutter_test/flutter_test.dart";
import 'package:kali_editor/core/stroke.dart';
import 'package:kali_editor/core/strokes_file_stream.dart';

void main() {
  test('csv test 1', () {
    final stream = StrokesFileStream("test.csv");

    stream.add(Stroke(0, 0, 0, 0, 0));
    stream.add(Stroke(0, 0, 0, 0, 0));
    stream.add(Stroke(0, 0, 0, 0, 0));

    stream.close();

    // n++;

    // expect(n, 0);
  });
}
