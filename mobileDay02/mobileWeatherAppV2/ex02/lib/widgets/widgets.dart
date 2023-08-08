export 'topbar.dart';
export 'body.dart';
export 'footbar.dart';
export 'bodyoverlay.dart';
export '../services/api.dart';

typedef UpdateTextCallback = void Function(String?, DisplayTextState);

enum DisplayTextState {
  geolocationError,
  apiError,
  submissionError,
  valid,
}

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
}
