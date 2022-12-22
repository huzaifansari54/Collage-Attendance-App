import 'package:attendence_mangement_system/Data/Models/AttendanceModel.dart';
import 'package:attendence_mangement_system/Data/Models/User.dart';
import 'package:attendence_mangement_system/Providers/AuthProvider/AuthProviders.dart';
import 'package:attendence_mangement_system/Providers/DataProviders/DataProviders.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataBaseRepository.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetDataController extends StateNotifier<GetDataState> {
  GetDataController(this.ref) : super(const GetDataIntialState());
  Ref ref;
  Future<UserModel> getStudent() async {
    final user = await ref.watch(authServiceProvider).user.first;
    try {
      return await ref
          .watch(firbaseStoreProvider)
          .getuser(user!.uid)
          .then((value) {
        state = DataDownloaded(value);
        return value;
      });
    } catch (e) {
      state = Erorrs(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<int> getAttendence(AttendanceModel model) async {
    const GetDataIntialState();
    try {
      final attendance =
          await ref.watch(firbaseStoreProvider).getAttendanced(model);
      if (attendance.isEmpty) return 0;
      state = AttendanceLoaded(attendance.last);
      return attendance.last.numOfPresents;
    } catch (e) {
      state = Erorrs(e.toString());
      return Future.error('Error');
    }
  }

  Future<List<AttendanceModel>> getFullAttendences(
      AttendanceModel model) async {
    const GetDataIntialState();
    try {
      final attendance =
          await ref.watch(firbaseStoreProvider).getAttendanced(model);

      state = AttendanceLoaded(attendance.last);
      return attendance;
    } catch (e) {
      state = Erorrs(e.toString());
      return Future.error('Error');
    }
  }
}

final userprofileProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(getDataControllerProvider.notifier).getStudent();
});
final attendnceFutureProvider =
    FutureProvider.family((ref, AttendanceModel model) {
  return ref.watch(getDataControllerProvider.notifier).getAttendence(model);
});
final fullAttendnceFutureProvider =
    FutureProvider.family((ref, AttendanceModel model) {
  return ref
      .watch(getDataControllerProvider.notifier)
      .getFullAttendences(model);
});
