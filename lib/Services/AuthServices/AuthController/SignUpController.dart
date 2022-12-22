import 'package:attendence_mangement_system/Providers/AuthProvider/AuthProviders.dart';
import 'package:attendence_mangement_system/Services/AuthServices/AuthController/SignUpState.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController(this.ref) : super(const SignUpIntialState());
  Ref ref;

  void signUp(String email, String password) async {
    state = const SignUpLoadingState();
    try {
      await ref
          .watch(authServiceProvider)
          .createUserWithEmailAndPassword(email, password);
      state = const SignUpSucessState();
    } catch (e) {
      state = SignUpErorrState(e.toString());
    }
  }

  void signOut() async {
    await ref.watch(authServiceProvider).signOut();
  }
}
