import 'package:flutter/material.dart';
import 'package:guess_and_check/pages/check.dart';
import 'package:guess_and_check/pages/guess.dart';
import 'package:guess_and_check/pages/home.dart';

void main() {
  runApp(MaterialApp(
    // ignore: always_specify_types
    routes: {
      '/': (BuildContext context) => const HomePage(),
      '/guess': (BuildContext context) => const GuessMyNumber(),
      '/check': (BuildContext context) => const CheckMyNumber(),
    },
  ));
}
