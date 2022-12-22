import 'dart:io';
import 'package:attendence_mangement_system/Data/Models/AttendanceModel.dart';
import 'package:attendence_mangement_system/Data/Models/User.dart';
import 'package:attendence_mangement_system/Providers/AuthProvider/AuthProviders.dart';
import 'package:attendence_mangement_system/Providers/DataProviders/DataProviders.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataBaseRepository.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/DataSate.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataUploadController extends StateNotifier<DataState> {
  DataUploadController(this.ref) : super(const DataIntialState());
  Ref ref;

  void upload(
      File img, UserModel newUser, String email, String password) async {
    state = const DataUploading();
    ref.watch(authServiceProvider).user.listen((user) async {
      try {
        if (user != null) {
          final uploadTask = await ref
              .watch(firbaseStoreProvider)
              .storage
              .ref("image")
              .child(user.uid.toString())
              .putFile(img);
          final url = await uploadTask.ref.getDownloadURL();
          newUser.setImageAndUid(url, user.uid);
          await ref.read(firbaseStoreProvider).uploadUserInformation(newUser);
          state = const DataUplpaded();
        } else {
          ref.watch(signUpnControllerProvider.notifier).signUp(email, password);
        }
      } on FirebaseException catch (e) {
        state = DataErorr(e.toString());
      }
    });
  }

  void uploadAttendance(AttendanceModel model) async {
    state = const DataUploading();
    try {
      int count = await ref
          .watch(getDataControllerProvider.notifier)
          .getAttendence(model);

      model.markPresent(count);

      await ref.watch(firbaseStoreProvider).uploadAttendanceInfo(model);
      state = const DataUplpaded();
    } on FirebaseException catch (e) {
      state = DataErorr(e.toString());
    }
  }
}
