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
              top: 0,
              left: 48,
              right: 48,
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

  void handleLocationSelection(Map<String, dynamic>? location) async {
    if (location != null &&
        location.containsKey('latitude') &&
        location.containsKey('longitude')) {
      WeatherLocation weatherLocation = convertToWeatherLocation([
        location['latitude'].toString(),
        location['longitude'].toString(),
        location['name'],
        location['country'],
        location['admin1']
      ]);
      await fetchAndUpdateWeather(weatherLocation);
    } else {
      updateText('', DisplayTextState.submissionError);
    }
    setState(() {
      searchResults = [];
    });
  }

  Future<void> fetchAndUpdateWeather(WeatherLocation location) async {
    if (location.dblLat != null && location.dblLon != null) {
      Map<String, dynamic>? weatherData =
          await fetchWeather(location.dblLat!, location.dblLon!);
      if (weatherData == null) {
        updateText('', DisplayTextState.apiError);
      } else {
        displayText = parseWeatherData(location, weatherData);
        updateText(displayText, DisplayTextState.valid);
      }
    }
  }
}
