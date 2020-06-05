import 'dart:io';
import 'package:kali_editor/core/strokes_file_stream.dart';
import 'package:kali_editor/utils/dataset_dir.dart';
import 'package:kali_editor/utils/json_utils.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:flutter/foundation.dart';
import "dart:math";

class Sentence {
  String value;
  bool isEdited;
  Sentence(this.value, [this.isEdited = false]);
  String toString() {
    return "Sentence($value,$isEdited)";
  }
}

double _log10(double x) => log(x) / ln10;

class Project with ChangeNotifier {
  String _name;
  List<Sentence> _sentences = [];
  String _language;
  String _docPath;
  String _sdPath;
  Future<void> init;

  Project(this._name) {
    init = _read();
  }

  Project.fromSentencesFile(this._name, String path, this._language) {
    _sentences = File(path)
        .readAsLinesSync()
        .where((line) => line.isNotEmpty)
        .map((line) => Sentence(line))
        .toList();
    _save();
  }

  get _path async {
    if (_docPath == null)
      _docPath = (await syspath.getApplicationDocumentsDirectory()).path;
    return "$_docPath/$_name.json";
  }

  get sdPath async {
    if (_sdPath == null)
      _sdPath = (await syspath.getExternalStorageDirectory()).path;
    return _sdPath;
  }

  Future<void> _read() async {
    Map<String, dynamic> jsonObject = await readJsonIfExists(await _path);
    if (jsonObject == null) return;

    _name = jsonObject["name"] as String;
    _sentences = (jsonObject["sentences"] as List<dynamic>).map((dynamic arg) {
      final tuple = arg as List<dynamic>;
      return Sentence(
        tuple[0] as String,
        tuple[1] as bool,
      );
    }).toList();
    _language = jsonObject["language"] as String;

    notifyListeners();
  }

  _save() async {
    await saveJsonFile(await _path, {
      "name": _name,
      "sentences": _sentences
          .map((sentence) => [sentence.value, sentence.isEdited])
          .toList(),
      "language": _language,
    });
  }

  Future<StrokesFileStream> getStrokeFileStreamAt(int index) async {
    assert(index < sentences.length && index >= 0);
    final datasetDir = DatasetDir(await sdPath, name);
    final n = _log10(sentences.length).ceil().toInt();
    final fileName = index.toString().padLeft(n);
    return StrokesFileStream("${datasetDir.datasetPath}/$fileName.csv");
  }

  void setSentenceEdited(int index) {
    _sentences[index].isEdited = true;
    _save();
    notifyListeners();
  }

  get name => _name;
  get sentences => _sentences;
  get language => _language;
}
