import 'package:attendence_mangement_system/Data/Models/AttendanceModel.dart';
import 'package:attendence_mangement_system/Data/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireBaseStoreRepository {
  const FireBaseStoreRepository(this._firestore, this._storage);
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FirebaseStorage get storage => _storage;
  Future<void> uploadUserInformation(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toMap())
        .then((value) => getuser(user.uid));
  }

  Future<UserModel> getuser(String uid) async {
    final result = await _firestore.collection('users').doc(uid).get();
    UserModel user = UserModel.fromJson(result.data() as Map<String, dynamic>);
    return user;
  }

  Future<List<AttendanceModel>> getAttendanced(AttendanceModel model) async {
    final results = await _firestore
        .collection('attendance')
        .doc(model.rollNumber)
        .collection('${model.name} ${model.lastName}')
        .get();
    if (results.docs.isEmpty) return [];

    final value =
        results.docs.map((e) => AttendanceModel.fromJson(e.data())).toList();

    return value;
  }

  Future<void> uploadAttendanceInfo(AttendanceModel model) async {
    await _firestore
        .collection('attendance')
        .doc(model.rollNumber)
        .collection('${model.name} ${model.lastName}')
        .doc(model.dateTime)
        .set(model.toJson());
  }
}

final firbaseStoreProvider = Provider((_) => FireBaseStoreRepository(
    FirebaseFirestore.instance, FirebaseStorage.instance));
