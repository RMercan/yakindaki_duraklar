import '../../core/constants/app_constants.dart';
import '../../domain/entities/bus_stop.dart';

class BusStopModel extends BusStop {
  const BusStopModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    super.routes,
    super.distanceMeters,
  });

  // Overpass node element: {"id":1,"lat":..,"lon":..,"tags":{"name":..,"route_ref":..}}
  factory BusStopModel.fromOverpass(Map<String, dynamic> json) {
    final tags = (json['tags'] as Map<String, dynamic>?) ?? const {};
    return BusStopModel(
      id: json['id'].toString(),
      name: (tags['name'] as String?) ?? AppConstants.unnamedStop,
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lon'] as num).toDouble(),
      routes: (tags['route_ref'] as String?) ?? (tags['bus_routes'] as String?),
    );
  }

  factory BusStopModel.fromJson(Map<String, dynamic> json) {
    return BusStopModel(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      routes: json['routes'] as String?,
    );
  }

  factory BusStopModel.fromEntity(BusStop stop) {
    return BusStopModel(
      id: stop.id,
      name: stop.name,
      latitude: stop.latitude,
      longitude: stop.longitude,
      routes: stop.routes,
    );
  }

  // Distance is not persistent data, so it is not saved
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'routes': routes,
    };
  }
}
