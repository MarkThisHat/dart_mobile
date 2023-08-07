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
      title: 'Day 02 exercises',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
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
  List<Map<String, dynamic>> searchResults = [];
  String? displayText = '';
  DisplayTextState displayState = DisplayTextState.valid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: widget.title,
        updateText: updateText,
        searchController: searchController,
        onLocationSelected: handleLocationSelection,
        onSearchResults: (results) {
          setState(() {
            searchResults = results;
          });
        },
      ),
      body: Stack(
        children: [
          BodyTabBarView(
            tabController: _controller,
            displayText: displayText,
            displayTextState: displayState,
          ),
          if (searchResults.isNotEmpty)
            Positioned(
              top: 0, // adjust
              left: 144,
              right: 60,
              child: ListViewOverlay(
                searchResults: searchResults,
                currentSearchTerm: searchController.text,
                onItemTap: handleLocationSelection,
              ),
            ),
        ],
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

  void updateText(String? newValue, DisplayTextState newState) {
    setState(() {
      displayText = newValue;
      displayState = newState;
    });
  }

  void handleLocationSelection(Map<String, dynamic>? location) {
    if (location != null &&
        location.containsKey('latitude') &&
        location.containsKey('longitude')) {
      String latLong = "${location['latitude']} , ${location['longitude']}";
      updateText(latLong, DisplayTextState.valid);
    } else {
      updateText('No search result', DisplayTextState.submissionError);
    }
    setState(() {
      searchResults = [];
    });
  }
}
