import 'package:flutter_storage/model/my_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  void saveData(UserInformation userInformation) async {
    final _name = userInformation.name;
    final preferences = await SharedPreferences.getInstance();

    preferences.setString('name', _name);
    preferences.setBool('student', userInformation.student);
    preferences.setInt('gender', userInformation.gender.index);
    preferences.setStringList('colors', userInformation.color);
  }

  Future<UserInformation> readData() async {
    final preferences = await SharedPreferences.getInstance();
    var _name = preferences.getString('name') ?? '';
    var _student = preferences.getBool('student') ?? false;

    var _chosenGender = Gender.values[preferences.getInt('gender') ?? 0];
    var _chosenColors = preferences.getStringList('colors') ?? <String>[];

    return UserInformation(_name, _chosenGender, _chosenColors, _student);
  }
}
