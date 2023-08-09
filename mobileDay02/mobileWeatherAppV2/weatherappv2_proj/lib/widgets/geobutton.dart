import 'package:flutter/material.dart';
import '../services/gps.dart';
import 'widgets.dart';

class GeoLocationButton extends StatelessWidget {
  final Function(Map<String, dynamic>?) onLocationSelected;
  final UpdateTextCallback updateText;
  final Color color;

  const GeoLocationButton(
      {super.key,
      required this.updateText,
      required this.color,
      required this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.location_on, color: color),
      onPressed: () async {
        Map<String, dynamic>? coordinates = await getCoordinates();
        if (coordinates != null) {
          onLocationSelected({
            'latitude': coordinates['latitude'].toString(),
            'longitude': coordinates['longitude'].toString(),
            'name': null,
            'country': null,
            'admin1': null
          });
        } else {
          updateText(
            null,
            DisplayTextState.geolocationError,
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>?> getCoordinates() async {
    final gpsService = GpsService();

    if (!await gpsService.isLocationServiceEnabled()) {
      await gpsService.requestLocationService();
    }
    PermissionStatus permission = await gpsService.getLocationPermission();
    if (permission == PermissionStatus.granted) {
      LocationData? locationData = await gpsService.getCurrentLocation();
      if (locationData != null) {
        return {
          'latitude': locationData.latitude,
          'longitude': locationData.longitude
        };
      }
    }
    return null;
  }
}
