import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/guess');
                },
                child: const Text('Guess my number'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/check');
                },
                child: const Text('Check my number'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
