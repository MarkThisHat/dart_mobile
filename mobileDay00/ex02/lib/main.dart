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
    const Color backgroundGray = Color.fromARGB(255, 55, 71, 79);
    const Color customGray = Color.fromARGB(255, 96, 125, 139);
    const Color customDarkGray = Color.fromARGB(255, 44, 58, 65);
    const Color customRed = Color.fromARGB(255, 155, 59, 63);

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
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: isLandscape ? minDimension * 0.33 : minDimension * 0.90,
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
                        '2',
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
            Expanded(
              child: GridView.count(
                crossAxisCount: 5,
                children: List.generate(20, (index) {
                  return OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: customDarkGray,
                      backgroundColor: customGray,
                      side: const BorderSide(color: Colors.white, width: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: minDimension * 0.05),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
