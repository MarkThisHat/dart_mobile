class WeatherLocation {
  final String latitude;
  final String longitude;
  final String? cityName;
  final String? country;
  final String? region;
  double? dblLat;
  double? dblLon;

  WeatherLocation({
    required this.latitude,
    required this.longitude,
    this.cityName,
    this.country,
    this.region,
    this.dblLat,
    this.dblLon,
  });

  @override
  String toString() {
    return 'WeatherLocation(latitude: $latitude, longitude: $longitude, cityName: $cityName, country: $country, region: $region)';
  }
}

WeatherLocation convertToWeatherLocation(List<String?> values) {
  double? doubleLat;
  double? doubleLon;

  try {
    doubleLat = double.parse(values[0]!);
    doubleLon = double.parse(values[1]!);
  } catch (_) {
    doubleLat = null;
    doubleLon = null;
  }
  return WeatherLocation(
      latitude: values[0]!,
      longitude: values[1]!,
      cityName: values.length > 2 ? values[2] : null,
      country: values.length > 3 ? values[3] : null,
      region: values.length > 4 ? values[4] : null,
      dblLat: doubleLat,
      dblLon: doubleLon);
}

String? parseWeatherData(
    WeatherLocation location, Map<String, dynamic> weather) {
  int n = 5;
  List<String> list = List<String>.filled(n, '');

  if (location.cityName != null) {
    list[0] = location.cityName!;
  } else {
    list[0] = 'Your city';
  }

  if (location.region != null) {
    list[1] = location.region!;
  } else {
    list[1] = 'Your region';
  }

  if (location.country != null) {
    list[2] = location.country!;
  } else {
    list[2] = 'Your country';
  }

  list[3] = _getCurrentInfo(weather['current_weather']);

  list[4] = _getTodayInfo(weather['hourly']);

  /*print('Location: $location');
  print('API response: $weather');*/

  print(list.join('\n'));
  return null;
}

String _getCurrentInfo(Map<String, dynamic> current) {
  String currentDesc = _getWeatherDescription(current['weathercode']);

  String temperature =
      current['temperature']?.toString() ?? 'Unknown Temperature';

  String windSpeed = current['windspeed']?.toString() ?? 'Unknown Wind Speed';

  return '$temperature;$currentDesc;$windSpeed';
}

String _getTodayInfo(Map<String, dynamic> today) {
  DateTime currentDate = DateTime.now();
  String currentDay =
      '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';

  List<String> timeStrings =
      (today['time'] as List<dynamic>).map((time) => time.toString()).toList();

  List<String> currentDayTimeStrings = timeStrings
      .where((time) =>
          time.startsWith(currentDay) &&
          DateTime.parse(time).isAfter(currentDate))
      .toList();

  List<String> infoList = [];

  for (int i = 0; i < currentDayTimeStrings.length; i++) {
    DateTime time = DateTime.parse(currentDayTimeStrings[i]);
    String temperature = today['temperature_2m'][i].toString();
    String windspeed = today['windspeed_10m'][i].toString();
    String description = _getWeatherDescription(today['weathercode'][i]);

    infoList.add(
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')},$temperature,$description,$windspeed');
  }

  return infoList.join(';');
}

String _getWeatherDescription(dynamic weatherCodeValue) {
  const Map<int, String> weatherCodes = {
    0: 'Clear sky',
    1: 'Mainly clear',
    2: 'Partly cloudy',
    3: 'Overcast',
    45: 'Fog',
    48: 'Depositing rime fog',
    51: 'Drizzle: Light',
    53: 'Drizzle: Moderate',
    55: 'Drizzle: Dense intensity',
    56: 'Freezing Drizzle: Light',
    57: 'Freezing Drizzle: Dense intensity',
    61: 'Rain: Slight',
    63: 'Rain: Moderate',
    65: 'Rain: Heavy intensity',
    66: 'Freezing Rain: Light',
    67: 'Freezing Rain: Heavy intensity',
    71: 'Snow fall: Slight',
    73: 'Snow fall: Moderate',
    75: 'Snow fall: Heavy intensity',
    77: 'Snow grains',
    80: 'Rain showers: Slight',
    81: 'Rain showers: Moderate',
    82: 'Rain showers: Violent',
    85: 'Snow showers slight',
    86: 'Snow showers heavy',
    95: 'Thunderstorm: Slight or moderate',
    96: 'Thunderstorm with slight hail',
    99: 'Thunderstorm with heavy hail',
  };
  int? weatherCode = weatherCodeValue as int?;

  return weatherCodes[weatherCode] ?? 'Unknown Weather';
}
