import 'dart:async';
import "dart:io";

import 'package:kali_editor/core/stroke.dart';

enum _Operation {
  write, //write a single stroke
  delete, //delete single stroke
  stop //stop an close file
}

class _Event {
  _Operation op;
  Stroke data;
  _Event(this.op, this.data);
}

class StrokesFileStream {
  RandomAccessFile stream;
  StreamController<_Event> queue;
  StrokesFileStream(String fileName) {
    stream = File(
      fileName,
    ).openSync(mode: FileMode.write);
    //whenever there is a event i the queue, execute its operation
    _queueStream().listen((_Event event) {
      switch (event.op) {
        case _Operation.write:
          _write(event.data);
          break;
        case _Operation.delete:
          _delete();
          break;
        default:
          throw Exception("Unexpected error");
      }
    });
  }
  Stream<_Event> _queueStream() async* {
    await for (var event in queue.stream) {
      if (event.op == _Operation.stop) break;
      yield event;
    }
  }

  void _write(Stroke stroke) {
    stream.writeStringSync(stroke.toCSV());
  }

  void _delete() {
    //TODO:PROBLEM
    int lineLength;
    stream.setPositionSync(lineLength);
    stream.writeByteSync(-1);
  }

  void add(Stroke stroke) {
    queue.add(_Event(_Operation.write, stroke));
  }

  void remove(int n) {
    assert(n > 0);
    for (int i = 0; i < n; i++) queue.add(_Event(_Operation.delete, null));
  }

  void close() {
    queue.add(_Event(_Operation.stop, null));
  }
}
