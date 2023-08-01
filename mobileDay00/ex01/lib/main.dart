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
      home: const MyHomePage(title: 'Hello World'),
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
    const Color customGreen = Color.fromARGB(255, 98, 98, 0);

    return Scaffold(
/*      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: customGreen,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  _clickCount == 0
                      ? 'A simple text'
                      : (_clickCount == 1
                          ? 'Hello World!'
                          : (_clickCount % 2 == 0
                              ? 'A simple text'
                              : 'hello world!')),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: minDimension * 0.08,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: minDimension * 0.25,
              child: AspectRatio(
                aspectRatio: 3 / 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    foregroundColor: customGreen,
                    padding: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(240),
                    ),
                    elevation: 5,
                  ),
                  onPressed: _btnPressed,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Click me',
                      style: TextStyle(fontSize: minDimension * 0.05),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
