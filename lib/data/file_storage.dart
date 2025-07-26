import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> getDataFromFile() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    final file = File('${path}/data.txt');
    if (await file.exists() == false) {
      await file.create(recursive: true);
    }
    return file.readAsString();
  }

  Future<void> writeDataToFile(String data) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    final file = File('${path}/data.txt');
    if (await file.exists() == false) {
      await file.create(recursive: true);
    }
    await file.writeAsString(data, mode: FileMode.append);
  }
}
