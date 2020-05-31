import 'package:flutter/foundation.dart';

class Sentence {
  String value;
  bool isEdited = false;
  Sentence(this.value);
}

class Project with ChangeNotifier {
  String name;
  List<Sentence> sentences;
  String language;
}
