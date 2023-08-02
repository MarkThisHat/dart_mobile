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
              height: minDimension * 0.3,
              color: backgroundGray,
              child: Center(
                child: Text(
                  '0',
                  style: TextStyle(
                    fontSize: minDimension * 0.1,
                    color: customGray,
                  ),
                ),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.count(
                  crossAxisCount: 5,
                  children: List.generate(20, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: customDarkGray, 
                          backgroundColor: customGray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(fontSize: minDimension * 0.05),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}