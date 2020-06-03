import 'package:kali_editor/utils/json_utils.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import "package:flutter/foundation.dart";

class GlobalProvider with ChangeNotifier {
  bool _isDarkMode = false;
  String _currProject;
  String _jsonPath;

  String _docPath;

  GlobalProvider([fileName = "global_provider.json"]) {
    _jsonPath = fileName;
    _read();
  }

  get _path async {
    if (_docPath == null)
      _docPath = (await syspath.getApplicationDocumentsDirectory()).path;
    return "$_docPath/$_jsonPath";
  }

  _save() async {
    await saveJsonFile(await _path, {
      "isDarkMode": _isDarkMode,
      "currProject": _currProject,
    });
  }

  _read() async {
    Map<String, dynamic> jsonObject = await readJsonIfExists(await _path);
    if (jsonObject == null) return;
    _isDarkMode = jsonObject["isDarkMode"] as bool;
    _currProject = jsonObject["_currProject"] as String;
    notifyListeners();
  }

  get isDarkMode => _isDarkMode;
  get isNewcomer => _currProject == null;
  get currProject => _currProject;

  set isDarkMode(bool data) {
    _isDarkMode = data;
    _save();
    notifyListeners();
  }

  set currProject(String projectName) {
    _currProject = projectName;
    _save();
    notifyListeners();
  }
}
