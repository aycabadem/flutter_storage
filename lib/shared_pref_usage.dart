import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/sevices/shared_pref_service.dart';

class SharedPreferenceUsage extends StatefulWidget {
  const SharedPreferenceUsage({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceUsage> createState() => _SharedPreferenceUsageState();
}

class _SharedPreferenceUsageState extends State<SharedPreferenceUsage> {
  var _chosenGender = Gender.FEMALE;
  var _chosenColors = <String>[];
  var _studentInfo = false;
  final TextEditingController _nameController = TextEditingController();
  final _prefService = SharedPrefService();

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Usage'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
          ),
          for (var item in Gender.values)
            _buildRadioListTiles(describeEnum(item), item),
          for (var item in ColorType.values) _buildCheckboxListTile(item),
          SwitchListTile(
            title: const Text('Are you a student?'),
            value: _studentInfo,
            onChanged: (bool student) {
              _studentInfo = student;
              setState(() {});
            },
          ),
          TextButton(
            onPressed: () {
              var _userInfo = UserInformation(_nameController.text,
                  _chosenGender, _chosenColors, _studentInfo);

              _prefService.saveData(_userInfo);
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxListTile(ColorType color) {
    return CheckboxListTile(
      title: Text(describeEnum(color)),
      value: _chosenColors.contains(describeEnum(color)),
      onChanged: (bool? value) {
        if (value == false) {
          _chosenColors.remove(describeEnum(color));
        } else {
          _chosenColors.add(describeEnum(color));
        }
        setState(() {});
      },
    );
  }

  Widget _buildRadioListTiles(String title, Gender gender) {
    return RadioListTile(
        title: Text(title),
        value: gender,
        groupValue: _chosenGender,
        onChanged: (Gender? pickedGender) {
          setState(() {
            _chosenGender = pickedGender!;
          });
        });
  }

  void _readData() async {
    var info = await _prefService.readData();
    _nameController.text = info.name;
    _chosenColors = info.color;
    _chosenGender = info.gender;
    _studentInfo = info.student;
    setState(() {});
  }
}
