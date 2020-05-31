import 'package:flutter/foundation.dart';
import 'package:kali_editor/providers/project.dart';

class Projects with ChangeNotifier {
  List<Project> _items = [];

  List<Project> get items {
    return [..._items];
  }
}
