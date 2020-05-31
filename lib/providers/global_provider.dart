import 'dart:io';

import 'package:path_provider/path_provider.dart';
import "package:flutter/foundation.dart";
import "dart:convert";

class GlobalProvider with ChangeNotifier {
  bool _isDarkMode = true;
  bool _isNewcomer = false;
  String _jsonPath;

  GlobalProvider(this._jsonPath) {
    _read();
  }

  _save() async {
    var f = await File(_jsonPath).open(mode: FileMode.write);
    await f.writeString(jsonEncode({
      "isNewcomer": _isNewcomer,
      "isDarkMode": _isDarkMode,
    }));
    await f.close();
  }

  _read() {
    final s = File(_jsonPath).readAsStringSync();
    Map<String, dynamic> jsonObject = jsonDecode(s);
    _isNewcomer = jsonObject["isNewcomer"] as bool;
    _isDarkMode = jsonObject["isDarkMode"] as bool;
  }

  get isDarkMode => _isDarkMode;
  get isNewcomer => _isNewcomer;

  set isNewcomer(bool data) {
    _isNewcomer = data;
    _save();
    notifyListeners();
  }

  set isDarkMode(bool data) {
    _isDarkMode = data;
    _save();
    notifyListeners();
  }
}
