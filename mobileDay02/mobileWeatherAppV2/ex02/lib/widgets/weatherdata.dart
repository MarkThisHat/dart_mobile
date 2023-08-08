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
    WeatherLocation location, Map<String, dynamic>? weather) {
  int n = 8;
  List<String> list = List<String>.filled(n, '');

  print('Location: $location');
  print('API response: $weather');
  return null;
}
