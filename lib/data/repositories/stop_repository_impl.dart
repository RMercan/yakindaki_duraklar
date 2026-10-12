import '../../core/utils/geo_utils.dart';
import '../../domain/entities/bus_stop.dart';
import '../../domain/repositories/stop_repository.dart';
import '../datasources/overpass_stop_source.dart';

class StopRepositoryImpl implements StopRepository {
  const StopRepositoryImpl(this._source);

  final OverpassStopSource _source;

  @override
  Future<List<BusStop>> getNearbyStops({
    required double latitude,
    required double longitude,
    required int radiusMeters,
  }) async {
    final models = await _source.fetchStops(
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
    );
    final stops = models
        .map(
          (model) => model.copyWith(
            distanceMeters: GeoUtils.distanceMeters(
              fromLatitude: latitude,
              fromLongitude: longitude,
              toLatitude: model.latitude,
              toLongitude: model.longitude,
            ),
          ),
        )
        .toList();
    stops.sort((a, b) => a.distanceMeters!.compareTo(b.distanceMeters!));
    return stops;
  }
}
