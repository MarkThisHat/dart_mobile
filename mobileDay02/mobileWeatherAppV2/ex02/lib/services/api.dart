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
