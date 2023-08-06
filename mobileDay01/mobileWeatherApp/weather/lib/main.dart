import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day 01 exercises',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Weather'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final searchController = TextEditingController();
  String displayText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: widget.title,
        updateText: updateText,
        searchController: searchController,
      ),
      body: BodyTabBarView(
        tabController: _controller,
        displayText: displayText,
      ),
      bottomNavigationBar: FootBar(controller: _controller),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  void updateText(String newValue) {
    setState(() {
      displayText = newValue;
    });
  }
}
