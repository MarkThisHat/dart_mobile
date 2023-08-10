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
                Icon(Icons.wind_power_outlined),
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
          child: Center(child: WeeklyGraph(data: parseWeeklyData(display))),
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

class WeeklyGraph extends StatelessWidget {
  final List<WeeklyData> data;

  WeeklyGraph({required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: const Color(0xff37434d),
            width: 1,
          ),
        ),
        minX: 0,
        maxX: 6,
        minY: 0, // Consider setting based on the data range
        maxY: 50, // Consider setting based on the data range
        lineBarsData: [
          LineChartBarData(
            spots: data
                .asMap()
                .map((index, entry) =>
                    MapEntry(index, FlSpot(index.toDouble(), entry.maxTemp)))
                .values
                .toList(),
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: data
                .asMap()
                .map((index, entry) =>
                    MapEntry(index, FlSpot(index.toDouble(), entry.minTemp)))
                .values
                .toList(),
            isCurved: true,
            color: Colors.green,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

class WeeklyData {
  final String date;
  final double maxTemp;
  final double minTemp;

  WeeklyData(this.date, this.maxTemp, this.minTemp);
}

List<WeeklyData> parseWeeklyData(List<String> data) {
  return data.skip(3).map((entry) {
    final components = entry.split(';');
    final date = components[0];
    final maxTemp = double.tryParse(components[2]) ?? 0;
    final minTemp = double.tryParse(components[3]) ?? 0;
    return WeeklyData(date, maxTemp, minTemp);
  }).toList();
}

IconData _getWeatherIcon(String weatherDescription) {
  const Map<String, IconData> weatherIcons = {
    'Clear sky': Icons.wb_sunny_rounded,
    'Mainly clear': Icons.wb_sunny_outlined,
    'Partly cloudy': Icons.wb_cloudy_outlined,
    'Overcast': Icons.wb_cloudy_sharp,
    'Fog': Icons.foggy,
    'Depositing rime fog': Icons.foggy,
    'Drizzle: Light': Icons.water_damage_outlined,
    'Drizzle: Moderate': Icons.water_damage_rounded,
    'Drizzle: Dense intensity': Icons.water_damage_sharp,
    'Freezing Drizzle: Light': Icons.ac_unit,
    'Freezing Drizzle: Dense intensity': Icons.ac_unit_rounded,
    'Rain: Slight': Icons.water_drop_outlined,
    'Rain: Moderate': Icons.water_drop_rounded,
    'Rain: Heavy intensity': Icons.water,
    'Freezing Rain: Light': Icons.waterfall_chart_outlined,
    'Freezing Rain: Heavy intensity': Icons.waterfall_chart,
    'Snow fall: Slight': Icons.snowing,
    'Snow fall: Moderate': Icons.snowing,
    'Snow fall: Heavy intensity': Icons.severe_cold_outlined,
    'Snow grains': Icons.snowing,
    'Rain showers: Slight': Icons.umbrella_outlined,
    'Rain showers: Moderate': Icons.umbrella_rounded,
    'Rain showers: Violent': Icons.umbrella_sharp,
    'Snow showers slight': Icons.snowshoeing_outlined,
    'Snow showers heavy': Icons.snowshoeing_sharp,
    'Thunderstorm: Slight or moderate': Icons.thunderstorm_outlined,
    'Thunderstorm with slight hail': Icons.thunderstorm_rounded,
    'Thunderstorm with heavy hail': Icons.thunderstorm_sharp,
  };
  return weatherIcons[weatherDescription] ?? Icons.question_mark_outlined;
}
