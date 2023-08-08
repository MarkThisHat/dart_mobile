import 'dart:convert';
import 'package:http/http.dart' as http;
export 'package:http/http.dart';

Future<List<Map<String, dynamic>>?> searchLocationByName(String searchTerm,
    {int count = 5, String format = 'json', String language = 'en'}) async {
  const baseUrl = 'https://geocoding-api.open-meteo.com/v1/search';
  final url = Uri.parse(
      '$baseUrl?name=$searchTerm&count=$count&format=$format&language=$language');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse is Map<String, dynamic> &&
        jsonResponse.containsKey('results')) {
      final results = jsonResponse['results'];
      if (results is List) {
        return List<Map<String, dynamic>>.from(results);
      }
    }
  }
  return null;
}

Future<Map<String, dynamic>> fetchWeather(
    double latitude, double longitude) async {
  // Base URL for the API
  const baseUrl = 'https://api.open-meteo.com/v1/forecast';

  // Parameters required for the request
  var queryParams = {
    'latitude': latitude.toString(),
    'longitude': longitude.toString(),
    'current_weather': 'true',
    'hourly': 'temperature_2m,weathercode,windspeed_10m',
    'daily': 'temperature_2m_max,temperature_2m_min,weathercode',
    'timezone':
        'auto' // This makes sure that timestamps match the location's timezone
  };

  // Constructing the full URL
  final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
  print('Request: $uri');
  // Making the GET request
  final response = await http.get(uri);

  // Decoding the response
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch weather data');
  }
}
