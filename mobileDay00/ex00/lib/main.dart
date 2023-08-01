import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Day 00 exercises'),
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
  void _printBtnPressed() {
    setState(() {
      print('Button Pressed');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
              padding:
                  const EdgeInsets.only(bottom: 4.0), // Padding at the bottom
              child: Container(
                padding: const EdgeInsets.all(8.0), // Padding for the text
                decoration: BoxDecoration(
                  color: customGreen, // Background color
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: Text(
                  'A simple text',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: screenSize.width * 0.05,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.2,
              child: AspectRatio(
                aspectRatio: 3 / 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100], // background color
                    foregroundColor: customGreen, // text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // border radius
                    ),
                    elevation: 5, // shading
                  ),
                  onPressed: _printBtnPressed,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Click me',
                      style: TextStyle(fontSize: screenSize.width * 0.05),
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
