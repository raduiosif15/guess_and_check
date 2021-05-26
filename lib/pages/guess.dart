import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessMyNumber extends StatefulWidget {
  const GuessMyNumber({Key? key}) : super(key: key);

  @override
  _GuessMyNumberState createState() => _GuessMyNumberState();
}

class _GuessMyNumberState extends State<GuessMyNumber> {
  final TextEditingController _controller = TextEditingController();

  int _numarulDeGhicit = Random().nextInt(100) + 1;
  int _input = 0;

  bool _hint = false;
  String _hintText = 'Alege un numar prima data!';
  bool _status = false; // false - joc in desfasurare, true - joc terminat
  String _statusText = 'Pierdut';
  Color _color = Colors.red;
  int _numarulDeIncercari = 3;
  int _numarulDeHinturi = 5;

  bool _maiIncearca = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
        centerTitle: true,
      ),
      body: Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Ma gandesc la un numar intre 1 si 100',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // textAlign: TextAlign.center,
                    fontSize: 40,
                  ),
                ),
              ),
              if (_hint)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    _hintText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                )
              else
                const Text(''),
              if (_status)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    _statusText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: _color,
                    ),
                  ),
                )
              else
                const Text(''),
              if (_maiIncearca)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Mai ai $_numarulDeIncercari incercari',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              else
                const Text(''),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 150.0, vertical: 30.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  // ignore: always_specify_types
                  inputFormatters: <FilteringTextInputFormatter> [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _input = int.tryParse(value)!;
                    }
                  },
                  maxLength: 3,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (_status == false) {
                          if (_numarulDeHinturi > 0) {
                            _numarulDeHinturi--;
                            _hint = true;
                            if (_input != 0) {
                              if (_input < _numarulDeGhicit) {
                                _hintText = 'Numarul este mai mare';
                              } else if (_input > _numarulDeGhicit) {
                                _hintText = 'Numarul este mai mic';
                              } else {
                                _hintText = 'Nu se stie :)';
                              }
                            }
                          } else {
                            _hint = true;
                            _hintText = 'Nu mai aveti hinturi...';
                          }
                        }
                      });
                    },
                    child: Text('Hint $_numarulDeHinturi'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey[300]!),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (_status == false) {
                          if (_numarulDeIncercari > 0) {
                            if (_input > 0) {
                              _numarulDeIncercari--;
                            }
                            _status = false;
                            if (_numarulDeGhicit == _input) {
                              _status = true;
                              _statusText = 'Ai ghicit';
                              _color = Colors.green;
                              _maiIncearca = false;
                              showDialogCustom();
                            } else {
                              if (_numarulDeIncercari == 0) {
                                _status = true;
                                _statusText = 'Ai pierdut';
                                _color = Colors.red;
                                _maiIncearca = false;
                                showDialogCustom();
                              }
                              _maiIncearca = true;
                            }
                          }
                        }
                      });
                    },
                    child: const Text('Guess'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey[300]!),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        initializareVariabile();
                      });
                    },
                    child: const Text('Restart'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey[300]!),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializareVariabile() {
    _numarulDeGhicit = Random().nextInt(100) + 1;
    print(_numarulDeGhicit);
    _input = 0;

    _hint = false;
    _hintText = 'Alege un numar prima data!';
    _status = false;
    _statusText = '';
    _color = Colors.red;
    _numarulDeIncercari = 4;
    _numarulDeHinturi = 4;

    _maiIncearca = false;

    _controller.clear();
  }

  Future<void> showDialogCustom() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_statusText),
          content: Text('Numarul a fost $_numarulDeGhicit.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  initializareVariabile();
                });
              },
              child: const Text('Joaca inca o data'),
            )
          ],
        );
      },
      barrierColor: Colors.blue,
    );
  }
}
