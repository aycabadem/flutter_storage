// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/sevices/local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  late final FlutterSecureStorage preferences;
  SecureStorageService() {
    preferences = FlutterSecureStorage();
  }
  @override
  Future<void> saveData(UserInformation userInformation) async {
    final _name = userInformation.name;
    // final preferences = await SharedPreferences.getInstance();

    await preferences.write(key: 'name', value: _name);
    await preferences.write(
        key: 'student', value: userInformation.student.toString());
    await preferences.write(
        key: 'gender', value: userInformation.gender.index.toString());
    await preferences.write(
        key: 'colors', value: jsonEncode(userInformation.color));
    //preferences.setStringList('colors', userInformation.color);
  }

  @override
  Future<UserInformation> readData() async {
    var _name = await preferences.read(key: 'name') ?? '';
    var _studentString = await preferences.read(key: 'student') ?? 'false';
    var _student = _studentString.toLowerCase() == 'true' ? true : false;
    var _chosenGenderString = await preferences.read(key: 'gender') ?? '0';
    var _chosenGender = Gender.values[int.parse(_chosenGenderString)];
    var _chosenColorsString = await preferences.read(key: 'colors') ?? '';
    var _chosenColors = _chosenColorsString == null
        ? <String>[]
        : List<String>.from(jsonDecode(_chosenColorsString));

    return UserInformation(_name, _chosenGender, _chosenColors, _student);
  }
}
