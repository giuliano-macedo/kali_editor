import 'dart:io';
import "dart:convert";

Future<dynamic> readJsonIfExists(String path) async {
  File f = File(path);
  if (!await f.exists()) return;
  final str = await f.readAsString();
  return jsonDecode(str);
}

Future<void> saveJsonFile(String path, dynamic obj) async {
  final f = await File(path).open(mode: FileMode.write);
  await f.writeString(jsonEncode(obj));
  await f.close();
}
