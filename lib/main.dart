import 'package:flutter/material.dart';
import 'package:guess_and_check/pages/check.dart';
import 'package:guess_and_check/pages/guess.dart';
import 'package:guess_and_check/pages/home.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => HomePage(),
      '/guess': (context) => GuessMyNumber(),
      '/check': (context) => CheckMyNumber(),
    },
  ));
}
