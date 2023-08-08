import 'package:flutter/material.dart';
import '../services/gps.dart';
import 'widgets.dart';

class GeoLocationButton extends StatelessWidget {
  final UpdateTextCallback updateText;
  final Color color;

  const GeoLocationButton({
    super.key,
    required this.updateText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.location_on, color: color),
      onPressed: () async {
        String? coordinates = await getCoordinates();
        updateText(
          coordinates,
          coordinates != null
              ? DisplayTextState.valid
              : DisplayTextState.geolocationError,
        );
      },
    );
  }

  Future<String?> getCoordinates() async {
    final gpsService = GpsService();

    if (!await gpsService.isLocationServiceEnabled()) {
      await gpsService.requestLocationService();
    }
    PermissionStatus permission = await gpsService.getLocationPermission();
    if (permission == PermissionStatus.granted) {
      LocationData? locationData = await gpsService.getCurrentLocation();
      if (locationData != null) {
        return '${locationData.latitude},${locationData.longitude}';
      }
    }
    return null;
  }
}
