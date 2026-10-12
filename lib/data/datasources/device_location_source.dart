import 'package:geolocator/geolocator.dart';

import '../../core/error/app_exceptions.dart';
import '../../domain/entities/user_location.dart';

class DeviceLocationSource {
  const DeviceLocationSource();

  Future<UserLocation> readCurrentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationException(LocationFailureReason.serviceDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw const LocationException(LocationFailureReason.permissionDenied);
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
        LocationFailureReason.permissionDeniedForever,
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      return UserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (_) {
      throw const LocationException(LocationFailureReason.unknown);
    }
  }
}
