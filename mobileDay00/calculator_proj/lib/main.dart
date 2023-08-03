import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'buttons.dart';
import 'text.dart';

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
  String text2 = '';

  void updateText(String value) {
    setState(() {
      if (value == 'AC') {
        text1 = '0';
        text2 = '';
      } else if (value == 'C') {
        if (text1 != '0') {
          text1 = text1.substring(0, text1.length - 1);
          if (text1.isEmpty) {
            text1 = '0';
          }
        }
      } else if (value == '=') {
        text2 = processOutput(text1);
      } else {
        text1 = processInput(text1, value);
      }
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

double min(double a, double b) {
  if (a < b) {
    return (a);
  } else {
    return (b);
  }
}

String lastCharacter(String text) {
  return (text.split('').last);
}

bool isCharacterOperator(String text) {
  String lastChar = lastCharacter(text);
  List<String> operators = ['+', '-', '*', '/'];

  return (operators.contains(lastChar));
}

bool containsDecimalInLastNumber(String text) {
  List<String> splitText = text.split(RegExp(r'[-+*/]'));

  return (splitText.last.contains('.'));
}

String processInput(String text, String value) {
  if (text.length > 15) return (text);

  if (int.tryParse(value) != null) {
    if (text == '0') {
      return (value);
    } else {
      return (text += value);
    }
  }
  if (value == '.') {
    if (lastCharacter(text) != '.' &&
        !containsDecimalInLastNumber(text) &&
        (int.tryParse(lastCharacter(text)) != null)) {
      return (text += value);
    }
  }
  if (isCharacterOperator(value)) {
    if (!isCharacterOperator(lastCharacter(text)) &&
        lastCharacter(text) != '.') {
      return (text += value);
    } else if (value == '-' &&
        lastCharacter(text) != '-' &&
        lastCharacter(text) != '.') {
      return (text += value);
    }
  }
  return (text);
}

String processOutput(text) {
  if (int.tryParse(lastCharacter(text)) == null) {
    return ("Uncomplete expression");
  }

  Parser p = Parser();
  Expression exp = p.parse(text);

  ContextModel cm = ContextModel();
  try {
    double result = exp.evaluate(EvaluationType.REAL, cm);

    if (result.isInfinite) {
      return ("Can't divide by zero");
    }

    String output = result.truncateToDouble() == result
        ? result.truncate().toString()
        : result.toString();

    return (output);
  } catch (e) {
    if (e is Exception) {
      return ("Error: Invalid expression");
    } else {
      return ("Error: ${e.toString()}");
    }
  }
}
