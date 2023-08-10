import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

Widget decoratedTabs(String showText, String tabName, BuildContext context) {
  print('Tabname $tabName contains:');
  print('\n');
  print(showText);
  if (tabName == 'Weekly') {
    return _weekly(showText, context);
  } else if (tabName == 'Today') {
    return _today(showText, context);
  } else {
    return _currently(showText, context);
  }
}

Widget _currently(String showText, BuildContext context) {
  List<String> display = showText.split('\n');
  ColorScheme scheme = Theme.of(context).colorScheme;
  bool isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;

  return Column(
    children: [
      PresentBox(
        showText: showText,
        scheme: scheme,
        isLandscape: isLandscape,
      ),
      Expanded(
        flex: 2,
        child: Container(
          color: Colors.blue.withOpacity(0.3),
          child: Center(child: Text(display[3])),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          color: Colors.yellow.withOpacity(0.3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(display[4]),
                Icon(_getWeatherIcon(display[4])),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          color: Colors.purple.withOpacity(0.3),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.wind_power), // Here's your sunny icon
                SizedBox(
                    width:
                        10), // Adds a small space between the icon and the text
                Text('${display[5]}'),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _today(String showText, BuildContext context) {
  List<String> display = showText.split('\n');
  ColorScheme scheme = Theme.of(context).colorScheme;
  bool isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  return Column(
    children: [
      PresentBox(
        showText: showText,
        scheme: scheme,
        isLandscape: isLandscape,
      ),
      Expanded(
        flex: 6,
        child: Container(
            color: Colors.yellow.withOpacity(0.3),
            child: SingleTemperatureGraph(data: display)),
      ),
      Expanded(
        flex: 3,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                List.generate(24, (index) => _buildDayBox(display[index + 3])),
          ),
        ),
      )
    ],
  );
}

Widget _buildDayBox(String boxDisplay) {
  List<String> display = boxDisplay.split(';');
  return Container(
    width: 150,
    color: Colors.green.withOpacity(0.3),
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(display[0]),
          Icon(_getWeatherIcon(display[1])),
          Text('${display[2]} °C'),
          Text(display[3]),
        ],
      ),
    ),
  );
}

Widget _weekly(String showText, BuildContext context) {
  List<String> display = showText.split('\n');
  ColorScheme scheme = Theme.of(context).colorScheme;
  bool isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  return Column(
    children: [
      PresentBox(
        showText: showText,
        scheme: scheme,
        isLandscape: isLandscape,
      ),
      Expanded(
        flex: 5,
        child: Container(
          color: Colors.yellow.withOpacity(0.3),
          child: Center(child: Text('Box 2')),
        ),
      ),
      Expanded(
        flex: 3,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                List.generate(7, (index) => _buildWeekBox(display[index + 3])),
          ),
        ),
      )
    ],
  );
}

Widget _buildWeekBox(String boxDisplay) {
  List<String> display = boxDisplay.split(';');
  return Container(
    width: 150,
    color: Colors.green.withOpacity(0.3),
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(display[0]),
          Icon(_getWeatherIcon(display[1])),
          Text('${display[2]} max'),
          Text('${display[3]} min'),
        ],
      ),
    ),
  );
}

class PresentBox extends StatelessWidget {
  final String showText;
  final ColorScheme scheme;
  final bool isLandscape;

  PresentBox({
    required this.showText,
    required this.scheme,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    List<String> display = showText.split('\n');

    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.red.withOpacity(0.3),
        child: Center(
          child: isLandscape
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('${display[0]} '),
                    Text('${display[1]}, ${display[2]}'),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(display[0]),
                    Text('${display[1]}, ${display[2]}'),
                  ],
                ),
        ),
      ),
    );
  }
}

class SingleTemperatureGraph extends StatelessWidget {
  final List<String> data;

  SingleTemperatureGraph({required this.data});

  @override
  Widget build(BuildContext context) {
    final List<HourlyTemperature> temperatures = parseData(data);

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: 0,
        maxX: 23,
        minY: temperatures
            .map((e) => e.temperature)
            .reduce((a, b) => a < b ? a : b),
        maxY: temperatures
            .map((e) => e.temperature)
            .reduce((a, b) => a > b ? a : b),
        lineBarsData: [
          LineChartBarData(
            spots: temperatures
                .asMap()
                .map((index, entry) => MapEntry(
                    index, FlSpot(index.toDouble(), entry.temperature)))
                .values
                .toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          )
        ],
      ),
    );
  }
}

class HourlyTemperature {
  final String hour;
  final double temperature;

  HourlyTemperature(this.hour, this.temperature);
}

List<HourlyTemperature> parseData(List<String> data) {
  return data.skip(3).map((entry) {
    final components = entry.split(';');
    final hour = components[0];
    final temperature = double.tryParse(components[2]) ?? 0;
    return HourlyTemperature(hour, temperature);
  }).toList();
}

IconData _getWeatherIcon(String weatherDescription) {
  const Map<String, IconData> weatherIcons = {
    'Clear sky': Icons.wb_sunny,
    'Mainly clear': Icons.wb_sunny,
    'Partly cloudy': Icons.wb_sunny,
    'Overcast': Icons.wb_sunny,
    'Fog': Icons.wb_sunny,
    'Depositing rime fog': Icons.wb_sunny,
    'Drizzle: Light': Icons.wb_sunny,
    'Drizzle: Moderate': Icons.wb_sunny,
    'Drizzle: Dense intensity': Icons.wb_sunny,
    'Freezing Drizzle: Light': Icons.wb_sunny,
    'Freezing Drizzle: Dense intensity': Icons.wb_sunny,
    'Rain: Slight': Icons.wb_sunny,
    'Rain: Moderate': Icons.wb_sunny,
    'Rain: Heavy intensity': Icons.wb_sunny,
    'Freezing Rain: Light': Icons.wb_sunny,
    'Freezing Rain: Heavy intensity': Icons.wb_sunny,
    'Snow fall: Slight': Icons.wb_sunny,
    'Snow fall: Moderate': Icons.wb_sunny,
    'Snow fall: Heavy intensity': Icons.wb_sunny,
    'Snow grains': Icons.wb_sunny,
    'Rain showers: Slight': Icons.wb_sunny,
    'Rain showers: Moderate': Icons.wb_sunny,
    'Rain showers: Violent': Icons.wb_sunny,
    'Snow showers slight': Icons.wb_sunny,
    'Snow showers heavy': Icons.wb_sunny,
    'Thunderstorm: Slight or moderate': Icons.wb_sunny,
    'Thunderstorm with slight hail': Icons.wb_sunny,
    'Thunderstorm with heavy hail': Icons.wb_sunny,
  };
  return weatherIcons[weatherDescription] ?? Icons.error_outline;
}
