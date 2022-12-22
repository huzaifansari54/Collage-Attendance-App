import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/DataUploadControllor.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/DataSate.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataController.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataControllerProvider =
    StateNotifierProvider<DataUploadController, DataState>((ref) {
  return DataUploadController(ref);
});

final getDataControllerProvider =
    StateNotifierProvider<GetDataController, GetDataState>((ref) {
  return GetDataController(ref);
});
