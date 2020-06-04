import 'package:kali_editor/utils/json_utils.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:flutter/foundation.dart';

class Projects with ChangeNotifier {
  Set<String> _data = {};
  String _jsonPath;
  String _docPath;
  Future<void> init;

  List<String> get items {
    return List.from(_data);
  }

  get _path async {
    if (_docPath == null)
      _docPath = (await syspath.getApplicationDocumentsDirectory()).path;
    return "$_docPath/$_jsonPath";
  }

  Projects([fileName = "projects.json"]) {
    _jsonPath = fileName;
    print("constructor");
    init = _read();
  }

  Future<void> _read() async {
    Map<String, dynamic> jsonObject = await readJsonIfExists(await _path);
    if (jsonObject == null) return;
    _data = Set<String>.from((jsonObject["projects"] as List<dynamic>)
        .map<String>((elem) => elem as String));
    print("data:$_data");
    notifyListeners();
  }

  _save() async {
    await saveJsonFile(await _path, {
      "projects": items,
    });
  }

  void add(String projectName) {
    _data.add(projectName);
    _save();
    notifyListeners();
  }

  void remove(String projectName) {
    if (!contains(projectName)) return;
    _data.remove(projectName);
    _save();
    notifyListeners();
  }

  void update(String projectName) {
    if (!contains(projectName)) return;
    add(projectName);
  }

  bool contains(String name) => _data.contains(name);
}
