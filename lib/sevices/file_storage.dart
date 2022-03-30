// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_storage/model/my_models.dart';

class FileStorageService {
  _getFilePath() async {
    var filePath = await getApplicationDocumentsDirectory();
    debugPrint(filePath.path);
    return filePath.path;
  }

  FileStorageService() {
    _createFile();
  }

  Future<File> _createFile() async {
    var file = File(await _getFilePath() + '/info.txt');
    return file;
  }

  void saveData(UserInformation userInformation) async {
    var file = await _createFile();
    await file.writeAsString(jsonEncode(userInformation));
  }

  Future<UserInformation> readData() async {
    try {
      var file = await _createFile();
      var dosyaStringicerik = await file.readAsString();
      var json = jsonDecode(dosyaStringicerik);
      return UserInformation.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
    }

    return UserInformation('', Gender.FEMALE, [], false);
  }
}