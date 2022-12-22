import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginIntialState extends LoginState {
  const LoginIntialState();

  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();

  @override
  List<Object?> get props => [];
}

class LoginSucessState extends LoginState {
  const LoginSucessState();

  @override
  List<Object?> get props => [];
}

class LoginErorrState extends LoginState {
  const LoginErorrState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
