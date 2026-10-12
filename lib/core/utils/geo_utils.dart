import 'dart:math' as math;

class GeoUtils {
  const GeoUtils._();

  static const double _earthRadiusMeters = 6371000;

  // Haversine: straight-line distance between two coordinates (meters)
  static double distanceMeters({
    required double fromLatitude,
    required double fromLongitude,
    required double toLatitude,
    required double toLongitude,
  }) {
    final deltaLatitude = _toRadians(toLatitude - fromLatitude);
    final deltaLongitude = _toRadians(toLongitude - fromLongitude);
    final a =
        math.pow(math.sin(deltaLatitude / 2), 2) +
        math.cos(_toRadians(fromLatitude)) *
            math.cos(_toRadians(toLatitude)) *
            math.pow(math.sin(deltaLongitude / 2), 2);
    return 2 * _earthRadiusMeters * math.asin(math.sqrt(a));
  }

  static String formatDistance(double meters) {
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  static double _toRadians(double degrees) => degrees * math.pi / 180;
}
