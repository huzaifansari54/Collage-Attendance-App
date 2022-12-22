class AttendanceModel {
  final String name;
  final String enrollNumber;
  final String lastName;
  final String rollNumber;
  final String dateTime;
  final String attendance;
  final String currentAddress;
  int numOfPresents;

  AttendanceModel(
      {required this.numOfPresents,
      required this.attendance,
      required this.currentAddress,
      required this.dateTime,
      required this.enrollNumber,
      required this.lastName,
      required this.name,
      required this.rollNumber});
  factory AttendanceModel.fromJson(Map<String, dynamic> map) {
    return AttendanceModel(
        attendance: map['attendance'],
        currentAddress: map['currentAddress'],
        dateTime: map['dateTime'],
        enrollNumber: map['enrollNumber'],
        lastName: map['lastName'],
        name: map['name'],
        rollNumber: map['rollNumber'],
        numOfPresents: map['numOfPresents'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'attendance': attendance,
      'lastName': lastName,
      'name': name,
      'currentAddress': currentAddress,
      'dateTime': dateTime,
      'enrollNumber': enrollNumber,
      'rollNumber': rollNumber,
      'numOfPresents': numOfPresents
    };
  }

  void markPresent(int increament) {
    increament++;
    numOfPresents = increament;
  }
}
