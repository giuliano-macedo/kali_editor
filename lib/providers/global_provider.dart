import 'dart:io';

import 'package:path_provider/path_provider.dart';
import "package:flutter/foundation.dart";
import "dart:convert";

class GlobalProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _isNewcomer = true;
  String _jsonPath;

  String _docPath;

  GlobalProvider([fileName = "global_provider.json"]) {
    _jsonPath = fileName;
    _read();
  }

  get _path async {
    if (_docPath == null)
      _docPath = (await getApplicationDocumentsDirectory()).path;
    return "$_docPath/$_jsonPath";
  }

  _save() async {
    var f = await File(await _path).open(mode: FileMode.write);
    await f.writeString(jsonEncode({
      "isNewcomer": _isNewcomer,
      "isDarkMode": _isDarkMode,
    }));
    await f.close();
  }

  _read() async {
    File f = File(await _path);
    if (!await f.exists()) return;
    final s = await f.readAsString();
    Map<String, dynamic> jsonObject = jsonDecode(s);
    _isNewcomer = jsonObject["isNewcomer"] as bool;
    _isDarkMode = jsonObject["isDarkMode"] as bool;
    notifyListeners();
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
