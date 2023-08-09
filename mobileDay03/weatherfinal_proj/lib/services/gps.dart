import 'package:location/location.dart';
export 'package:location/location.dart';

class GpsService {
  final Location location = Location();

  Future<bool> isLocationServiceEnabled() async {
    return await location.serviceEnabled();
  }

  Future<bool> requestLocationService() async {
    bool? serviceEnabled = await location.requestService();
    return serviceEnabled;
  }

  Future<PermissionStatus> getLocationPermission() async {
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
    }
    return permission;
  }

  Future<LocationData?> getCurrentLocation() async {
    try {
      return await location.getLocation();
    } catch (e) {
      print("Error fetching location: $e");
      return null;
    }
  }

  Stream<LocationData> getLocationStream() {
    return location.onLocationChanged;
  }
}
