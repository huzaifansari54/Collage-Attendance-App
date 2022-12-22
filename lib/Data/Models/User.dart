import 'dart:math';

class UserModel {
  UserModel(
      {required this.name,
      required this.imageUrl,
      required this.lastName,
      required this.rollNumber,
      required this.uid,
      required this.enrollNumber,
      required this.semster,
      required this.classProgram});
  final String name;
  String uid;
  final String lastName;
  final String rollNumber;
  final String enrollNumber;
  final String classProgram;
  final String semster;

  String imageUrl;

  void setImageAndUid(String img, String uid) {
    imageUrl = img;
    this.uid = uid;
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'lastName': lastName,
      'rollNumber': rollNumber,
      'imageUrl': imageUrl,
      'enrollNumber': enrollNumber,
      'semster': semster,
      'classProgram': classProgram
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        name: map['name'],
        imageUrl: map['imageUrl'],
        lastName: map['lastName'],
        rollNumber: map['rollNumber'],
        enrollNumber: map['enrollNumber'] ?? '6186',
        classProgram: map['classProgram'] ?? 'BCA',
        semster: map['semster'] ?? 'first');
  }
}
