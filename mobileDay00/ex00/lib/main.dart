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
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
                  color:
                      const Color.fromARGB(255, 98, 98, 0), // Background color
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: const Text(
                  'A simple text',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 24, // Text size
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100], // background color
                foregroundColor:
                    const Color.fromARGB(255, 98, 98, 0), // text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // border radius
                  //        side: BorderSide(color: Colors.grey[600]!), // border color
                ),
                elevation: 5, // shading
              ),
              onPressed: _printBtnPressed,
              child: const Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }
}
