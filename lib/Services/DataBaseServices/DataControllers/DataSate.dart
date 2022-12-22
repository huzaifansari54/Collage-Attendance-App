import 'package:equatable/equatable.dart';

class DataState extends Equatable {
  const DataState();

  @override
  List<Object?> get props => [];
}

class DataIntialState extends DataState {
  const DataIntialState();

  @override
  List<Object?> get props => [];
}

class DataUploading extends DataState {
  const DataUploading();

  @override
  List<Object?> get props => [];
}

class DataUplpaded extends DataState {
  const DataUplpaded();

  @override
  List<Object?> get props => [];
}

class DataErorr extends DataState {
  const DataErorr(this.erorr);
  final String erorr;

  @override
  List<Object?> get props => [erorr];
}
