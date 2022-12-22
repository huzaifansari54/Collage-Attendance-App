import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  final FirebaseAuthException authException;
  final String message;
  AuthException({this.message = 'Erorr', required this.authException});

  @override
  String toString() {
    return authException.message.toString();
  }
}
