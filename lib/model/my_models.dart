// ignore_for_file: constant_identifier_names

enum Gender { FEMALE, MALE, OTHER }

enum ColorType { YELLOW, RED, GREEN, BLUE }

class UserInformation {
  final String name;
  final Gender gender;
  final List<String> color;
  final bool student;

  UserInformation(this.name, this.gender, this.color, this.student);
}
