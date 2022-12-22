import 'package:attendence_mangement_system/Providers/AuthProvider/AuthProviders.dart';
import 'package:attendence_mangement_system/Services/AuthServices/AuthController/LoginState.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginIntialState());
  Ref ref;

  void login(String email, String password) async {
    state = const LoginLoadingState();
    try {
      await ref
          .watch(authServiceProvider)
          .signInWithEmailAndPassword(email, password);
      state = const LoginSucessState();
    } catch (e) {
      state = LoginErorrState(e.toString());
    }
  }

  void signOut() async {
    await ref.watch(authServiceProvider).signOut();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
