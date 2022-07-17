// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int leftNumber = 1;
  int rightNumber = 1;

  void roll() {
    setState(() {
      leftNumber = Random().nextInt(5) + 1;
      rightNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Random Images')),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: roll,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image(
                            image: AssetImage('assets/images/a$leftNumber.png'),
                            // height: (leftNumber == 5) ? 200 : 400,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: roll,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image(
                            image:
                                AssetImage('assets/images/a$rightNumber.png'),
                            // height: (leftNumber == 5) ? 200 : 400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(60),
                      child: RaisedButton(
                        onPressed: roll,
                        child: const Text(
                          'Load Random Images',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
