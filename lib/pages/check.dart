import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckMyNumber extends StatefulWidget {
  const CheckMyNumber({Key? key}) : super(key: key);

  @override
  _CheckMyNumberState createState() => _CheckMyNumberState();
}

class _CheckMyNumberState extends State<CheckMyNumber> {
  final TextEditingController _controller = TextEditingController();

  late String _text;
  bool _numarComun = false;
  final String _numarComunText =
      "Numarul nu e nici patrat perfect, nici cub perfect.";
  int _numar = 0;
  late String _mesajFinal;
  bool _patratPerfect = false;
  bool cubPerfect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check my number"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Introduceti un numar intreg de la tastatura si verificati daca acesta este:\n"
                "• patrat perfect\n"
                "• cub perfect\n"
                "• amandoua\n",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
            (_numarComun)
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      _numarComunText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  )
                : Text(""),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                onChanged: (value) {
                  _numarComun = false;
                  if (value.isNotEmpty) {
                    _numar = int.tryParse(value)!;
                  }
                },
                maxLength: 9,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Introduceti un numar intreg",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                      });
                    },
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _patratPerfect = false;
                  cubPerfect = false;
                  if (isPerfectSquare(_numar)) {
                    _patratPerfect = true;
                    _mesajFinal = "Numarul $_numar este patrat perfect.";
                  }
                  if (isPerfectCube(_numar)) {
                    cubPerfect = true;
                    _mesajFinal = "Numarul $_numar este cub perfect";
                  }

                  if (_patratPerfect && cubPerfect) {
                    _mesajFinal =
                    "Numarul $_numar este atat patrat perfect cat si cub perfect.";
                  }

                  if (_patratPerfect || cubPerfect) {
                    _text = "Numarul $_numar";
                    showDialogCustom();
                  } else {
                    _numarComun = true;
                  }
                });
              },
              child: Text("Verifica"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey[300]!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showDialogCustom() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(_text),
        content: Text(_mesajFinal),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
                _controller.clear();
              });
            },
            child: Text("Joaca inca o data"),
          )
        ],
      ),
      barrierColor: Colors.blue,
    );
  }

  bool isPerfectSquare(int number) {
    if (number < 0) {
      return false;
    }

    int lastHexDigit = number & 0xF;
    if (lastHexDigit > 9) {
      return false; // return immediately in 6 cases out of 16.
    }

    if (lastHexDigit == 0 ||
        lastHexDigit == 1 ||
        lastHexDigit == 4 ||
        lastHexDigit == 9) {
      int t = (sqrt(number) + 0.5).floor();
      return (t * t) == number;
    }

    return false;
  }

  bool isPerfectCube(int number) {
    for (int i = 0; i <= pow(number, 1 / 3).roundToDouble() + 1; i++) {
      int cube = i * i * i;

      if (cube == number) {
        return true;
      }
    }

    return false;
  }
}
