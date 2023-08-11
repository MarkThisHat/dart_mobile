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
        child: PrimaryText(
          text: '${display[3]} ',
          fontSize: 56,
          color: scheme.onPrimary.withAlpha(220),
          shadow: scheme.primary,
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
                _getWeatherIcon(display[4]),
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleTemperatureGraph(data: display),
            )),
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
          _getWeatherIcon(display[1]),
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
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: WeeklyGraph(data: parseWeeklyData(display)),
          )),
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
          _getWeatherIcon(display[1]),
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
        child: Center(
          child: isLandscape
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    PrimaryText(
                      text: '${display[0]} ',
                      fontSize: 24,
                      color: scheme.onBackground,
                      shadow: scheme.primary.withAlpha(100),
                    ),
                    PrimaryText(
                      text: '${display[1]}, ${display[2]}',
                      fontSize: 22,
                      color: scheme.onPrimaryContainer.withOpacity(0.83),
                      shadow: scheme.primary.withAlpha(100),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    PrimaryText(
                      text: '${display[0]} ',
                      fontSize: 24,
                      color: scheme.onBackground,
                      shadow: scheme.primary.withAlpha(100),
                    ),
                    PrimaryText(
                      text: '${display[1]}, ${display[2]}',
                      fontSize: 22,
                      color: scheme.onPrimaryContainer.withOpacity(0.83),
                      shadow: scheme.primary.withAlpha(100),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class PrimaryText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Color shadow;

  PrimaryText(
      {required this.text,
      required this.fontSize,
      required this.color,
      required this.shadow});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 4.0,
              color: shadow,
              offset: Offset(2.0, 2.0),
            ),
          ],
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

    double minX = 0;
    double maxX = temperatures.length - 1.0;
    double minY =
        temperatures.map((e) => e.temperature).reduce((a, b) => a < b ? a : b);
    double maxY =
        temperatures.map((e) => e.temperature).reduce((a, b) => a > b ? a : b);

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: 5,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < temperatures.length) {
                  return Text(temperatures[value.toInt()].hour.toString());
                }
                return Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              interval: (maxY - minY) / 5,
              getTitlesWidget: (value, meta) {
                if (value < minY || value > maxY) {
                  return Text('');
                }
                return Text('${value.toStringAsFixed(1)}°C');
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xff37434d),
              width: 1,
            ),
            left: BorderSide(
              color: const Color(0xff37434d),
              width: 1,
            ),
          ),
        ),
        minX: minX - 1,
        maxX: maxX + 1,
        minY: minY - 1,
        maxY: maxY + 1,
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
    double minX = 0;
    double maxX = data.length - 1.0;
    double minY = min(
        data.map((e) => e.minTemp).reduce((a, b) => a < b ? a : b),
        data.map((e) => e.maxTemp).reduce((a, b) => a < b ? a : b));
    double maxY = max(
        data.map((e) => e.minTemp).reduce((a, b) => a > b ? a : b),
        data.map((e) => e.maxTemp).reduce((a, b) => a > b ? a : b));

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < data.length) {
                  return Text(data[value.toInt()].date);
                }
                return Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              interval: (maxY - minY) / 4,
              getTitlesWidget: (value, meta) {
                if (value < minY - 0.5 || value > maxY + 2) {
                  return Text('');
                }
                return Text('${value.toStringAsFixed(1)}°C');
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xff37434d),
              width: 1,
            ),
            left: BorderSide(
              color: const Color(0xff37434d),
              width: 1,
            ),
          ),
        ),
        minX: minX,
        maxX: maxX,
        minY: minY - 1,
        maxY: maxY + 3,
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
            dotData: FlDotData(show: true),
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
            dotData: FlDotData(show: true),
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

class WeatherInfo {
  final IconData iconData;
  final Color color;

  WeatherInfo(this.iconData, this.color);
}

WeatherInfo _getWeatherInfo(String weatherDescription) {
  Map<String, WeatherInfo> weatherData = {
    'Clear sky': WeatherInfo(Icons.wb_sunny_rounded, Colors.yellow),
    'Mainly clear': WeatherInfo(Icons.wb_sunny_outlined, Colors.yellow),
    'Partly cloudy': WeatherInfo(Icons.wb_cloudy_outlined, Colors.yellow),
    'Overcast': WeatherInfo(Icons.wb_cloudy_sharp, Colors.yellow),
    'Fog': WeatherInfo(Icons.foggy, Colors.yellow),
    'Depositing rime fog': WeatherInfo(Icons.foggy, Colors.yellow),
    'Drizzle: Light': WeatherInfo(Icons.water_damage_outlined, Colors.yellow),
    'Drizzle: Moderate': WeatherInfo(Icons.water_damage_rounded, Colors.yellow),
    'Drizzle: Dense intensity':
        WeatherInfo(Icons.water_damage_sharp, Colors.yellow),
    'Freezing Drizzle: Light': WeatherInfo(Icons.ac_unit, Colors.yellow),
    'Freezing Drizzle: Dense intensity':
        WeatherInfo(Icons.ac_unit_rounded, Colors.yellow),
    'Rain: Slight': WeatherInfo(Icons.water_drop_outlined, Colors.yellow),
    'Rain: Moderate': WeatherInfo(Icons.water_drop_rounded, Colors.yellow),
    'Rain: Heavy intensity': WeatherInfo(Icons.water, Colors.yellow),
    'Freezing Rain: Light':
        WeatherInfo(Icons.waterfall_chart_outlined, Colors.yellow),
    'Freezing Rain: Heavy intensity':
        WeatherInfo(Icons.waterfall_chart, Colors.yellow),
    'Snow fall: Slight': WeatherInfo(Icons.snowing, Colors.yellow),
    'Snow fall: Moderate': WeatherInfo(Icons.snowing, Colors.yellow),
    'Snow fall: Heavy intensity':
        WeatherInfo(Icons.severe_cold_outlined, Colors.yellow),
    'Snow grains': WeatherInfo(Icons.snowing, Colors.yellow),
    'Rain showers: Slight': WeatherInfo(Icons.umbrella_outlined, Colors.yellow),
    'Rain showers: Moderate':
        WeatherInfo(Icons.umbrella_rounded, Colors.yellow),
    'Rain showers: Violent': WeatherInfo(Icons.umbrella_sharp, Colors.yellow),
    'Snow showers slight':
        WeatherInfo(Icons.snowshoeing_outlined, Colors.yellow),
    'Snow showers heavy': WeatherInfo(Icons.snowshoeing_sharp, Colors.yellow),
    'Thunderstorm: Slight or moderate':
        WeatherInfo(Icons.thunderstorm_outlined, Colors.yellow),
    'Thunderstorm with slight hail':
        WeatherInfo(Icons.thunderstorm_rounded, Colors.yellow),
    'Thunderstorm with heavy hail':
        WeatherInfo(Icons.thunderstorm_sharp, Colors.yellow),
  };
  return weatherData[weatherDescription] ??
      WeatherInfo(Icons.question_mark_outlined, Colors.black);
}

Icon _getWeatherIcon(String weatherDescription) {
  WeatherInfo info = _getWeatherInfo(weatherDescription);
  return Icon(info.iconData, color: info.color);
}

double min(double a, double b) {
  if (a < b) {
    return (a);
  } else {
    return (b);
  }
}

double max(double a, double b) {
  if (a > b) {
    return (a);
  } else {
    return (b);
  }
}


/*
'Clear sky'
'Mainly clear'
'Partly cloudy'
'Overcast'
'Fog'
'Depositing rime fog'
'Drizzle: Light'
'Drizzle: Moderate'
'Drizzle: Dense intensity'
'Freezing Drizzle: Light'
'Freezing Drizzle: Dense intensity'
'Rain: Slight'
'Rain: Moderate'
'Rain: Heavy intensity'
'Freezing Rain: Light'
'Freezing Rain: Heavy intensity'
'Snow fall: Slight'
'Snow fall: Moderate'
'Snow fall: Heavy intensity'
'Snow grains'
'Rain showers: Slight'
'Rain showers: Moderate'
'Rain showers: Violent'
'Snow showers slight'
'Snow showers heavy'
'Thunderstorm: Slight or moderate'
'Thunderstorm with slight hail'
'Thunderstorm with heavy hail'
*/