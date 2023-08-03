import 'package:flutter/material.dart';
import 'buttons.dart';
import 'text.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day 00 exercises',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text1 = '0';
  String text2 = '0';

  void updateText(String value) {
    setState(() {
      text1 = text2;
      text2 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double minDimension = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double buttonHeight = isLandscape ? 38.8 : 101.7;
    const Color backgroundGray = Color.fromARGB(255, 55, 71, 79);
    const Color customGray = Color.fromARGB(255, 96, 125, 139);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customGray,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: minDimension * 0.05,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: backgroundGray,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CalculatorText(
                        value: text1,
                        fontSize: isLandscape
                            ? minDimension * 0.07
                            : minDimension * 0.10,
                        color: customGray,
                      ),
                      CalculatorText(
                        value: text2,
                        fontSize: isLandscape
                            ? minDimension * 0.07
                            : minDimension * 0.10,
                        color: customGray,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                ButtonRow(
                    values: const ['7', '8', '9', 'C', 'AC'],
                    onValueUpdate: updateText,
                    btnHeight: buttonHeight),
                ButtonRow(
                    values: const ['4', '5', '6', '+', '-'],
                    onValueUpdate: updateText,
                    btnHeight: buttonHeight),
                ButtonRow(
                    values: const ['1', '2', '3', '*', '/'],
                    onValueUpdate: updateText,
                    btnHeight: buttonHeight),
                ButtonRow(
                    values: const ['0', '.', '00', '='],
                    btnHeight: buttonHeight,
                    onValueUpdate: updateText,
                    isLastRow: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
