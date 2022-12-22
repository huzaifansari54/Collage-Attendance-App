import 'package:attendence_mangement_system/Data/Models/AttendanceModel.dart';
import 'package:attendence_mangement_system/Data/Models/User.dart';
import 'package:equatable/equatable.dart';

class GetDataState extends Equatable {
  const GetDataState();

  @override
  List<Object?> get props => [];
}

class GetDataIntialState extends GetDataState {
  const GetDataIntialState();

  @override
  List<Object?> get props => [];
}

class DataDownloading extends GetDataState {
  const DataDownloading();

  @override
  List<Object?> get props => [];
}

class DataDownloaded extends GetDataState {
  const DataDownloaded(this.userModel);
  final UserModel userModel;
  @override
  List<Object?> get props => [userModel];
}

class AttendanceLoaded extends GetDataState {
  final AttendanceModel attendanceModel;
  const AttendanceLoaded(this.attendanceModel);
  @override
  List<Object?> get props => [attendanceModel];
}

class Erorrs extends GetDataState {
  const Erorrs(this.erorr);
  final String erorr;

  @override
  List<Object?> get props => [erorr];
}
