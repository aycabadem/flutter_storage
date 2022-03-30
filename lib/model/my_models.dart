// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum Gender { FEMALE, MALE, OTHER }

enum ColorType { YELLOW, RED, GREEN, BLUE }

class UserInformation {
  final String name;
  final Gender gender;
  final List<String> color;
  final bool student;

  UserInformation(this.name, this.gender, this.color, this.student);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': describeEnum(gender),
      'color': color,
      'student': student
    };
  }

  UserInformation.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        gender = Gender.values.firstWhere(
            (element) => describeEnum(element).toString() == json['gender']),
        color = List<String>.from(json['color']),
        student = json['student'];
}
