import 'package:flutter/foundation.dart';
import 'package:kali_editor/providers/project.dart';

class Projects with ChangeNotifier {
  Map<String, Project> _data = {};

  List<Project> get items {
    return List.from(_data.values);
  }

  void add(Project p) {
    _data[p.name] = p;
    notifyListeners();
  }

  void remove(Project p) {
    if (!contains(p.name)) return;
    _data.remove(p.name);
    notifyListeners();
  }

  void update(Project p) {
    if (!contains(p.name)) return;
    add(p);
  }

  bool contains(String name) => _data.containsKey(name);
}
