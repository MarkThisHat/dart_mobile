import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

double min(double a, double b) {
  if (a < b) {
    return (a);
  } else {
    return (b);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  int _clickCount = 0;

  void _btnPressed() {
    setState(() {
      -_clickCount++;
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
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: isLandscape
                              ? minDimension * 0.07
                              : minDimension * 0.10,
                          color: customGray,
                        ),
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: isLandscape
                              ? minDimension * 0.07
                              : minDimension * 0.10,
                          color: customGray,
                        ),
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
                buttonRow(['7', '8', '9', 'C', 'AC'], buttonHeight),
                buttonRow(['4', '5', '6', '+', '-'], buttonHeight),
                buttonRow(['1', '2', '3', '*', '/'], buttonHeight),
                buttonRow(['0', '.', '00', '='], buttonHeight, isLastRow: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buttonRow(List<String> values, double buttonHeight,
    {bool isLastRow = false}) {
  const Color customDarkGray = Color.fromARGB(255, 44, 58, 65);
  const Color customGray = Color.fromARGB(255, 96, 125, 139);
  const Color customRed = Color.fromARGB(255, 155, 59, 63);

  return Row(
    children: values.asMap().entries.map((entry) {
      int index = entry.key;
      String value = entry.value;
      Color buttonColor;

      if (int.tryParse(value) != null || value == '.') {
        buttonColor = customDarkGray;
      } else if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
        buttonColor = customRed;
      } else {
        buttonColor = Colors.white;
      }

      return Expanded(
        flex: isLastRow && index == values.length - 1 ? 2 : 1,
        child: Padding(
          padding: const EdgeInsets.all(0.07),
          child: GestureDetector(
            onTap: () {
              print('button pressed: $value');
            },
            child: Container(
              height: buttonHeight,
              color: customGray,
              alignment: Alignment.center,
              child: Text(
                value,
                style: TextStyle(color: buttonColor, fontSize: 24.0),
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );
}
