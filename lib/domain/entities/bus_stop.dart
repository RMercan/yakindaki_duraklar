import 'package:equatable/equatable.dart';

class BusStop extends Equatable {
  const BusStop({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.routes,
    this.distanceMeters,
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String? routes;
  // Distance to the user; may be null for stops loaded from favorites
  final double? distanceMeters;

  BusStop copyWith({double? distanceMeters}) {
    return BusStop(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      routes: routes,
      distanceMeters: distanceMeters ?? this.distanceMeters,
    );
  }

  // Distance changes with location, so it is ignored in equality
  @override
  List<Object?> get props => [id, name, latitude, longitude, routes];
}
