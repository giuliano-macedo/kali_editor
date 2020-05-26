import 'dart:async';
import 'dart:collection';
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
  StreamController<_Event> opQueue;
  Queue<int> _positions;
  StreamSubscription<_Event> _subscription;
  String fileName;
  bool _isOpened;

  StrokesFileStream(this.fileName) {
    opQueue = new StreamController<_Event>();
    _positions = new Queue<int>();
    _isOpened = false;
  }

  void open() async {
    stream = File(fileName).openSync(mode: FileMode.append);
    if (stream.lengthSync() == 0)
      stream.writeStringSync(Stroke.header + "\n");
    else
      _parsePositions();
    //whenever there is a event in the opQueue, execute its operation
    _subscription = opQueue.stream.listen(_streamListener);
    _isOpened = true;
  }

  void _parsePositions([buffsize = 4096]) {
    //get every string \n position, so that it can be properly deleted
    // it will set position to 0 initially, then to final
    final List<int> buff = List<int>(buffsize);
    final List<int> ans = [];
    int pos = 0, bytesRead;
    stream.setPositionSync(0);
    do {
      bytesRead = stream.readIntoSync(buff);
      for (int i = 0; i < bytesRead; i++) {
        if (buff[i] == "\n".codeUnitAt(0)) {
          ans.add(pos + i + 1);
        }
      }
      pos += bytesRead;
    } while (bytesRead != 0);
    for (int p in ans.getRange(0, ans.length - 1)) _positions.addFirst(p);
  }

  void _streamListener(_Event event) {
    switch (event.op) {
      case _Operation.write:
        _write(event.data);
        break;
      case _Operation.delete:
        _delete();
        break;
      case _Operation.stop:
        opQueue.close();
        break;
    }
  }

  void _write(Stroke stroke) {
    int pos = stream.positionSync();
    _positions.addFirst(pos);
    stream.writeStringSync(stroke.toCSV() + "\n");
  }

  void _delete() {
    if (_positions.isEmpty) throw Exception("impossible delete again");
    int length = _positions.removeFirst();
    stream.truncateSync(length);
  }

  void add(Stroke stroke) {
    opQueue.add(_Event(_Operation.write, stroke));
  }

  void remove(int n) {
    assert(n > 0);
    for (int i = 0; i < n; i++) opQueue.add(_Event(_Operation.delete, null));
  }

  void close([void Function() onClose]) {
    assert(_isOpened);
    if (onClose != null) _subscription.onDone(onClose);
    opQueue.add(_Event(_Operation.stop, null));
  }
}
