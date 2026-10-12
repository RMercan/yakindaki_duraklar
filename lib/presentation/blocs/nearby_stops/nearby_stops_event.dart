part of 'nearby_stops_bloc.dart';

sealed class NearbyStopsEvent {
  const NearbyStopsEvent();
}

class NearbyStopsRequested extends NearbyStopsEvent {
  const NearbyStopsRequested({
    required this.latitude,
    required this.longitude,
    this.radiusMeters = AppConstants.defaultRadiusMeters,
  });

  final double latitude;
  final double longitude;
  final int radiusMeters;
}
