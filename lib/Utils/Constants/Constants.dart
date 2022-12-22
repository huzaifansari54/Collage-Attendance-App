import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Const {
  static showSnacBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  static final listOfMonths = List.generate(30, (index) => index + 1);
}
