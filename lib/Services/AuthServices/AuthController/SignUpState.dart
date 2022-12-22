import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object?> get props => [];
}

class SignUpIntialState extends SignUpState {
  const SignUpIntialState();

  @override
  List<Object?> get props => [];
}

class SignUpLoadingState extends SignUpState {
  const SignUpLoadingState();

  @override
  List<Object?> get props => [];
}

class SignUpSucessState extends SignUpState {
  const SignUpSucessState();

  @override
  List<Object?> get props => [];
}

class SignUpErorrState extends SignUpState {
  const SignUpErorrState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
