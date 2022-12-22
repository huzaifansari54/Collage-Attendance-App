import 'dart:ffi';
import 'dart:math';

import 'package:attendence_mangement_system/Services/AuthServices/Exception/Exception_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthServices {
  const AuthServices(this._auth);
  final FirebaseAuth _auth;

  Stream<User?> get user => _auth.idTokenChanges();

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (erorr) {
      throw AuthException(authException: erorr);
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (erorr) {
      throw AuthException(authException: erorr);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
