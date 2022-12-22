import 'package:attendence_mangement_system/Services/AuthServices/AuthController/SignUpController.dart';
import 'package:attendence_mangement_system/Services/AuthServices/AuthController/SignUpState.dart';
import 'package:attendence_mangement_system/Services/AuthServices/Auth_Services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    Provider<AuthServices>((_) => AuthServices(FirebaseAuth.instance));

final authUser = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).user;
});
final signUpnControllerProvider =
    StateNotifierProvider<SignUpController, SignUpState>((ref) {
  return SignUpController(ref);
});
