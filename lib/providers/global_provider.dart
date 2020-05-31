import "package:flutter/foundation.dart";
import 'package:kali_editor/providers/projects.dart';

class GlobalProvider with ChangeNotifier {
  //TODO store this data on device
  bool _isDarkMode;
  bool _isNewcomer;
  Projects _projects;

  GlobalProvider() {
    _isNewcomer = true;
    _isDarkMode = false;
    _projects = Projects();
  }

  get projects => _projects;
  get isDarkMode => _isDarkMode;
  get isNewcomer => _isNewcomer;

  set isNewcomer(bool data) {
    _isNewcomer = data;
    notifyListeners();
  }

  set isDarkMode(bool data) {
    _isDarkMode = data;
    notifyListeners();
  }
}
