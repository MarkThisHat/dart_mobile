import 'package:flutter/material.dart';

Widget decoratedTabs(String showText, String tabName, ColorScheme scheme) {
  print('Tabname $tabName contains:');
  print('\n');
  print(showText);
  if (tabName == 'Weekly') {
    return _weekly(showText, scheme);
  } else if (tabName == 'Today') {
    return _today(showText, scheme);
  } else {
    return _currently(showText, scheme);
  }
}

Widget _currently(String showText, ColorScheme scheme) {
  return Column(
    children: [
      Expanded(
        flex: 2,
        child: Container(
          color: Colors.red.withOpacity(0.3),
          child: Center(child: Text('Box 1')),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          color: Colors.blue.withOpacity(0.3),
          child: Center(child: Text('Box 2')),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          color: Colors.yellow.withOpacity(0.3),
          child: Center(child: Text('Box 2')),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          color: Colors.purple.withOpacity(0.3),
          child: Center(child: Text('Box 2')),
        ),
      ),
    ],
  );
}

Widget _today(String showText, ColorScheme scheme) {
  return Column(
    children: [
      Expanded(
        flex: 2,
        child: Container(
          color: Colors.red.withOpacity(0.3),
          child: Center(child: Text('Box 1')),
        ),
      ),
      Expanded(
        flex: 6,
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
            children: List.generate(24, (index) => _buildBox(index)),
          ),
        ),
      )
    ],
  );
}

Widget _weekly(String showText, ColorScheme scheme) {
  return Column(
    children: [
      Expanded(
        flex: 2,
        child: Container(
          color: Colors.red.withOpacity(0.3),
          child: Center(child: Text('Box 1')),
        ),
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
            children: List.generate(7, (index) => _buildBox(index)),
          ),
        ),
      )
    ],
  );
}

Widget _buildBox(int index) {
  return Container(
    width: 150,
    color: Colors.green.withOpacity(0.3),
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    child: Center(child: Text('Box 3 - ${index + 1}')),
  );
}
/*
IconData _getWeatherIcon(String weatherDescription) {
  const Map<String, IconData> weatherIcons = {
    'Clear sky' : Icons.,
    'Mainly clear' : Icons.,
    'Partly cloudy' : Icons.,
    'Overcast' : Icons.,
    'Fog' : Icons.,
    'Depositing rime fog' : Icons.,
    'Drizzle: Light' : Icons.,
    'Drizzle: Moderate' : Icons.,
    'Drizzle: Dense intensity' : Icons.,
    'Freezing Drizzle: Light' : Icons.,
    'Freezing Drizzle: Dense intensity' : Icons.,
    'Rain: Slight' : Icons.,
    'Rain: Moderate' : Icons.,
    'Rain: Heavy intensity' : Icons.,
    'Freezing Rain: Light' : Icons.,
    'Freezing Rain: Heavy intensity' : Icons.,
    'Snow fall: Slight' : Icons.,
    'Snow fall: Moderate' : Icons.,
    'Snow fall: Heavy intensity' : Icons.,
    'Snow grains' : Icons.,
    'Rain showers: Slight' : Icons.,
    'Rain showers: Moderate' : Icons.,
    'Rain showers: Violent' : Icons.,
    'Snow showers slight' : Icons.,
    'Snow showers heavy' : Icons.,
    'Thunderstorm: Slight or moderate' : Icons.,
    'Thunderstorm with slight hail' : Icons.,
    'Thunderstorm with heavy hail' : Icons.,
  };
  return weatherIcons[weatherDescription] ?? Icons.error_outline;
}
*/