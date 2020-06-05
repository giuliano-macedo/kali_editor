import "dart:io";
// Dataset directory structure
// basePath:
//   rootPath:
//     datasetPath:
//       000.csv
//       ....
//       n.csv
//     meta.json

class DatasetDir {
  Directory base;
  Directory root;
  Directory dataset;
  DatasetDir(String basePath, String rootDir) {
    base = Directory(basePath);
    if (!base.existsSync())
      throw FileSystemException(
          "base Directory '${base.path}' does not exists");
    root = _createDirIfNotExist("$basePath/$rootDir");
    dataset = _createDirIfNotExist("$basePath/$rootDir/data");
  }

  Directory _createDirIfNotExist(String path) {
    final ans = Directory(path);
    if (!ans.existsSync()) ans.createSync();
    return ans;
  }

  get basePath => base.path;
  get rootDir => root.path;
  get datasetPath => dataset.path;

  List<String> getDatasetFilesPath() => dataset
      .listSync()
      .where((entity) => entity is File)
      .map((entity) => entity.path)
      .toList();
}
